#!/usr/bin/env python3
# GitHub Repository Info Simulator

import json
import random
from datetime import datetime, timedelta

print("=== GitHub Repository Simulator ===")

# Get repository info
owner = input("Enter repo owner (e.g., kubernetes): ") or "kubernetes"
repo = input("Enter repo name (e.g., kubernetes): ") or "kubernetes"

print(f"\n🔍 Fetching: {owner}/{repo}...")

# Simulate GitHub API response
def get_repo_data(owner, repo):
    """Simulate GitHub API response"""
    
    # Popular repos get better stats
    popular_repos = ["kubernetes", "docker", "terraform", "ansible", "jenkins"]
    is_popular = repo.lower() in popular_repos
    
    # Generate realistic data
    if is_popular:
        stars = random.randint(50000, 100000)
        forks = random.randint(10000, 30000)
        issues = random.randint(500, 2000)
    else:
        stars = random.randint(10, 5000)
        forks = random.randint(1, 1000)
        issues = random.randint(0, 100)
    
    created = datetime.now() - timedelta(days=random.randint(365, 3650))
    
    return {
        "name": repo,
        "full_name": f"{owner}/{repo}",
        "description": f"Simulated description for {repo}",
        "language": random.choice(["Go", "Python", "JavaScript", "Java", "C++"]),
        "stargazers_count": stars,
        "forks_count": forks,
        "open_issues_count": issues,
        "created_at": created.strftime("%Y-%m-%d"),
        "updated_at": datetime.now().strftime("%Y-%m-%d"),
        "archived": random.choice([False, False, False, True]),
        "topics": ["devops", "automation", "cloud"],
        "license": random.choice(["MIT", "Apache-2.0", "GPL-3.0", None])
    }

# Get simulated data
data = get_repo_data(owner, repo)

print("\n📊 Repository Details")
print("-" * 40)
print(f"Name: {data['full_name']}")
print(f"Description: {data['description']}")
print(f"Language: {data['language']}")
print(f"Stars: ⭐ {data['stargazers_count']:,}")
print(f"Forks: 🍴 {data['forks_count']:,}")
print(f"Open Issues: 🐛 {data['open_issues_count']:,}")
print(f"Created: {data['created_at']}")
print(f"License: {data['license'] or 'No license'}")

# Make decisions based on data
print("\n📈 Repository Analysis")
print("-" * 40)

# Popularity analysis
if data['stargazers_count'] > 50000:
    print("🌟 Extremely Popular Repository!")
    print("  • Widely adopted in the community")
    print("  • Likely production-ready")
elif data['stargazers_count'] > 10000:
    print("⭐ Very Popular Repository")
    print("  • Good community support")
elif data['stargazers_count'] > 1000:
    print("✨ Popular Repository")
    print("  • Growing community")
else:
    print("📦 Standard Repository")
    print("  • Consider community size before adoption")

# Health analysis
if data['archived']:
    print("\n⚠️  WARNING: Repository is archived!")
    print("  • No longer maintained")
    print("  • Look for alternatives")
elif data['open_issues_count'] > 1000:
    print("\n⚠️  High number of open issues")
    print("  • May have stability concerns")
    print("  • Check issue trends")
elif data['open_issues_count'] < 10:
    print("\n✅ Low issue count")
    print("  • Well maintained or low activity")

# License check
if not data['license']:
    print("\n⚠️  No license specified")
    print("  • Check legal implications before use")
elif data['license'] in ["MIT", "Apache-2.0"]:
    print("\n✅ Business-friendly license")

print("\n💡 Recommendations:")
if data['stargazers_count'] > 10000 and not data['archived']:
    print("  ✅ Safe to use in production")
elif data['stargazers_count'] > 1000 and not data['archived']:
    print("  ⚠️  Evaluate carefully before production use")
else:
    print("  ❌ Consider alternatives for production")
