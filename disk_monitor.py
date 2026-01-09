#!/usr/bin/env python3
# Disk Usage Monitor
import os
import shutil

print("=== Disk Usage Monitor ===")

# Get disk usage
total, used, free = shutil.disk_usage("/")

# Convert bytes to GB
total_gb = total / (1024**3)
used_gb = used / (1024**3)
free_gb = free / (1024**3)
usage_percent = (used / total) * 100

# Display results
print(f"Total Space: {total_gb:.1f} GB")
print(f"Used Space: {used_gb:.1f} GB ({usage_percent:.1f}%)")
print(f"Free Space: {free_gb:.1f} GB")

# Visual bar
bar_length = 30
filled = int(bar_length * usage_percent / 100)
bar = '█' * filled + '░' * (bar_length - filled)
print(f"\nUsage: [{bar}] {usage_percent:.1f}%")

# Alert based on usage
if usage_percent > 90:
    print("\n🚨 CRITICAL: Disk space critically low!")
elif usage_percent > 80:
    print("\n⚠️  WARNING: Disk space running low")
else:
    print("\n✅ OK: Disk space healthy")

# Show largest directories
print("\n=== Checking current directory ===")
current_size = sum(os.path.getsize(f) for f in os.listdir('.') if os.path.isfile(f))
print(f"Current directory size: {current_size/1024:.1f} KB")
