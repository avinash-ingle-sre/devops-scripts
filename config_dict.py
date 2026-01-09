#!/usr/bin/env python3
# Working with configuration dictionaries
# Note: Mocked configuration data

import json

# Mock configuration data
config = {
    "app": {
        "name": "myapp",
        "port": 8080,
        "debug": True
    },
    "database": {
        "host": "localhost",
        "port": 5432
    }
}

print("=== Configuration Dictionary Processing ===")
for section, settings in config.items():
    print(f"\n[{section.upper()}]")
    for key, value in settings.items():
        print(f"  {key}: {value}")

# Save as JSON (mocked file operation)
with open("/tmp/simple-config.json", "w") as f:
    json.dump(config, f, indent=2)

print("\n💾 Configuration saved to /tmp/simple-config.json")
