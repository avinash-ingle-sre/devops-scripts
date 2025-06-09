#!/bin/bash

LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/monitor.log"
mkdir -p $LOG_DIR

DATE=$(date '+%Y-%m-%d %H:%M:%S')
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
MEMORY=$(free -m | awk '/Mem:/ {printf "%.2f", $3/$2 * 100}')
DISK=$(df / | awk 'END {print $5}' | sed 's/%//')

echo "===== [$DATE] System Monitoring Report =====" | tee -a $LOG_FILE
echo "CPU Usage: $CPU%" | tee -a $LOG_FILE
echo "Memory Usage: $MEMORY%" | tee -a $LOG_FILE
echo "Disk Usage (/): $DISK%" | tee -a $LOG_FILE

# Alerts
[[ $(echo "$CPU > 80" | bc) -eq 1 ]] && echo "⚠️ ALERT: High CPU usage!" | tee -a $LOG_FILE
[[ $(echo "$MEMORY > 80" | bc) -eq 1 ]] && echo "⚠️ ALERT: High Memory usage!" | tee -a $LOG_FILE
[[ $DISK -gt 90 ]] && echo "⚠️ ALERT: Disk space running low!" | tee -a $LOG_FILE

echo "" >> $LOG_FILE

