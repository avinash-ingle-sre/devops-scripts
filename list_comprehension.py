#!/usr/bin/env python3
# List comprehensions for configuration processing
# Note: Using mocked service data

services = [
    {"name": "web", "port": 8080, "type": "frontend"},
    {"name": "api", "port": 3000, "type": "backend"},
    {"name": "db", "port": 5432, "type": "database"},
    {"name": "cache", "port": 6379, "type": "cache"}
]

print("=== Configuration Filtering with List Comprehensions ===")

# Filter frontend services using list comprehension
frontend_services = [service for service in services if service["type"] == "frontend"]
print(f"\n🌐 Frontend Services: {len(frontend_services)}")
for service in frontend_services:
    print(f"  • {service['name']} on port {service['port']}")

# Extract service names using list comprehension
service_names = [service["name"] for service in services]
print(f"\n📋 All Service Names: {', '.join(service_names)}")

# Filter services by port range
high_port_services = [s["name"] for s in services if s["port"] > 5000]
print(f"\n🔌 High Port Services (>5000): {', '.join(high_port_services)}")

# Create port mapping dictionary using comprehension
port_mapping = {service["name"]: service["port"] for service in services}
print(f"\n🗺️  Port Mapping:")
for name, port in port_mapping.items():
    print(f"  {name}: {port}")
