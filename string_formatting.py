#!/usr/bin/env python3
# String Formatting Demo

product = "Server License"
price = 1299.99
quantity = 5

# Method 1: f-strings (recommended)
print("=== F-strings (Modern) ===")
print(f"Product: {product}")
print(f"Price: ${price:.2f}")
print(f"Total: ${price * quantity:,.2f}")

# Method 2: .format() method
print("\n=== .format() Method ===")
print("Product: {}".format(product))
print("Price: ${:.2f}".format(price))
print("Total: ${:,.2f}".format(price * quantity))

# Method 3: % formatting (older)
print("\n=== % Formatting (Legacy) ===")
print("Product: %s" % product)
print("Price: $%.2f" % price)
print("Total: $%,.2f" % (price * quantity))
