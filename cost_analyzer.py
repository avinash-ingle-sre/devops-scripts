#!/usr/bin/env python3
# Cloud Resource Cost Analyzer

import random
import json

print("=== Cloud Resource Cost Analyzer ===")

# Simulate cloud resources
resources = {
    "compute": [
        {"name": "web-server-01", "type": "t2.micro", "hours": 720, "rate": 0.0116},
        {"name": "web-server-02", "type": "t2.small", "hours": 720, "rate": 0.023},
        {"name": "api-server-01", "type": "t2.medium", "hours": 720, "rate": 0.0464},
        {"name": "db-server-01", "type": "t3.large", "hours": 720, "rate": 0.0832}
    ],
    "storage": [
        {"name": "app-storage", "gb": 100, "rate": 0.023},
        {"name": "backup-storage", "gb": 500, "rate": 0.023},
        {"name": "archive-storage", "gb": 1000, "rate": 0.004}
    ],
    "network": {
        "data_transfer_gb": random.randint(100, 1000),
        "rate_per_gb": 0.09
    }
}

print("\n💻 Compute Resources")
print("-" * 50)

compute_total = 0
for instance in resources["compute"]:
    cost = instance["hours"] * instance["rate"]
    compute_total += cost
    print(f"{instance['name']} ({instance['type']})")
    print(f"  Hours: {instance['hours']}")
    print(f"  Rate: ${instance['rate']}/hour")
    print(f"  Cost: ${cost:.2f}")
    
    # Optimization check
    if instance["type"].startswith("t2") and cost > 30:
        print(f"  💡 Consider t3 instance for better price/performance")

print(f"\nCompute Total: ${compute_total:.2f}")

print("\n💾 Storage Resources")
print("-" * 50)

storage_total = 0
for storage in resources["storage"]:
    cost = storage["gb"] * storage["rate"]
    storage_total += cost
    print(f"{storage['name']}: {storage['gb']} GB")
    print(f"  Rate: ${storage['rate']}/GB/month")
    print(f"  Cost: ${cost:.2f}")
    
    # Optimization check
    if storage["name"] == "backup-storage" and storage["rate"] > 0.01:
        print(f"  💡 Consider glacier storage for backups")

print(f"\nStorage Total: ${storage_total:.2f}")

print("\n🌐 Network Transfer")
print("-" * 50)

network_cost = resources["network"]["data_transfer_gb"] * resources["network"]["rate_per_gb"]
print(f"Data Transfer: {resources['network']['data_transfer_gb']} GB")
print(f"Rate: ${resources['network']['rate_per_gb']}/GB")
print(f"Cost: ${network_cost:.2f}")

print("\n📊 Cost Summary")
print("-" * 50)

total_cost = compute_total + storage_total + network_cost
daily_cost = total_cost / 30

print(f"Compute: ${compute_total:.2f} ({compute_total/total_cost*100:.1f}%)")
print(f"Storage: ${storage_total:.2f} ({storage_total/total_cost*100:.1f}%)")
print(f"Network: ${network_cost:.2f} ({network_cost/total_cost*100:.1f}%)")
print(f"\nTotal Monthly: ${total_cost:.2f}")
print(f"Daily Average: ${daily_cost:.2f}")
print(f"Yearly Projection: ${total_cost * 12:.2f}")

# Cost optimization recommendations
print("\n💰 Cost Optimization Recommendations")
print("-" * 50)

if total_cost > 500:
    print("🔴 High monthly spend detected!")
    print("  • Review unused resources")
    print("  • Consider reserved instances (up to 72% savings)")
    print("  • Implement auto-scaling")
    print("  • Use spot instances for non-critical workloads")
elif total_cost > 200:
    print("🟡 Moderate spend - optimization opportunities:")
    print("  • Consider reserved instances for stable workloads")
    print("  • Review storage lifecycle policies")
    print("  • Optimize data transfer routes")
else:
    print("🟢 Cost-efficient setup")
    print("  • Continue monitoring for changes")
    print("  • Set up billing alerts")

# Savings opportunities
savings = 0
if compute_total > 100:
    savings += compute_total * 0.3  # Reserved instance savings
if storage_total > 50:
    savings += storage_total * 0.2  # Storage optimization

if savings > 0:
    print(f"\n💡 Potential Monthly Savings: ${savings:.2f}")
    print(f"   Annual Savings: ${savings * 12:.2f}")
