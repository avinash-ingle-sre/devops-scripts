#!/usr/bin/env python3
# Python Variables and Data Types Demo

# Different data types
name = "DevOps Engineer"
experience_years = 5
salary = 95000.50
is_remote = True

print("=== Variable Types Demo ===")
print(f"Name: {name} (type: {type(name).__name__})")
print(f"Experience: {experience_years} years (type: {type(experience_years).__name__})")
print(f"Salary: ${salary:,.2f} (type: {type(salary).__name__})")
print(f"Remote: {is_remote} (type: {type(is_remote).__name__})")

# Type conversion
years_str = "3"
years_int = int(years_str)
print(f"\nConverted '{years_str}' to {years_int}")
