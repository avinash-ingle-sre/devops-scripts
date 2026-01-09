#!/usr/bin/env python3
# DevOps Information Dashboard
import platform
import os
import datetime
import shutil

print("=" * 60)
print("           🚀 DevOps Dashboard")
print("=" * 60)

# System Information
print("\n📊 SYSTEM INFORMATION")
print("-" * 40)
print(f"Hostname: {platform.node()}")
print(f"OS: {platform.system()} {platform.release()}")
print(f"Python: {platform.python_version()}")
print(f"Architecture: {platform.machine()}")
print(f"Processor: {platform.processor() or 'N/A'}")

# User Information
print("\n👤 USER INFORMATION")
print("-" * 40)
print(f"Current User: {os.getenv('USER', 'Unknown')}")
print(f"Home Directory: {os.getenv('HOME', 'Unknown')}")
print(f"Current Directory: {os.getcwd()}")

# Disk Usage
print("\n💾 DISK USAGE")
print("-" * 40)
total, used, free = shutil.disk_usage("/")
usage_percent = (used / total) * 100
print(f"Total: {total / (1024**3):.1f} GB")
print(f"Used: {used / (1024**3):.1f} GB ({usage_percent:.1f}%)")
print(f"Free: {free / (1024**3):.1f} GB")

# Visual disk usage bar
bar_length = 30
filled = int(bar_length * usage_percent / 100)
bar = '█' * filled + '░' * (bar_length - filled)
print(f"Usage: [{bar}] {usage_percent:.1f}%")

# Time Information
print("\n🕐 TIME INFORMATION")
print("-" * 40)
now = datetime.datetime.now()
print(f"Current Time: {now.strftime('%Y-%m-%d %H:%M:%S')}")
print(f"Timezone: {datetime.datetime.now().astimezone().tzinfo}")
print(f"UTC Offset: {datetime.datetime.now().astimezone().strftime('%z')}")

# Environment Stats
print("\n🔧 ENVIRONMENT")
print("-" * 40)
env_vars = os.environ
print(f"Total Environment Variables: {len(env_vars)}")
print(f"PATH entries: {len(os.getenv('PATH', '').split(':'))}")

# Important paths
important_vars = ['PYTHON_PATH', 'JAVA_HOME', 'NODE_PATH']
for var in important_vars:
    value = os.getenv(var, 'Not set')
    status = "✅" if value != 'Not set' else "❌"
    print(f"{status} {var}: {value[:30]}..." if len(value) > 30 else f"{status} {var}: {value}")

# Status Summary
print("\n📈 STATUS SUMMARY")
print("-" * 40)

# Calculate health score
health_score = 100
if usage_percent > 80:
    health_score -= 30
    
if platform.system() == "Linux":
    load_avg = os.getloadavg()[0]
    if load_avg > 2:
        health_score -= 20

# Display health
if health_score >= 80:
    status = "🟢 HEALTHY"
elif health_score >= 60:
    status = "🟡 WARNING"
else:
    status = "🔴 CRITICAL"

print(f"Overall System Health: {status} ({health_score}%)")
print(f"Dashboard Generated: {now.strftime('%Y-%m-%d %H:%M:%S')}")
print("=" * 60)
