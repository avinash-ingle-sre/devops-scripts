#!/usr/bin/env python3
# Simple configuration format converter
# Note: File operations are mocked for resource constraints

import json
import configparser

# Sample configuration
config_data = {
    "app": {"name": "myapp", "port": 8080, "debug": True},
    "database": {"host": "localhost", "port": 5432, "ssl": False}
}

print("=== Configuration Format Converter ===")

# Display original JSON
print("\n📄 Original JSON Configuration:")
print(json.dumps(config_data, indent=2))

# Convert to INI format
print("\n🔄 Converting to INI format...")
config = configparser.ConfigParser()

for section_name, section_data in config_data.items():
    config.add_section(section_name)
    for key, value in section_data.items():
        config.set(section_name, key, str(value))

# Save INI file
with open("/tmp/config.ini", "w") as f:
    config.write(f)
print("💾 INI file saved to: /tmp/config.ini")

# Convert to environment variables format
print("\n🔄 Converting to Environment Variables...")
env_vars = []
for section, settings in config_data.items():
    for key, value in settings.items():
        env_name = f"{section.upper()}_{key.upper()}"
        env_value = str(value).lower() if isinstance(value, bool) else str(value)
        env_vars.append(f"export {env_name}={env_value}")

print("Environment variables:")
for var in env_vars:
    print(f"  {var}")

# Save environment file
with open("/tmp/config.env", "w") as f:
    f.write("\n".join(env_vars))
print("💾 Environment file saved to: /tmp/config.env")

print(f"\n🎉 Converted to 3 different formats!")
