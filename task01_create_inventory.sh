#!/bin/bash
mkdir -p /tmp/configs
cat > /tmp/servers.txt <<SERVERS
web-01.example.com
web-02.example.com
web-03.example.com
db-01.example.com
cache-01.example.com
SERVERS
echo "Inventory and configs directory created."
