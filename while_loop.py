#!/usr/bin/env python3
# While loop for processing simulation
# Note: Using mocked input to avoid user interaction

configs = ["web", "api", "database"]
count = 0

print("=== Processing Configurations ===")
while count < len(configs):
    config_name = configs[count]
    print(f"Validating {config_name} configuration...")
    print(f"  ✅ {config_name} is valid")
    count += 1

print(f"Processed {count} configurations successfully!")
