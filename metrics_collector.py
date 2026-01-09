#!/usr/bin/env python3
# Monitoring Metrics Collector

import json
import random
import datetime

print("=== Monitoring Metrics Collector ===")

# Collect metrics for multiple servers
servers = ["web-01", "web-02", "api-01", "db-01"]

all_metrics = {}

for server in servers:
    print(f"\n📊 Collecting metrics for {server}...")
    
    # Simulate metric collection
    metrics = {
        "timestamp": datetime.datetime.now().isoformat(),
        "server": server,
        "cpu_percent": random.randint(10, 90),
        "memory_percent": random.randint(20, 85),
        "disk_percent": random.randint(30, 80),
        "network_in_mbps": random.randint(10, 100),
        "network_out_mbps": random.randint(10, 100),
        "active_connections": random.randint(50, 500),
        "response_time_ms": random.randint(50, 500)
    }
    
    all_metrics[server] = metrics
    
    # Display collected metrics
    print(f"  CPU: {metrics['cpu_percent']}%")
    print(f"  Memory: {metrics['memory_percent']}%")
    print(f"  Disk: {metrics['disk_percent']}%")
    print(f"  Response Time: {metrics['response_time_ms']}ms")
    
    # Check thresholds and generate alerts
    alerts = []
    
    if metrics['cpu_percent'] > 80:
        alerts.append(f"High CPU: {metrics['cpu_percent']}%")
    
    if metrics['memory_percent'] > 75:
        alerts.append(f"High Memory: {metrics['memory_percent']}%")
    
    if metrics['response_time_ms'] > 300:
        alerts.append(f"Slow Response: {metrics['response_time_ms']}ms")
    
    if alerts:
        print(f"  ⚠️  Alerts: {', '.join(alerts)}")
    else:
        print(f"  ✅ All metrics normal")

# Aggregate metrics
print("\n📈 Aggregate Analysis")
print("-" * 50)

# Calculate averages
avg_cpu = sum(m['cpu_percent'] for m in all_metrics.values()) / len(all_metrics)
avg_memory = sum(m['memory_percent'] for m in all_metrics.values()) / len(all_metrics)
avg_response = sum(m['response_time_ms'] for m in all_metrics.values()) / len(all_metrics)

print(f"Average CPU Usage: {avg_cpu:.1f}%")
print(f"Average Memory Usage: {avg_memory:.1f}%")
print(f"Average Response Time: {avg_response:.0f}ms")

# Find problematic servers
print("\n🔍 Server Health Ranking:")
for server, metrics in sorted(all_metrics.items(), 
                              key=lambda x: x[1]['cpu_percent'] + x[1]['memory_percent']):
    health_score = 100 - ((metrics['cpu_percent'] + metrics['memory_percent']) / 2)
    
    if health_score > 70:
        status = "🟢 Healthy"
    elif health_score > 50:
        status = "🟡 Monitor"
    else:
        status = "🔴 Critical"
    
    print(f"  {server}: {status} (score: {health_score:.0f})")

# Save metrics to file
with open('metrics.json', 'w') as f:
    json.dump(all_metrics, f, indent=2)
    print("\n✅ Metrics saved to metrics.json")

# Recommendations
print("\n💡 Recommendations:")
if avg_cpu > 70:
    print("  • Consider horizontal scaling")
if avg_memory > 70:
    print("  • Review memory usage patterns")
if avg_response > 200:
    print("  • Optimize application performance")
