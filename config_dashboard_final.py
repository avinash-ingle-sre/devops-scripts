#!/usr/bin/env python3
# Comprehensive Configuration Management Dashboard
# Note: All monitoring data is mocked for demonstration

import json
import datetime

# Mock configuration data
services = {
    "frontend": {"replicas": 3, "memory": "512Mi", "status": "healthy", "configs": 8},
    "api": {"replicas": 2, "memory": "1Gi", "status": "healthy", "configs": 12},
    "database": {"replicas": 1, "memory": "2Gi", "status": "warning", "configs": 6},
    "worker": {"replicas": 5, "memory": "512Mi", "status": "critical", "configs": 10}
}

print("=" * 60)
print("     🖥️  CONFIGURATION MANAGEMENT DASHBOARD")
print("=" * 60)
print(f"Generated at: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

# Overview metrics using list comprehensions
healthy_count = len([s for s in services.values() if s["status"] == "healthy"])
warning_count = len([s for s in services.values() if s["status"] == "warning"])
critical_count = len([s for s in services.values() if s["status"] == "critical"])

print(f"\n📊 SYSTEM OVERVIEW")
print(f"  Total Services: {len(services)}")
print(f"  Status: {healthy_count} 🟢 | {warning_count} 🟡 | {critical_count} 🔴")

# Resource summary using loops
total_replicas = sum(service["replicas"] for service in services.values())
total_configs = sum(service["configs"] for service in services.values())

print(f"\n📈 RESOURCE SUMMARY")
print(f"  Total Replicas: {total_replicas}")
print(f"  Total Configurations: {total_configs}")

# Service details
print(f"\n🏷️  SERVICE DETAILS")
print("-" * 40)

for name, config in services.items():
    status_icon = "🟢" if config["status"] == "healthy" else (
        "🟡" if config["status"] == "warning" else "🔴"
    )
    print(f"{status_icon} {name.upper()}")
    print(f"   Replicas: {config['replicas']}")
    print(f"   Memory: {config['memory']}")
    print(f"   Configurations: {config['configs']}")
    print(f"   Status: {config['status'].title()}")
    print()

# Recommendations based on analysis
print("💡 RECOMMENDATIONS")
print("-" * 30)

recommendations = []

# Check for critical services
critical_services = [name for name, config in services.items() if config["status"] == "critical"]
if critical_services:
    recommendations.append(f"Immediate attention needed: {', '.join(critical_services)}")

# Check for high replica count
high_replica_services = [name for name, config in services.items() if config["replicas"] > 3]
if high_replica_services:
    recommendations.append(f"Monitor resource usage: {', '.join(high_replica_services)}")

# Check for complex configurations
complex_config_services = [name for name, config in services.items() if config["configs"] > 10]
if complex_config_services:
    recommendations.append(f"Review configuration complexity: {', '.join(complex_config_services)}")

# Display recommendations
if recommendations:
    for i, rec in enumerate(recommendations, 1):
        print(f"{i}. {rec}")
else:
    print("✅ No specific recommendations at this time")

# Save dashboard data
dashboard_data = {
    "timestamp": datetime.datetime.now().isoformat(),
    "services": services,
    "metrics": {
        "total_services": len(services),
        "healthy_services": healthy_count,
        "total_replicas": total_replicas,
        "total_configs": total_configs
    },
    "recommendations": recommendations
}

with open("/tmp/config-dashboard.json", "w") as f:
    json.dump(dashboard_data, f, indent=2)

print(f"\n💾 Dashboard data saved to /tmp/config-dashboard.json")
print("=" * 60)

# Final scenario achievement message
print("\n🎉 SCENARIO COMPLETED!")
print("You have successfully built a comprehensive configuration")
print("management system that can:")
print("  ✅ Process configurations with Python loops")
print("  ✅ Validate configuration data and handle errors")
print("  ✅ Generate environment-specific configurations")
print("  ✅ Convert between different configuration formats")
print("  ✅ Create Docker Compose configurations")
print("  ✅ Provide monitoring dashboard with recommendations")
print("\nThis system now handles hundreds of configuration files")
print("across multiple environments with automated validation,")
print("format conversion, and intelligent recommendations!")
