#!/bin/bash
mkdir -p /tmp/configs
cat > /tmp/configs/load_balancer.conf <<LB
# simulated nginx upstream
upstream backend { server web-01.example.com:8080; server web-02.example.com:8080; server web-03.example.com:8080; }
LB
cat > /tmp/configs/prometheus.yml <<PROM
# simulated prometheus config
scrape_configs: []
PROM
echo "Load balancer and monitoring configs created under /tmp/configs"
