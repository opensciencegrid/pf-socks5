#!/bin/bash

echo "DEPRECATED use redsocks.ini script instead!"

echo "starting socks5 proxy"
ssh  -o StrictHostKeyChecking=no -fqND localhost:1080 -i secrets/sock5_proxy.id_rsa root@maddash.aglt2.org
echo $! > /var/run/pf-socks5-ssh.pid

echo "starting redsocks (using default config path ./redsocks.conf)"
./redsocks


