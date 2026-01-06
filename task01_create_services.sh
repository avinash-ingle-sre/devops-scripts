#!/bin/bash
# creates simple simulated service scripts under /tmp/services
mkdir -p /tmp/services
cat > /tmp/services/database.sh <<'DB'
#!/bin/bash
echo "Database (sim) listening on port 5432"
while true; do sleep 5; done
DB
cat > /tmp/services/cache.sh <<'CACHE'
#!/bin/bash
echo "Cache (sim) listening on port 6379"
while true; do sleep 5; done
CACHE
cat > /tmp/services/api.sh <<'API'
#!/bin/bash
echo "API (sim) starting"
while true; do sleep 3; done
API
cat > /tmp/services/webserver.sh <<'WEB'
#!/bin/bash
echo "Webserver (sim) starting"
while true; do sleep 4; done
WEB
chmod +x /tmp/services/*.sh
echo "Service scripts created in /tmp/services"
