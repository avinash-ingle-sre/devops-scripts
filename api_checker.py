#!/usr/bin/env python3
# API Health Checker
import urllib.request
import urllib.error
import json
import time

print("=== API Health Checker ===")

# List of endpoints to check
endpoints = [
    {"name": "JSONPlaceholder", "url": "https://jsonplaceholder.typicode.com/posts/1"},
    {"name": "GitHub API", "url": "https://api.github.com"},
    {"name": "Invalid URL", "url": "https://this-does-not-exist-12345.com"}
]

results = []

for endpoint in endpoints:
    print(f"\nChecking {endpoint['name']}...")
    start_time = time.time()
    
    try:
        response = urllib.request.urlopen(endpoint['url'], timeout=5)
        status_code = response.getcode()
        response_time = (time.time() - start_time) * 1000  # Convert to ms
        
        print(f"✅ Status: {status_code}")
        print(f"⏱️  Response time: {response_time:.0f}ms")
        
        results.append({
            "name": endpoint['name'],
            "status": "UP",
            "code": status_code,
            "response_time": response_time
        })
        
    except urllib.error.URLError as e:
        print(f"❌ Failed: {str(e)}")
        results.append({
            "name": endpoint['name'],
            "status": "DOWN",
            "error": str(e)
        })
    except Exception as e:
        print(f"❌ Error: {str(e)}")
        results.append({
            "name": endpoint['name'],
            "status": "ERROR",
            "error": str(e)
        })

# Summary
print("\n=== Health Check Summary ===")
up_count = sum(1 for r in results if r.get('status') == 'UP')
down_count = len(results) - up_count

print(f"Services UP: {up_count}/{len(results)}")
print(f"Services DOWN: {down_count}/{len(results)}")
print(f"Overall Health: {'🟢 Healthy' if up_count == len(results) else '🔴 Degraded'}")

# Save results
with open('health_check.json', 'w') as f:
    json.dump(results, f, indent=2)
print("\nResults saved to health_check.json")
