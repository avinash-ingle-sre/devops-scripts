#!/usr/bin/env python3
# Personal Information Collector

print("=== Personal Information Collector ===")
name = input("Enter your name: ")
age_str = input("Enter your age: ")
city = input("Enter your city: ")

# Convert age to integer
age = int(age_str)

# Display formatted information
print("\n=== Your Information ===")
print(f"Name: {name}")
print(f"Age: {age} years old")
print(f"City: {city}")

# Show data types
print("\n=== Data Types ===")
print(f"name is type: {type(name).__name__}")
print(f"age is type: {type(age).__name__}")
print(f"city is type: {type(city).__name__}")

# Future calculation
print(f"\nIn 10 years, you'll be {age + 10} years old!")
