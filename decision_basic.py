#!/usr/bin/env python3
# Basic Control Flow Demo

# Get user input
age = int(input("Enter your age: "))

print("\n=== Age Verification ===")

# Simple if-else
if age >= 18:
    print("✅ You are an adult")
    print("You can vote and drive")
else:
    print("❌ You are a minor")
    print(f"Wait {18 - age} more years to become an adult")

# Multiple conditions
if age < 13:
    category = "Child"
elif age < 20:
    category = "Teenager"
elif age < 60:
    category = "Adult"
else:
    category = "Senior"

print(f"Category: {category}")

# Logical operators
if age >= 16 and age < 18:
    print("You can drive but cannot vote")
elif age >= 18 and age < 21:
    print("You can vote but cannot drink (in US)")
elif age >= 21:
    print("You have all adult privileges")
