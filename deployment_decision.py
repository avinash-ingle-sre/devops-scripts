#!/usr/bin/env python3
# Deployment Decision Maker

import random
import datetime

print("=== Deployment Decision System ===")

# Get deployment info
environment = input("Environment (dev/staging/prod): ").lower()
day = datetime.datetime.now().strftime("%A")
hour = datetime.datetime.now().hour

# Simulate test results
tests_passed = random.choice([True, False, True, True])  # 75% pass rate
code_coverage = random.randint(60, 100)
build_status = random.choice(["success", "success", "success", "failed"])

print(f"\n📋 Deployment Request:")
print(f"  Environment: {environment}")
print(f"  Day: {day}")
print(f"  Hour: {hour:02d}:00")
print(f"  Tests: {'✅ Passed' if tests_passed else '❌ Failed'}")
print(f"  Build: {'✅ Success' if build_status == 'success' else '❌ Failed'}")
print(f"  Coverage: {code_coverage}%")

# Decision logic
can_deploy = True
reasons = []

# Check build and tests
if build_status != "success":
    can_deploy = False
    reasons.append("Build must succeed")

if not tests_passed:
    can_deploy = False
    reasons.append("All tests must pass")

# Environment-specific rules
if environment == "prod":
    # Production rules
    if code_coverage < 80:
        can_deploy = False
        reasons.append(f"Production requires 80% coverage (current: {code_coverage}%)")
    
    if day in ["Saturday", "Sunday"]:
        can_deploy = False
        reasons.append("No weekend production deployments")
    
    if hour < 9 or hour > 17:
        can_deploy = False
        reasons.append("Production deployments only 9 AM - 5 PM")
        
elif environment == "staging":
    # Staging rules
    if code_coverage < 60:
        can_deploy = False
        reasons.append(f"Staging requires 60% coverage (current: {code_coverage}%)")

# Final decision
print("\n📊 Decision Analysis:")
if can_deploy:
    print("🚀 APPROVED: Deployment can proceed")
    print("  All checks passed successfully")
else:
    print("🛑 BLOCKED: Deployment cannot proceed")
    print("\n  Reasons:")
    for reason in reasons:
        print(f"    • {reason}")
