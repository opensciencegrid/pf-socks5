#!/bin/bash

echo "starting socks5 proxy"
ssh -fqND localhost:1080 -i secrets/sock5_proxy.id_rsa root@maddash.aglt2.org

echo "starting redsocks (using default config path ./redsocks.conf)"
./redsocks

