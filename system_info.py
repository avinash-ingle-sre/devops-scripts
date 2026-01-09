#!/usr/bin/env python3
# System Information Collector
import platform
import os

print("=== System Information ===")

# Get system details
hostname = platform.node()
system = platform.system()
release = platform.release()
architecture = platform.machine()
python_version = platform.python_version()

# Display formatted information
print(f"Hostname: {hostname}")
print(f"OS: {system} {release}")
print(f"Architecture: {architecture}")
print(f"Python Version: {python_version}")

# Environment variables
print("\n=== Environment ===")
print(f"Current User: {os.getenv('USER', 'N/A')}")
print(f"Home Directory: {os.getenv('HOME', 'N/A')}")
print(f"Shell: {os.getenv('SHELL', 'N/A')}")
print(f"Path entries: {len(os.getenv('PATH', '').split(':'))}")
