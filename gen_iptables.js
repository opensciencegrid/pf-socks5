var ping = require('ping');
var http = require('http');
var config = require('./config');
var async = require('async');
var fs = require('fs');

main();

function main() {
    load_meshconfig(function(err, json) {
        if(err) throw err;
        parse_meshconfig(json, function(err, addrs) {
            ping_test(addrs, function(err, failed_ones) {
                output_iptables(failed_ones);
            });
        });
    });
}

function output_iptables(addrs) {
    fs.open(config.output, 'w', function(err, fd) {
        fs.writeSync(fd, '/sbin/iptables -t nat -N REDSOCKS\n');
        addrs.forEach(function(addr) {
            fs.writeSync(fd, '/sbin/iptables -t nat -A REDSOCKS -p tcp -d '+addr+' -j REDIRECT --to-ports '+config.redsocks_port+'\n');
        });
        fs.writeSync(fd, '/sbin/iptables -t nat -A OUTPUT -p tcp -j REDSOCKS\n');
        fs.closeSync(fd);

        console.log("writen new iptasble "+config.output);
    });
}

function ping_test(addrs, done) {
    var failed_ones = [];
    async.map(addrs, function(addr, next) {
        ping.sys.probe(addr, function(alive) {
            if(!alive) failed_ones.push(addr);
            next(null);
        });
    }, function(err) {
        done(null, failed_ones);
    });
}

function parse_meshconfig(json, done) {
    var addrs = [];
    json.organizations.forEach(function(org) {
        org.sites.forEach(function(site) {
            site.hosts.forEach(function(host) {
                host.addresses.forEach(function(addr) {
                    if(addrs.indexOf(addr) == -1) addrs.push(addr);
                });
            });
        });
    });
    done(null, addrs);
}

function load_meshconfig(done) {
    http.get(config.lhcone_mesh, function(res) {
        var body = '';
        res.on('data', function(chunk) {
            body += chunk;
        });
        res.on('end', function() {
            var json = JSON.parse(body)
            done(null, json);
        });
    }).on('error', function(e) {
          console.log("Got error: ", e);
    });
}
