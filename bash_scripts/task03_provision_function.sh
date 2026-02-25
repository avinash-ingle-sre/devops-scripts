#!/bin/bash
mkdir -p /tmp/configs
provision_server() {
  local server="$1"; local type="$2"
  echo "Provisioning $server as $type (simulated)"
  cat > /tmp/configs/${server}.state <<STATE
hostname=${server}
type=${type}
status=provisioned
timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
STATE
  echo "State written: /tmp/configs/${server}.state"
}
# Example usage
provision_server "web-01.example.com" "web"
