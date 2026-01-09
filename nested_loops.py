#!/usr/bin/env python3
# Nested loops for configuration processing
# Note: All data is mocked to simulate real configurations

environments = ["dev", "staging", "prod"]
services = ["web", "api", "db"]

print("=== Configuration Matrix Processing ===")
for env in environments:
    print(f"\n🌍 Environment: {env.upper()}")
    for service in services:
        print(f"  📦 Configuring {service} for {env}")
        # Mock configuration generation
        replicas = 1 if env == "dev" else (2 if env == "staging" else 3)
        print(f"     Replicas: {replicas}")

print("\nAll environment-service combinations processed!")
