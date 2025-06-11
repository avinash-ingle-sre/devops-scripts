#!/bin/bash

# service_checker.sh - Checks status of services and restarts if not running.

SERVICES=("nginx" "mysql" "docker")  # इच्छेनुसार इथे सर्व्हिस नावे द्या
LOG_FILE="/var/log/service_checker.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Function: log message
log() {
    echo "$DATE - $1" | tee -a "$LOG_FILE"
}

# Function: check and restart services
check_services() {
    for service in "${SERVICES[@]}"; do
        if systemctl is-active --quiet "$service"; then
            log "✅ $service is running"
        else
            log "❗ $service is NOT running, attempting restart..."
            systemctl restart "$service"
            if systemctl is-active --quiet "$service"; then
                log "✅ $service restarted successfully"
            else
                log "❌ Failed to restart $service"
            fi
        fi
    done
}

# Main execution
log "🔍 Starting service check..."
check_services
log "✅ Service check complete"

