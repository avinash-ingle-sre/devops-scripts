#!/bin/bash
source ./security_logger.sh

run_sast_scan() {
    local target="$1"
    local findings=0
    
    log_security "INFO" "Starting SAST scan on: $target"
    
    # SQL injection check
    if grep -q 'f"SELECT.*{.*}"' "$target"; then
        log_security "CRITICAL" "SQL injection vulnerability detected"
        ((findings++))
    fi
    
    # Hardcoded secrets check
    if grep -q 'API_KEY.*=.*"' "$target"; then
        log_security "WARN" "Hardcoded API key detected"
        ((findings++))
    fi
    
    # Weak crypto check
    if grep -q "hashlib.md5" "$target"; then
        log_security "WARN" "Weak cryptographic algorithm detected"
        ((findings++))
    fi
    
    log_security "INFO" "SAST scan completed. Findings: $findings"
    return $findings
}

# Create comprehensive vulnerable file
cat > full_vulnerable_app.py << 'FULLVULN'
import hashlib

API_KEY = "sk-1234567890abcdef"

def authenticate(username, password):
    query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
    return database.execute(query)

def hash_password(password):
    return hashlib.md5(password.encode()).hexdigest()
FULLVULN

run_sast_scan "full_vulnerable_app.py"
