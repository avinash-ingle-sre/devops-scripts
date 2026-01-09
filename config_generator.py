#!/usr/bin/env python3
# Configuration File Generator
import json
import datetime

print("=== Configuration Generator ===")

# Collect configuration data
app_name = input("Application name: ")
port = input("Port number (default 8080): ") or "8080"
environment = input("Environment (dev/staging/prod): ") or "dev"
debug = input("Enable debug mode? (y/n): ").lower() == 'y'

# Create configuration dictionary
config = {
    "application": {
        "name": app_name,
        "version": "1.0.0",
        "port": int(port),
        "environment": environment,
        "debug": debug
    },
    "database": {
        "host": "localhost",
        "port": 5432,
        "name": f"{app_name}_db"
    },
    "logging": {
        "level": "DEBUG" if debug else "INFO",
        "file": f"/var/log/{app_name}.log"
    },
    "created": datetime.datetime.now().isoformat()
}

# Save as JSON
with open('config.json', 'w') as f:
    json.dump(config, f, indent=2)

print("\n✅ Configuration saved to config.json")

# Display configuration
print("\n=== Generated Configuration ===")
with open('config.json', 'r') as f:
    print(f.read())

# Generate environment variables
print("\n=== Environment Variables ===")
print(f"export APP_NAME={app_name}")
print(f"export APP_PORT={port}")
print(f"export APP_ENV={environment}")
print(f"export DEBUG={'true' if debug else 'false'}")
