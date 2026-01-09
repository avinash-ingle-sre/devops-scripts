#!/usr/bin/env python3
# Simple for loop example
# Note: Using mocked data to simulate configuration processing

environments = ["development", "staging", "production"]

print("=== Processing Environments ===")
for env in environments:
    print(f"Processing {env} environment")

print("All environments processed!")
