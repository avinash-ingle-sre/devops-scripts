#!/bin/bash
scan_weak_crypto() {
    local file="$1"
    echo "Scanning $file for weak cryptographic algorithms..."
    
    # Check for MD5
    if grep -q "hashlib.md5" "$file"; then
        echo "  ⚠️ MEDIUM: Weak hash algorithm MD5 detected"
    fi
    
    # Check for SHA1
    if grep -q "hashlib.sha1" "$file"; then
        echo "  ⚠️ MEDIUM: Weak hash algorithm SHA1 detected"
    fi
    
    # Check for DES
    if grep -q "DES\|\.des" "$file"; then
        echo "  🚨 HIGH: Weak encryption algorithm DES detected"
    fi
}

# Create sample with weak crypto
cat > weak_crypto.py << 'WEAK'
import hashlib

def hash_password(password):
    return hashlib.md5(password.encode()).hexdigest()

def legacy_hash(data):
    return hashlib.sha1(data.encode()).hexdigest()
WEAK

scan_weak_crypto "weak_crypto.py"
