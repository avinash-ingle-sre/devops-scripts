#!/bin/bash
scan_sql_injection() {
    local file="$1"
    echo "Scanning $file for SQL injection vulnerabilities..."
    
    # Check for f-string SQL queries
    if grep -q 'f"SELECT.*{.*}"' "$file"; then
        echo "  🚨 CRITICAL: SQL injection via f-string detected"
    fi
    
    # Check for string concatenation in SQL
    if grep -q '"SELECT.*".*+.*' "$file"; then
        echo "  🚨 CRITICAL: SQL injection via concatenation detected"
    fi
    
    # Check for format string SQL
    if grep -q '\.format.*SELECT' "$file"; then
        echo "  🚨 CRITICAL: SQL injection via .format() detected"
    fi
}

# Create vulnerable code sample
cat > vulnerable_db.py << 'VULN'
def login(username, password):
    query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
    return execute_query(query)
    
def search(term):
    sql = "SELECT * FROM products WHERE name=" + term
    return db.query(sql)
VULN

scan_sql_injection "vulnerable_db.py"
