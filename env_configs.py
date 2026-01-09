#!/usr/bin/env python3
# Environment-specific configuration generation
# Note: All operations are mocked to avoid external dependencies

import json

base_config = {
    "app": {"name": "myapp", "port": 8080, "replicas": 1},
    "database": {"host": "localhost", "port": 5432}
}

environments = ["development", "staging", "production"]

print("=== Environment-Specific Configuration Generation ===")

for env in environments:
    print(f"\n🌍 Generating {env.upper()} configuration...")
    
    # Create environment-specific config
    env_config = {}
    for section, settings in base_config.items():
        env_config[section] = {}
        for key, value in settings.items():
            # Environment-specific overrides
            if key == "replicas":
                if env == "development":
                    env_config[section][key] = 1
                elif env == "staging":
                    env_config[section][key] = 2
                else:  # production
                    env_config[section][key] = 3
            elif key == "host" and env != "development":
                env_config[section][key] = f"{section}-{env}.example.com"
            else:
                env_config[section][key] = value
    
    # Save configuration
    filename = f"/tmp/config-{env}.json"
    with open(filename, "w") as f:
        json.dump(env_config, f, indent=2)
    
    print(f"  📦 App replicas: {env_config['app']['replicas']}")
    print(f"  🗄️  Database host: {env_config['database']['host']}")
    print(f"  💾 Saved to: {filename}")

print("\n🎉 All environment configurations generated!")
