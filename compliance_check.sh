#!/bin/bash
validate_infrastructure_compliance() {
    local config="$1"
    echo "Validating infrastructure compliance..."
    
    # Check SSH port policy
    if grep -q "ssh_port: 22" "$config"; then
        echo "  ⚠️ WARNING: Default SSH port in use"
    fi
    
    # Check encryption policy
    if grep -q "encryption: false" "$config"; then
        echo "  🚨 VIOLATION: Encryption at rest not enabled"
    fi
    
    # Check backup policy
    if grep -q "backup: disabled" "$config"; then
        echo "  ⚠️ WARNING: Automated backups not configured"
    fi
}

# Create sample infrastructure config
cat > infrastructure.yaml << 'INFRA'
servers:
  web-01:
    ssh_port: 22
    encryption: false
    backup: disabled
  db-01:
    ssh_port: 2222
    encryption: true
    backup: enabled
INFRA

validate_infrastructure_compliance "infrastructure.yaml"
