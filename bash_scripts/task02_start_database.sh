#!/bin/bash
mkdir -p /tmp/pids /tmp/service_logs
nohup /tmp/services/database.sh > /tmp/service_logs/database.log 2>&1 &
echo $! > /tmp/pids/database.pid
echo "Database started (PID: $(cat /tmp/pids/database.pid))"
