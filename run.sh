#!/bin/bash

echo "starting socks5 proxy"
ssh -fqND localhost:1080 -i secrets/sock5_proxy.id_rsa root@maddash.aglt2.org

echo "starting redsocks (using default config path ./redsocks.conf)"
./redsocks

echo "setting up iptables for LHCONE hosts"
sudo /sbin/iptables -t nat -N REDSOCKS
sudo /sbin/iptables -t nat -A REDSOCKS -p tcp -d lhcone.test.manlan.internet2.edu -j REDIRECT --to-ports 12380
sudo /sbin/iptables -t nat -A OUTPUT -p tcp -j REDSOCKS

echo "listing nat table"
sudo /sbin/iptables -L -t nat
