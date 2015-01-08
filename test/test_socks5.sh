#!/bin/bash
echo "setting up iptables for LHCONE hosts"
sudo /sbin/iptables -t nat -N REDSOCKS
sudo /sbin/iptables -t nat -A REDSOCKS -p tcp -d lhcone.test.manlan.internet2.edu -j REDIRECT --to-ports 12380
sudo /sbin/iptables -t nat -A OUTPUT -p tcp -j REDSOCKS

echo "listing nat table"
sudo /sbin/iptables -L -t nat

echo "test accessing via socks5"
curl -k --socks5 localhost:1080 https://lhcone.test.manlan.internet2.edu/toolkit/?format=json

echo "test accessing via redsocks"
curl -k https://lhcone.test.manlan.internet2.edu/toolkit/?format=json

