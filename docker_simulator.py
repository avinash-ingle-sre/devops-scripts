#!/usr/bin/env python3
# Docker Hub Image Checker Simulator

import random
import json

print("=== Docker Hub Image Checker (Simulated) ===")

# Popular Docker images with simulated data
images_db = {
    "nginx": {"pulls": 5000000000, "stars": 15000, "tags": 150},
    "python": {"pulls": 2000000000, "stars": 10000, "tags": 200},
    "node": {"pulls": 1500000000, "stars": 8000, "tags": 180},
    "redis": {"pulls": 1000000000, "stars": 7500, "tags": 50},
    "postgres": {"pulls": 900000000, "stars": 8500, "tags": 100},
    "mysql": {"pulls": 1200000000, "stars": 9000, "tags": 80},
    "ubuntu": {"pulls": 3000000000, "stars": 5000, "tags": 30},
    "alpine": {"pulls": 2500000000, "stars": 6000, "tags": 20}
}

print("Checking popular Docker images...\n")

for image_name, data in images_db.items():
    # Add some randomness to simulate real-time changes
    pulls = data["pulls"] + random.randint(-1000000, 1000000)
    stars = data["stars"] + random.randint(-10, 10)
    tags = data["tags"]
    
    # Format pull count
    if pulls >= 1000000000:
        pulls_str = f"{pulls/1000000000:.1f}B"
    elif pulls >= 1000000:
        pulls_str = f"{pulls/1000000:.1f}M"
    else:
        pulls_str = f"{pulls:,}"
    
    print(f"📦 {image_name}")
    print(f"  Downloads: {pulls_str}")
    print(f"  Stars: ⭐ {stars:,}")
    print(f"  Available tags: {tags}")
    
    # Categorize and recommend
    if pulls >= 1000000000:
        print("  Status: 🔥 Extremely Popular")
        print("  Recommendation: ✅ Production ready")
    elif pulls >= 100000000:
        print("  Status: ⭐ Very Popular")
        print("  Recommendation: ✅ Safe to use")
    elif pulls >= 10000000:
        print("  Status: 📦 Popular")
        print("  Recommendation: ⚠️  Check reviews")
    else:
        print("  Status: 🆕 Growing")
        print("  Recommendation: ⚠️  Evaluate carefully")
    
    # Security recommendation
    if image_name in ["alpine", "distroless"]:
        print("  Security: 🔒 Minimal attack surface")
    elif tags > 100:
        print("  Security: ⚠️  Many versions - pin specific tag")
    
    print()

# Summary
print("=== Recommendations ===")
print("For production use:")
print("  • Always use specific tags (not 'latest')")
print("  • Prefer official images (marked with ✓)")
print("  • Consider minimal base images (alpine)")
print("  • Scan images for vulnerabilities")
