#!/bin/bash
scan_for_secrets() {
    local file="$1"
    echo "Scanning $file for hardcoded secrets..."
    
    # Check for API keys
    if grep -q "API_KEY.*=.*"" "$file"; then
        echo "  ⚠️ FOUND: Hardcoded API key"
    fi
    
    # Check for passwords
    if grep -q "PASSWORD.*=.*"" "$file"; then
        echo "  ⚠️ FOUND: Hardcoded password"
    fi
    
    # Check for tokens
    if grep -q "TOKEN.*=.*"" "$file"; then
        echo "  ⚠️ FOUND: Hardcoded token"
    fi
}

# Create sample file with secrets
cat > sample_app.py << 'SAMPLE'
API_KEY = "sk-1234567890abcdef"
PASSWORD = "admin123"
TOKEN = "ghp_xxxxxxxxxxxxxxxxxxxx"
SAMPLE

scan_for_secrets "sample_app.py"
