#!/usr/bin/env python3
# Simple Log Analyzer

# Create sample log file
log_data = """2024-01-15 10:00:01 INFO Service started
2024-01-15 10:00:15 ERROR Connection failed
2024-01-15 10:00:30 INFO Retry attempt 1
2024-01-15 10:00:45 WARNING High memory usage
2024-01-15 10:01:00 INFO Connection established
2024-01-15 10:01:15 ERROR Database timeout
2024-01-15 10:01:30 INFO Service recovered"""

with open('app.log', 'w') as f:
    f.write(log_data)

print("=== Log Analysis ===")

# Analyze log levels
log_counts = {'INFO': 0, 'ERROR': 0, 'WARNING': 0}

with open('app.log', 'r') as f:
    lines = f.readlines()
    
    for line in lines:
        for level in log_counts:
            if level in line:
                log_counts[level] += 1
                if level == 'ERROR':
                    print(f"❌ Error found: {line.strip()}")

print("\n=== Summary ===")
for level, count in log_counts.items():
    print(f"{level}: {count} occurrences")

print(f"\nTotal log entries: {len(lines)}")
print(f"Error rate: {(log_counts['ERROR']/len(lines))*100:.1f}%")
