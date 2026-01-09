#!/usr/bin/env python3
# DevOps API Dashboard (All Simulated)

import json
import datetime
import random

print("=" * 60)
print("         🚀 DevOps API Automation Dashboard")
print("=" * 60)

# Simulate API statuses
print("\n📡 API STATUS (Simulated)")
print("-" * 40)

apis = {
    "GitHub": random.choice(["Online", "Online", "Degraded"]),
    "Docker Hub": random.choice(["Online", "Online", "Rate Limited"]),
    "Jenkins": "Online",
    "Kubernetes": random.choice(["Online", "Online", "Maintenance"]),
    "AWS": "Online",
    "Monitoring": random.choice(["Online", "Online", "Slow"])
}

operational_count = 0
for api, status in apis.items():
    if status == "Online":
        symbol = "🟢"
        operational_count += 1
    elif status in ["Degraded", "Slow"]:
        symbol = "🟡"
    else:
        symbol = "🔴"
    
    print(f"{symbol} {api}: {status}")

availability = (operational_count / len(apis)) * 100
print(f"\nOverall Availability: {availability:.0f}%")

# CI/CD Pipeline Status
print("\n🔨 CI/CD PIPELINE")
print("-" * 40)

pipelines = {
    "Build": {"status": random.choice(["✅ Success", "✅ Success", "❌ Failed"]), 
             "duration": random.randint(60, 300)},
    "Test": {"status": "✅ Success", "duration": random.randint(120, 600)},
    "Security": {"status": random.choice(["✅ Success", "⚠️  Warnings"]), 
                "duration": random.randint(30, 180)},
    "Deploy": {"status": random.choice(["✅ Success", "🔄 Running"]), 
              "duration": random.randint(60, 240)}
}

for stage, info in pipelines.items():
    print(f"{stage}: {info['status']} ({info['duration']}s)")

# Resource Utilization
print("\n💻 RESOURCE UTILIZATION")
print("-" * 40)

resources = {
    "Containers": f"{random.randint(20, 50)}/60 running",
    "CPU Usage": f"{random.randint(40, 80)}%",
    "Memory": f"{random.randint(4, 12)}/16 GB",
    "API Calls Today": f"{random.randint(5000, 15000):,}",
    "Cache Hit Rate": f"{random.randint(85, 99)}%"
}

for resource, value in resources.items():
    print(f"{resource}: {value}")

# Active Incidents
print("\n🚨 ACTIVE INCIDENTS")
print("-" * 40)

incidents = random.randint(0, 3)
if incidents == 0:
    print("✅ No active incidents")
    incident_score = 100
else:
    incident_types = [
        "High latency on API gateway",
        "Memory leak in payment service",
        "Database connection pool exhausted",
        "SSL certificate expiring soon",
        "Disk space low on log server"
    ]
    for i in range(incidents):
        print(f"⚠️  P{random.randint(2,3)}: {random.choice(incident_types)}")
    incident_score = max(0, 100 - (incidents * 25))

# Deployment Activity
print("\n🚀 RECENT DEPLOYMENTS")
print("-" * 40)

deployments = [
    {"service": "frontend", "version": "2.3.1", "time": "2 hours ago", "status": "✅"},
    {"service": "api", "version": "1.8.5", "time": "5 hours ago", "status": "✅"},
    {"service": "worker", "version": "3.1.0", "time": "1 day ago", "status": "⚠️"}
]

for deploy in deployments[-3:]:
    print(f"{deploy['status']} {deploy['service']} v{deploy['version']} - {deploy['time']}")

# Security Status
print("\n🔒 SECURITY STATUS")
print("-" * 40)

vulnerabilities = {
    "Critical": random.randint(0, 2),
    "High": random.randint(0, 5),
    "Medium": random.randint(2, 10),
    "Low": random.randint(5, 20)
}

security_score = 100
for level, count in vulnerabilities.items():
    if count > 0:
        if level == "Critical":
            symbol = "🔴"
            security_score -= count * 20
        elif level == "High":
            symbol = "🟠"
            security_score -= count * 10
        elif level == "Medium":
            symbol = "🟡"
            security_score -= count * 3
        else:
            symbol = "🔵"
            security_score -= count * 1
        
        print(f"{symbol} {level}: {count}")

security_score = max(0, security_score)

# Overall Health Score
print("\n📊 SYSTEM HEALTH SCORE")
print("-" * 40)

health_score = (availability + incident_score + security_score) / 3

if health_score >= 90:
    health_status = "🟢 EXCELLENT"
    recommendation = "System performing optimally"
elif health_score >= 70:
    health_status = "🟡 GOOD"
    recommendation = "Minor issues need attention"
elif health_score >= 50:
    health_status = "🟠 DEGRADED"
    recommendation = "Multiple issues require attention"
else:
    health_status = "🔴 CRITICAL"
    recommendation = "Immediate action required"

print(f"Overall Score: {health_score:.0f}/100")
print(f"Status: {health_status}")
print(f"Recommendation: {recommendation}")

# Time-based recommendations
print("\n💡 RECOMMENDATIONS")
print("-" * 40)

hour = datetime.datetime.now().hour

if 2 <= hour <= 6:
    print("🌙 Low traffic window - Ideal for:")
    print("  • Major deployments")
    print("  • Database maintenance")
    print("  • Infrastructure updates")
elif 9 <= hour <= 17:
    print("☀️  Peak hours - Focus on:")
    print("  • Monitoring performance")
    print("  • Quick fixes only")
    print("  • Incident response ready")
else:
    print("🌆 Standard operations")
    print("  • Normal deployment window")
    print("  • Routine maintenance OK")

print(f"\nDashboard updated: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
print("=" * 60)
