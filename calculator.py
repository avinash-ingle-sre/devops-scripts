#!/usr/bin/env python3
# Basic Python Calculator

print("=== Python Calculator ===")

# Get numbers from user
num1_str = input("Enter first number: ")
num2_str = input("Enter second number: ")

# Convert to float for calculations
num1 = float(num1_str)
num2 = float(num2_str)

# Perform calculations
print("\n=== Results ===")
print(f"Addition: {num1} + {num2} = {num1 + num2}")
print(f"Subtraction: {num1} - {num2} = {num1 - num2}")
print(f"Multiplication: {num1} × {num2} = {num1 * num2}")

if num2 != 0:
    print(f"Division: {num1} ÷ {num2} = {num1 / num2:.2f}")
else:
    print("Division: Cannot divide by zero!")

print(f"Power: {num1} ^ {num2} = {num1 ** num2:.2f}")
