#!/usr/bin/env python3
# Server Status Checker (Simulated)

import random

print("=== Server Health Check ===")

# Simulate server metrics
servers = ["web-01", "api-01", "db-01", "cache-01"]

for server in servers:
    # Simulate metrics
    cpu_usage = random.randint(0, 100)
    memory_usage = random.randint(0, 100)
    disk_usage = random.randint(0, 100)
    
    print(f"\n📊 {server}:")
    print(f"  CPU: {cpu_usage}%")
    print(f"  Memory: {memory_usage}%")
    print(f"  Disk: {disk_usage}%")
    
    # Check health status
    issues = []
    
    if cpu_usage > 90:
        issues.append("CPU critical")
    elif cpu_usage > 70:
        issues.append("CPU warning")
    
    if memory_usage > 85:
        issues.append("Memory critical")
    elif memory_usage > 65:
        issues.append("Memory warning")
    
    if disk_usage > 90:
        issues.append("Disk critical")
    elif disk_usage > 80:
        issues.append("Disk warning")
    
    # Overall status
    if any("critical" in issue for issue in issues):
        print("  Status: 🔴 CRITICAL")
    elif issues:
        print("  Status: 🟡 WARNING")
    else:
        print("  Status: 🟢 HEALTHY")
    
    if issues:
        print(f"  Issues: {', '.join(issues)}")
