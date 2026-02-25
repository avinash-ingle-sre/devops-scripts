#!/bin/bash
. ./task03_provision_function.sh 2>/dev/null || true
# If the function file doesn't exist, source inline minimal function
if ! declare -f provision_server >/dev/null; then
  provision_server() {
    local server="$1"; local type="$2"
    mkdir -p /tmp/configs
    echo "Provisioning $server as $type (simulated)"
    cat > /tmp/configs/${server}.state <<STATE
hostname=${server}
type=${type}
status=provisioned
timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
STATE
  }
fi

pids=()
for i in 1 2 3; do
  provision_server "web-0${i}.example.com" "web" &
  pids+=($!)
done
provision_server "db-01.example.com" "database" &
pids+=($!)
provision_server "cache-01.example.com" "cache" &
pids+=($!)

for pid in "${pids[@]}"; do
  wait "${pid}" 2>/dev/null || true
done
echo "Parallel provisioning (simulated) complete."
