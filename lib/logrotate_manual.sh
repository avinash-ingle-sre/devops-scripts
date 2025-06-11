#!/bin/bash
LOG_FILE="/var/log/syslog"
cp $LOG_FILE "$LOG_FILE.bak_$(date +%F_%T)"
echo "" > $LOG_FILE
