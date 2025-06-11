#!/bin/bash
UPTIME_DAYS=$(awk '{print int($1/86400)}' /proc/uptime)
if [ "$UPTIME_DAYS" -gt 7 ]; then
    echo "⚠️ Server is up for $UPTIME_DAYS days. Consider rebooting."
fi
