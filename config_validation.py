#!/usr/bin/env python3
# Basic configuration validation
# Note: Validation rules are mocked but represent real scenarios

config = {
    "app": {"name": "myapp", "port": 8080},
    "database": {"host": "localhost", "port": 5432}
}

# Mock validation rules
required_fields = {
    "app": ["name", "port"],
    "database": ["host", "port"]
}

print("=== Configuration Validation ===")
errors = []

for section, settings in config.items():
    print(f"\n🔍 Validating [{section}]...")
    
    if section in required_fields:
        for required_field in required_fields[section]:
            if required_field in settings:
                print(f"  ✅ {required_field}: {settings[required_field]}")
            else:
                error_msg = f"{section}.{required_field} is missing"
                errors.append(error_msg)
                print(f"  ❌ {error_msg}")

print(f"\n📊 Validation Summary:")
print(f"  Total errors: {len(errors)}")
if errors:
    print("  Status: ❌ INVALID")
else:
    print("  Status: ✅ VALID")
