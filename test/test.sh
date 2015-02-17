#!/bin/bash

#test accessing lhcone site via socks5 proxy
curl -k -s -m10 --socks5 localhost:1080 https://lhcone.test.manlan.internet2.edu/toolkit/?format=json > /dev/null
ret=$?
if [ $ret -ne 0 ]; then
    echo "curl returned $ret while trying socks5 proxy"
fi

#test accessing lhcone site via redsocks
curl -k -s -m10 https://lhcone.test.manlan.internet2.edu/toolkit/?format=json > /dev/null
ret=$?
if [ $ret -ne 0 ]; then
    echo "curl returned $ret while trying redsocks"
fi

