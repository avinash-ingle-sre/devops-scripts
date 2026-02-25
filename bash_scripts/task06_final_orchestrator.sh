#!/bin/bash
# /tmp/service_orchestrator.sh
# Simple service orchestration demo (simulated services)
# Usage: ./service_orchestrator.sh start|stop|restart|status

SERVICES_DIR="/tmp/services"
PIDS_DIR="/tmp/pids"
LOGS_DIR="/tmp/service_logs"

# Service definitions: name:port:deps (deps comma-separated)
declare -A SERVICE_PORTS=(
  ["database"]="5432"
  ["cache"]="6379"
  ["api"]="8080"
  ["webserver"]="80"
)
declare -A SERVICE_DEPS=(
  ["database"]=""
  ["cache"]=""
  ["api"]="database,cache"
  ["webserver"]="api"
)

mkdir -p "${SERVICES_DIR}" "${PIDS_DIR}" "${LOGS_DIR}"

# Create simple simulated service scripts
setup_services() {
  echo "Creating service scripts in ${SERVICES_DIR}..."

  cat > "${SERVICES_DIR}/database.sh" <<'DB'
#!/bin/bash
port=5432
echo "Database (sim) listening on port $port"
# simulate a long-running process
while true; do
  sleep 5
done
DB

  cat > "${SERVICES_DIR}/cache.sh" <<'CACHE'
#!/bin/bash
port=6379
echo "Cache (sim) listening on port $port"
while true; do
  sleep 5
done
CACHE

  cat > "${SERVICES_DIR}/api.sh" <<'API'
#!/bin/bash
port=8080
echo "API (sim) starting; requires database & cache"
# simulate dependency wait (in real life check ports/health)
while true; do
  sleep 3
done
API

  cat > "${SERVICES_DIR}/webserver.sh" <<'WEB'
#!/bin/bash
port=80
echo "Webserver (sim) starting; proxies to API"
while true; do
  sleep 4
done
WEB

  chmod +x "${SERVICES_DIR}"/*.sh
  echo "Service scripts created."
}

timestamp() { date '+%Y-%m-%d %H:%M:%S'; }

# Basic health check stub: simulate success after a moment
check_service_health() {
  local svc="$1"
  local tries=5
  local i=1
  echo -n "Health check ${svc}: "
  while [ $i -le $tries ]; do
    # In a real script, check via curl, nc, or health endpoint.
    if [ $i -ge 3 ]; then
      echo "OK"
      return 0
    fi
    echo -n "."
    sleep 1
    i=$((i+1))
  done
  echo "FAIL"
  return 1
}

start_service() {
  local svc="$1"
  local script="${SERVICES_DIR}/${svc}.sh"
  local pidfile="${PIDS_DIR}/${svc}.pid"
  local logfile="${LOGS_DIR}/${svc}.log"

  echo "Starting ${svc} ..."
  # Check dependencies
  local deps="${SERVICE_DEPS[$svc]}"
  if [ -n "${deps}" ]; then
    IFS=',' read -ra DEP_ARR <<< "${deps}"
    for d in "${DEP_ARR[@]}"; do
      if [ ! -f "${PIDS_DIR}/${d}.pid" ]; then
        echo "  Dependency ${d} not running. Cannot start ${svc}."
        return 1
      fi
      if ! check_service_health "${d}"; then
        echo "  Dependency ${d} unhealthy. Cannot start ${svc}."
        return 1
      fi
    done
    echo "  Dependencies satisfied for ${svc}."
  fi

  nohup "${script}" > "${logfile}" 2>&1 &
  echo $! > "${pidfile}"
  sleep 1

  if check_service_health "${svc}"; then
    echo "  ${svc} started (PID: $(cat "${pidfile}"))"
    return 0
  else
    echo "  ${svc} failed to become healthy. Stopping."
    stop_service "${svc}"
    return 1
  fi
}

stop_service() {
  local svc="$1"
  local pidfile="${PIDS_DIR}/${svc}.pid"
  if [ -f "${pidfile}" ]; then
    local pid=$(cat "${pidfile}")
    echo -n "Stopping ${svc} (PID: ${pid}) ... "
    if kill -15 "${pid}" 2>/dev/null; then
      sleep 1
      if kill -0 "${pid}" 2>/dev/null; then
        kill -9 "${pid}" 2>/dev/null || true
      fi
      echo "stopped"
    else
      echo "already stopped"
    fi
    rm -f "${pidfile}"
  else
    echo "${svc} not running"
  fi
}

show_service_status() {
  echo
  echo "Service status (as of $(timestamp))"
  echo "----------------------------------"
  local all_ok=true
  for svc in database cache api webserver; do
    local pidfile="${PIDS_DIR}/${svc}.pid"
    if [ -f "${pidfile}" ]; then
      local pid=$(cat "${pidfile}")
      if kill -0 "${pid}" 2>/dev/null; then
        echo "  ${svc}: RUNNING (PID: ${pid})"
      else
        echo "  ${svc}: DEAD (stale PID)"
        all_ok=false
      fi
    else
      echo "  ${svc}: STOPPED"
      all_ok=false
    fi
  done
  echo
  if $all_ok; then
    echo "Overall: ALL SERVICES RUNNING"
  else
    echo "Overall: SOME SERVICES NOT RUNNING"
  fi
}

start_all_services() {
  echo "Starting services in dependency order..."
  local order=(database cache api webserver)
  for svc in "${order[@]}"; do
    if ! start_service "${svc}"; then
      echo "Failed to start ${svc}; aborting startup."
      return 1
    fi
    sleep 1
  done
  echo "All requested services started."
}

stop_all_services() {
  echo "Stopping services in reverse order..."
  local order=(webserver api cache database)
  for svc in "${order[@]}"; do
    stop_service "${svc}"
  done
  echo "All requested services stopped."
}

restart_all_services() {
  stop_all_services
  sleep 1
  start_all_services
}

# Main
setup_services

case "$1" in
  start)
    start_all_services
    show_service_status
    ;;
  stop)
    stop_all_services
    ;;
  restart)
    restart_all_services
    show_service_status
    ;;
  status)
    show_service_status
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
    # In lab environment, don't exit - just show error
    echo "Error: Invalid command"
    ;;
esac

