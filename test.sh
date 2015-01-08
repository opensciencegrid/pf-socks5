#!/bin/bash

echo "test accessing via socks5"
curl -k --socks5 localhost:1080 https://lhcone.test.manlan.internet2.edu/toolkit/?format=json

echo "test accessing via redsocks"
curl -k https://lhcone.test.manlan.internet2.edu/toolkit/?format=json

