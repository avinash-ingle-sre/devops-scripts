#!/usr/bin/env python3
# CI/CD Pipeline Status Monitor

import random
import datetime

print("=== CI/CD Pipeline Monitor ===")

# Pipeline stages
stages = ["Checkout", "Build", "Test", "Security", "Deploy"]

# Projects to monitor
projects = ["frontend", "backend", "mobile-app", "api-service", "data-pipeline"]

print("\n📊 Current Pipeline Status")
print("-" * 50)

all_builds = []

for project in projects:
    print(f"\n🔨 {project}")
    
    build_number = random.randint(100, 500)
    print(f"  Build #{build_number}")
    
    # Simulate pipeline execution
    pipeline_failed = False
    total_duration = 0
    
    for stage in stages:
        # Simulate stage execution
        duration = random.randint(10, 120)
        total_duration += duration
        
        # 85% success rate per stage
        if not pipeline_failed:
            success = random.random() > 0.15
            
            if success:
                print(f"  ✅ {stage}: {duration}s")
            else:
                print(f"  ❌ {stage}: Failed after {duration}s")
                pipeline_failed = True
                # Skip remaining stages
                for remaining in stages[stages.index(stage)+1:]:
                    print(f"  ⏭️  {remaining}: Skipped")
                break
    
    # Record build result
    all_builds.append({
        "project": project,
        "build": build_number,
        "success": not pipeline_failed,
        "duration": total_duration
    })
    
    # Overall status
    if not pipeline_failed:
        print(f"  Status: 🟢 SUCCESS ({total_duration}s)")
    else:
        print(f"  Status: 🔴 FAILED ({total_duration}s)")

# Calculate metrics
print("\n📈 Pipeline Metrics")
print("-" * 50)

successful_builds = [b for b in all_builds if b["success"]]
failed_builds = [b for b in all_builds if not b["success"]]

success_rate = (len(successful_builds) / len(all_builds)) * 100
avg_duration = sum(b["duration"] for b in all_builds) / len(all_builds)

print(f"Total Builds: {len(all_builds)}")
print(f"Successful: {len(successful_builds)}")
print(f"Failed: {len(failed_builds)}")
print(f"Success Rate: {success_rate:.1f}%")
print(f"Avg Duration: {avg_duration:.0f}s")

# Health assessment
print("\n🏥 Pipeline Health")
print("-" * 50)

if success_rate >= 90:
    print("🟢 EXCELLENT: Pipeline is very healthy")
    print("  • High success rate")
    print("  • Continue current practices")
elif success_rate >= 75:
    print("🟡 GOOD: Pipeline needs attention")
    print("  • Review failing tests")
    print("  • Check flaky tests")
elif success_rate >= 50:
    print("🟠 WARNING: Pipeline issues detected")
    print("  • Investigate common failures")
    print("  • Review recent changes")
else:
    print("🔴 CRITICAL: Pipeline in poor state")
    print("  • Immediate action required")
    print("  • Consider reverting recent changes")

# Failed projects needing attention
if failed_builds:
    print("\n⚠️  Projects Needing Attention:")
    for build in failed_builds:
        print(f"  • {build['project']} (Build #{build['build']})")
