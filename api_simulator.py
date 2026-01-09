#!/usr/bin/env python3
# Simulated API Response Handler

import json
import random

print("=== Simulated API Response Handler ===")

# Simulate different API responses
def simulate_api_call(endpoint):
    """Simulate API responses without network calls"""
    
    # Random response selection
    response_type = random.choice(["success", "success", "error", "timeout"])
    
    if response_type == "success":
        if endpoint == "github":
            return {
                "status": 200,
                "data": {
                    "repo": "myapp",
                    "stars": 1234,
                    "forks": 56,
                    "issues": 12
                }
            }
        elif endpoint == "docker":
            return {
                "status": 200,
                "data": {
                    "image": "nginx",
                    "tags": ["latest", "1.21", "1.20"],
                    "pulls": 1000000
                }
            }
        else:
            return {"status": 200, "data": {"message": "OK"}}
    
    elif response_type == "error":
        return {"status": 500, "error": "Internal Server Error"}
    
    else:  # timeout
        return {"status": 0, "error": "Connection timeout"}

# Test different endpoints
endpoints = ["github", "docker", "monitoring", "ci/cd"]

for endpoint in endpoints:
    print(f"\n🔍 Calling {endpoint} API...")
    response = simulate_api_call(endpoint)
    
    # Handle response based on status
    if response["status"] == 200:
        print(f"✅ Success: {endpoint}")
        data = response["data"]
        
        # Process based on endpoint type
        if endpoint == "github" and "repo" in data:
            print(f"  Repository: {data['repo']}")
            print(f"  Stars: ⭐ {data['stars']}")
            
            # Decision based on data
            if data['stars'] > 1000:
                print("  📊 Popular repository!")
            
            if data['issues'] > 10:
                print("  ⚠️  Many open issues - needs attention")
                
        elif endpoint == "docker" and "image" in data:
            print(f"  Image: {data['image']}")
            print(f"  Tags available: {len(data['tags'])}")
            
            if data['pulls'] > 100000:
                print("  🔥 Very popular image!")
                
    elif response["status"] >= 500:
        print(f"❌ Server Error: {endpoint}")
        print(f"  Error: {response['error']}")
        print("  Action: Will retry in production")
        
    elif response["status"] == 0:
        print(f"⏱️  Timeout: {endpoint}")
        print("  Action: Check network and retry")
        
    else:
        print(f"⚠️  Unexpected status {response['status']} from {endpoint}")

print("\n=== Summary ===")
print("Demonstrated API response handling patterns:")
print("  • Success response processing")
print("  • Error handling")
print("  • Timeout scenarios")
print("  • Data-based decisions")
