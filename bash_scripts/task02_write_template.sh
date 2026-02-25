#!/bin/bash
mkdir -p /tmp/configs
cat > /tmp/configs/server_config.sh <<'TEMPLATE'
#!/bin/bash
# server_config.sh - template (simulated)
HOSTNAME="$(hostname)"
SERVER_TYPE="$1"
echo "Applying simulated config for $HOSTNAME type $SERVER_TYPE"
TEMPLATE
chmod +x /tmp/configs/server_config.sh
echo "Template created at /tmp/configs/server_config.sh"
