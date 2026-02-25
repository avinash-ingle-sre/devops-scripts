#!/bin/bash
# production_monitor.sh - demo monitoring script

LOG_FILE="/tmp/production_monitor.log"
timestamp() { date '+%Y-%m-%d %H:%M:%S'; }

send_alert() {
  local severity="$1"; shift
  local message="$*"
  echo "$(timestamp) ALERT ${severity}: ${message}" | tee -a "$LOG_FILE"
}

check_system() {
  CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print $2}' | sed 's/,/./' | awk '{printf("%d",$1)}' 2>/dev/null || echo 5)
  MEM_USAGE=$(free | awk '/Mem:/ {printf("%.0f",$3/$2*100)}' 2>/dev/null || echo 30)
  DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//' 2>/dev/null || echo 10)
  echo "$(timestamp) System CPU:${CPU_USAGE}% MEM:${MEM_USAGE}% DISK:${DISK_USAGE}%" | tee -a "$LOG_FILE"

  [ "$CPU_USAGE" -gt 90 ] && send_alert CRITICAL "CPU ${CPU_USAGE}%"
  [ "$CPU_USAGE" -gt 50 ] && send_alert WARNING "CPU ${CPU_USAGE}%"
  [ "$MEM_USAGE" -gt 95 ] && send_alert CRITICAL "Mem ${MEM_USAGE}%"
  [ "$MEM_USAGE" -gt 80 ] && send_alert WARNING "Mem ${MEM_USAGE}%"
  [ "$DISK_USAGE" -gt 90 ] && send_alert CRITICAL "Disk ${DISK_USAGE}%"
  [ "$DISK_USAGE" -gt 80 ] && send_alert WARNING "Disk ${DISK_USAGE}%"
}

check_services() {
  SERVICES=("nginx" "mysql" "redis" "api")
  for s in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$s" 2>/dev/null; then
      echo "$(timestamp) Service ${s}: RUNNING" | tee -a "$LOG_FILE"
    else
      echo "$(timestamp) Service ${s}: NOT_RUNNING" | tee -a "$LOG_FILE"
      send_alert CRITICAL "Service ${s} not running"
    fi
  done
}

check_application() {
  RESP_MS=$((RANDOM % 1000))
  ERR_RATE=$((RANDOM % 10))
  echo "$(timestamp) App resp:${RESP_MS}ms err:${ERR_RATE}%" | tee -a "$LOG_FILE"
  [ "$RESP_MS" -gt 1000 ] && send_alert CRITICAL "Slow response ${RESP_MS}ms"
  [ "$ERR_RATE" -gt 5 ] && send_alert CRITICAL "High error rate ${ERR_RATE}%"
}

summary() {
  echo "Summary:"
  grep "ALERT" "$LOG_FILE" 2>/dev/null | tail -n 10 || echo "No alerts logged"
}

echo "$(timestamp) MONITORING RUN START" >> "$LOG_FILE"
check_system
check_services
check_application
summary
echo "$(timestamp) MONITORING RUN END" >> "$LOG_FILE"

