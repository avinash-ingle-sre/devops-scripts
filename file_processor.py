#!/usr/bin/env python3
# File Processor Demo

# Create a sample file
sample_content = """server1,192.168.1.10,active
server2,192.168.1.11,maintenance
server3,192.168.1.12,active
server4,192.168.1.13,inactive"""

with open('servers.txt', 'w') as f:
    f.write(sample_content)

print("=== Server Status Report ===")

# Read and process file
active_count = 0
total_count = 0

with open('servers.txt', 'r') as f:
    for line in f:
        total_count += 1
        parts = line.strip().split(',')
        if len(parts) == 3:
            name, ip, status = parts
            print(f"{name}: {ip} - {status.upper()}")
            if status == 'active':
                active_count += 1

print(f"\n=== Summary ===")
print(f"Total Servers: {total_count}")
print(f"Active Servers: {active_count}")
print(f"Inactive Servers: {total_count - active_count}")
print(f"Availability: {(active_count/total_count)*100:.1f}%")
