#!/bin/bash

# disk_monitor.sh - Monitors disk usage and alerts if it exceeds threshold.

THRESHOLD=80
LOG_FILE="/var/log/disk_monitor.log"
HOSTNAME=$(hostname)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Function: log message
log() {
    echo "$DATE - $1" | tee -a "$LOG_FILE"
}

# Function: check disk usage
check_disks() {
    df -h --output=source,pcent,target | grep -vE '^Filesystem|tmpfs|cdrom' | while read line; do
        USAGE=$(echo "$line" | awk '{print $2}' | tr -d '%')
        MOUNT=$(echo "$line" | awk '{print $3}')
        if [ "$USAGE" -ge "$THRESHOLD" ]; then
            log "❗ ALERT: Disk usage on $MOUNT is ${USAGE}% (Threshold: ${THRESHOLD}%) on $HOSTNAME"
        else
            log "✅ OK: Disk usage on $MOUNT is ${USAGE}%"
        fi
    done
}

# Main Execution
log "📊 Disk Usage Monitoring Started"
check_disks
log "✅ Monitoring Completed"

