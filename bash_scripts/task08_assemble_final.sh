#!/bin/bash
cat > /tmp/infrastructure_automation.sh <<'SCRIPT'
#!/bin/bash
# /tmp/infrastructure_automation.sh
# Simulated infrastructure automation demo (safe for labs)
# Usage: run the script; it simulates provisioning, config, deployment and reports.

SERVERS_FILE="/tmp/servers.txt"
SSH_KEY="/tmp/deploy_key"
CONFIG_DIR="/tmp/configs"
ANSIBLE_PLAYBOOK="/tmp/playbook.yml"

printf "🏗️ Infrastructure Automation System\n"
printf "===================================\n"

# Setup directories
mkdir -p "${CONFIG_DIR}"

# Create server inventory
cat << SERVERS > "${SERVERS_FILE}"
web-01.example.com
web-02.example.com
web-03.example.com
db-01.example.com
cache-01.example.com
SERVERS

# Create SSH key (simulated)
cat << KEY > "${SSH_KEY}"
-----BEGIN OPENSSH PRIVATE KEY-----
(simulated-key-content)
-----END OPENSSH PRIVATE KEY-----
KEY
chmod 600 "${SSH_KEY}"

# Create server configuration template
cat << 'TEMPLATE' > "${CONFIG_DIR}/server_config.sh"
#!/bin/bash
HOSTNAME="$(hostname)"
SERVER_TYPE="$1"

# System hardening (simulated)
echo "Applying sysctl settings..."
# sysctl -w net.ipv4.tcp_syncookies=1
# sysctl -w net.ipv4.ip_forward=0

# Install base packages (simulated)
echo "Installing base packages: nginx docker prometheus-node-exporter fail2ban"

# Configure firewall (simulated)
echo "Configuring UFW rules (22,80,443)"

# Setup monitoring (simulated)
echo "Enabling node exporter (simulated)"

# Configure based on server type
case "$SERVER_TYPE" in
    "web")
        echo "Configuring nginx for web server"
        ;;
    "database")
        echo "Configuring database firewall rules"
        ;;
    "cache")
        echo "Configuring cache firewall rules"
        ;;
esac

echo "Server $HOSTNAME configured as $SERVER_TYPE"
TEMPLATE

# Function: Provision server (simulated)
provision_server() {
    local server="$1"
    local server_type="$2"

    printf "\n🖥️ Provisioning %s as %s server...\n" "$server" "$server_type"

    # Simulate SSH connection and configuration
    printf "  Connecting via SSH (simulated)...\n"
    sleep 1

    printf "  Installing packages (simulated)...\n"
    sleep 1

    printf "  Configuring firewall (simulated)...\n"
    sleep 1

    printf "  Setting up monitoring (simulated)...\n"
    sleep 1

    # Create server state file
    cat << STATE > "${CONFIG_DIR}/${server}.state"
hostname=${server}
type=${server_type}
status=provisioned
timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
packages="nginx docker prometheus-node-exporter"
firewall_rules="22/tcp 80/tcp 443/tcp"
monitoring=enabled
STATE

    printf "  ✅ %s provisioned successfully\n" "$server"
    return 0
}

# Function: Deploy application (simulated)
deploy_application() {
    local server="$1"

    printf "  Deploying application to %s (simulated)...\n" "$server"

    # Create deployment script (simulated)
    cat << 'DEPLOY' > "${CONFIG_DIR}/deploy_app.sh"
#!/bin/bash
echo "Simulated: docker pull myapp:latest"
echo "Simulated: stop and run container myapp"
DEPLOY

    chmod +x "${CONFIG_DIR}/deploy_app.sh"
    sleep 1
    printf "  ✅ Application deployed to %s (simulated)\n" "$server"
}

# Function: Configure load balancer (simulated)
configure_load_balancer() {
    printf "\n⚖️ Configuring load balancer...\n"

    cat << 'NGINX' > "${CONFIG_DIR}/load_balancer.conf"
upstream backend {
    ip_hash;
    server web-01.example.com:8080 max_fails=3 fail_timeout=30s;
    server web-02.example.com:8080 max_fails=3 fail_timeout=30s;
    server web-03.example.com:8080 max_fails=3 fail_timeout=30s;
}

server {
    listen 80;
    server_name app.example.com;

    location / {
        proxy_pass http://backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_connect_timeout 60s;
        proxy_read_timeout 60s;
    }

    location /health {
        access_log off;
        return 200 "healthy\n";
    }
}
NGINX

    printf "✅ Load balancer configured with 3 backend servers (simulated)\n"
}

# Function: Setup monitoring (simulated)
setup_monitoring() {
    printf "\n📊 Setting up monitoring...\n"

    cat << 'PROMETHEUS' > "${CONFIG_DIR}/prometheus.yml"
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'infrastructure'
    static_configs:
      - targets:
        - 'web-01.example.com:9100'
        - 'web-02.example.com:9100'
        - 'web-03.example.com:9100'
        - 'db-01.example.com:9100'
        - 'cache-01.example.com:9100'
    labels:
      environment: 'production'

  - job_name: 'applications'
    static_configs:
      - targets:
        - 'web-01.example.com:8080'
        - 'web-02.example.com:8080'
        - 'web-03.example.com:8080'
    metrics_path: '/metrics'
PROMETHEUS

    printf "✅ Monitoring configured for all servers (simulated)\n"
}

# Function: Parallel provisioning (simulated)
provision_all_servers() {
    printf "\n🚀 Starting parallel provisioning (simulated)...\n"

    local pids=()

    # Provision web servers
    for i in 1 2 3; do
        server="web-0${i}.example.com"
        provision_server "${server}" "web" &
        pids+=(${!})
    done

    # Provision database and cache
    provision_server "db-01.example.com" "database" &
    pids+=(${!})
    provision_server "cache-01.example.com" "cache" &
    pids+=(${!})

    # Wait for all provisioning to complete
    printf "\n⏳ Waiting for all servers to provision...\n"
    for pid in "${pids[@]}"; do
        wait "${pid}" 2>/dev/null || true
    done

    printf "\n✅ All servers provisioned (simulated)!\n"
}

# Function: Health check all servers (simulated)
health_check_infrastructure() {
    printf "\n🏥 Running infrastructure health checks (simulated)...\n"

    local healthy=0
    local total=0

    while IFS= read -r server; do
        printf "  Checking %s... " "$server"
        ((total++))
        if [ -f "${CONFIG_DIR}/${server}.state" ]; then
            printf "✅ HEALTHY\n"
            ((healthy++))
        else
            printf "❌ UNHEALTHY\n"
        fi
    done < "${SERVERS_FILE}"

    printf "\nHealth Summary: %d/%d servers healthy\n" "${healthy}" "${total}"

    if [ "${healthy}" -eq "${total}" ]; then
        return 0
    else
        return 1
    fi
}

# Function: Generate infrastructure report (simulated)
generate_infrastructure_report() {
    printf "\n📋 Infrastructure Report\n"
    printf "========================\n"
    printf "Timestamp: %s\n" "$(date -u +%Y-%m-%dT%H:%M:%SZ)"

    # Count servers by type (simulated)
    local web_count=$(grep -c '^web-' "${SERVERS_FILE}" 2>/dev/null || echo 0)
    local db_count=$(grep -c '^db-' "${SERVERS_FILE}" 2>/dev/null || echo 0)
    local cache_count=$(grep -c '^cache-' "${SERVERS_FILE}" 2>/dev/null || echo 0)
    local total=$((web_count + db_count + cache_count))

    printf "\nServer Inventory:\n"
    printf "  Web Servers: %d\n" "${web_count}"
    printf "  Database Servers: %d\n" "${db_count}"
    printf "  Cache Servers: %d\n" "${cache_count}"
    printf "  Total: %d\n" "${total}"

    printf "\nConfiguration:\n"
    printf "  Load Balancer: ✅ Configured (simulated)\n"
    printf "  Monitoring: ✅ Enabled (simulated)\n"
    printf "  Firewall: ✅ Active (simulated)\n"
    printf "  Auto-scaling: ✅ Ready (simulated)\n"

    printf "\nCompliance Status:\n"
    printf "  Security Hardening: ✅ Applied (simulated)\n"
    printf "  Patch Level: ✅ Current (simulated)\n"
    printf "  Backup: ✅ Configured (simulated)\n"
}

# Main execution (simulated)
printf "Starting infrastructure automation (simulated)...\n"

# Phase 1: Provision servers
provision_all_servers

# Phase 2: Deploy applications to web servers
printf "\n📦 Deploying applications to web servers (simulated)...\n"
for i in 1 2 3; do
    deploy_application "web-0${i}.example.com"
done

# Phase 3: Configure load balancer
configure_load_balancer

# Phase 4: Setup monitoring
setup_monitoring

# Phase 5: Health check
if health_check_infrastructure; then
    printf "\n✅ Infrastructure ready (simulated)!\n"
else
    printf "\n⚠️ Some servers need attention (simulated)\n"
fi

# Generate report
generate_infrastructure_report

printf "\n🎉 Infrastructure automation complete (simulated)!\n"
printf "📁 Configuration files: %s\n" "${CONFIG_DIR}"
printf "📊 Server inventory: %s\n" "${SERVERS_FILE}"

SCRIPT
chmod +x /tmp/infrastructure_automation.sh
echo "Final automation script created: /tmp/infrastructure_automation.sh"
