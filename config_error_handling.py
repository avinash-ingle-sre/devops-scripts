#!/usr/bin/env python3
# Configuration validation with error handling
# Note: Validation scenarios are mocked

configs = [
    {"name": "web", "port": 8080, "memory": "512Mi"},
    {"name": "api", "port": 0, "memory": "1Gi"},      # Invalid port
    {"name": "db", "port": 5432, "memory": "invalid"} # Invalid memory
]

print("=== Configuration Validation with Error Handling ===")

valid_configs = []
errors = []

for i, config in enumerate(configs, 1):
    print(f"\n🔍 Validating Configuration {i}: {config['name']}")
    config_errors = []
    
    # Validate port
    try:
        port = config.get("port", 0)
        if port <= 0 or port > 65535:
            config_errors.append(f"Invalid port: {port}")
            print(f"  ❌ Port: {port} - Invalid")
        else:
            print(f"  ✅ Port: {port} - Valid")
    except Exception as e:
        config_errors.append(f"Port validation error: {e}")
    
    # Validate memory
    try:
        memory = config.get("memory", "")
        if not memory.endswith(("Mi", "Gi")):
            config_errors.append(f"Invalid memory format: {memory}")
            print(f"  ❌ Memory: {memory} - Invalid format")
        else:
            print(f"  ✅ Memory: {memory} - Valid")
    except Exception as e:
        config_errors.append(f"Memory validation error: {e}")
    
    # Check results
    if config_errors:
        print(f"  Status: ❌ INVALID ({len(config_errors)} errors)")
        errors.extend([(config["name"], error) for error in config_errors])
    else:
        print(f"  Status: ✅ VALID")
        valid_configs.append(config)

print(f"\n📊 Validation Results:")
print(f"  Total configurations: {len(configs)}")
print(f"  Valid: {len(valid_configs)}")
print(f"  Invalid: {len(configs) - len(valid_configs)}")
print(f"  Total errors: {len(errors)}")

if errors:
    print(f"\n❌ Errors found:")
    for service, error in errors:
        print(f"  • {service}: {error}")

if valid_configs:
    print(f"\n✅ Saving {len(valid_configs)} valid configurations...")
    import json
    with open("/tmp/validated-configs.json", "w") as f:
        json.dump(valid_configs, f, indent=2)
    print("💾 Valid configurations saved to /tmp/validated-configs.json")
