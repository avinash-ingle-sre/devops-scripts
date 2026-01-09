#!/usr/bin/env python3
# Simple Docker Compose configuration generator
# Note: All operations are mocked to avoid external dependencies

import json

services = ["web", "api", "database"]

print("=== Simple Docker Compose Generator ===")

compose_config = {
    "version": "3.8",
    "services": {}
}

# Generate service configurations using a loop
for service in services:
    print(f"\n📦 Configuring {service} service...")
    
    # Basic service configuration
    service_config = {
        "image": f"{service}:latest",
        "restart": "unless-stopped"
    }
    
    # Add service-specific configurations
    if service == "web":
        service_config["ports"] = ["80:80"]
        service_config["depends_on"] = ["api"]
    elif service == "api":
        service_config["ports"] = ["3000:3000"]
        service_config["depends_on"] = ["database"]
        service_config["environment"] = {
            "NODE_ENV": "production",
            "DB_HOST": "database"
        }
    elif service == "database":
        service_config["ports"] = ["5432:5432"]
        service_config["environment"] = {
            "POSTGRES_DB": "myapp",
            "POSTGRES_USER": "user"
        }
        service_config["volumes"] = ["db-data:/var/lib/postgresql/data"]
    
    compose_config["services"][service] = service_config
    print(f"  ✅ {service} configured with {len(service_config)} settings")

# Add volumes section
compose_config["volumes"] = {
    "db-data": {"driver": "local"}
}

# Save configuration
with open("/tmp/docker-compose-simple.json", "w") as f:
    json.dump(compose_config, f, indent=2)

print(f"\n📊 Generated Docker Compose with {len(compose_config['services'])} services")
print("💾 Saved to: /tmp/docker-compose-simple.json")
