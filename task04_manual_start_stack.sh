#!/bin/bash
./task02_start_database.sh
# start cache similarly
nohup /tmp/services/cache.sh > /tmp/service_logs/cache.log 2>&1 &
echo $! > /tmp/pids/cache.pid
# health checks
./task03_health_check.sh database
./task03_health_check.sh cache
# start api
nohup /tmp/services/api.sh > /tmp/service_logs/api.log 2>&1 &
echo $! > /tmp/pids/api.pid
./task03_health_check.sh api
# start webserver
nohup /tmp/services/webserver.sh > /tmp/service_logs/webserver.log 2>&1 &
echo $! > /tmp/pids/webserver.pid
./task03_health_check.sh webserver
echo "Stack started (manual flow)"
