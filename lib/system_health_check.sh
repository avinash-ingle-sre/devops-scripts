#!/bin/bash
echo "📊 System Health Report:"
uptime
free -h
df -h /
top -bn1 | head -20
