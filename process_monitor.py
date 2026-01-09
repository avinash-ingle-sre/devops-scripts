#!/usr/bin/env python3
# Process Monitor
import subprocess
import platform

print("=== Process Monitor ===")

# Get process list based on OS
if platform.system() == "Windows":
    cmd = "tasklist"
else:
    cmd = ["ps", "aux"]

try:
    # Run command and capture output
    result = subprocess.run(cmd, capture_output=True, text=True, shell=isinstance(cmd, str))
    
    if result.returncode == 0:
        lines = result.stdout.split('\n')
        
        # Count processes
        process_count = len([l for l in lines if l.strip()])
        
        print(f"Total processes running: {process_count}")
        
        # Show first few processes
        print("\n=== Sample Processes ===")
        for line in lines[1:6]:  # Skip header, show 5 processes
            if line.strip():
                print(line[:80])  # Truncate long lines
        
        # Check for specific processes
        print("\n=== Process Check ===")
        important_processes = ['python', 'node', 'docker', 'nginx']
        
        for proc in important_processes:
            if proc.lower() in result.stdout.lower():
                print(f"✅ {proc}: Running")
            else:
                print(f"❌ {proc}: Not found")
    else:
        print(f"Error running command: {result.stderr}")
        
except Exception as e:
    print(f"Error: {e}")
