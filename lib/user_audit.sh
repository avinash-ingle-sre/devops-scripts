#!/bin/bash
echo "🔐 User List with Sudo Access:"
getent passwd | cut -d: -f1
grep '^sudo' /etc/group
