#!/bin/bash
handle_brute_force_attack() {
    local attacker_ip="$1"
    echo "🚨 INCIDENT: Brute force attack detected from $attacker_ip"
    
    # Log incident
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] BRUTE_FORCE_ATTACK from $attacker_ip" >> security_incidents.log
    
    # Automated response
    echo "🤖 Automated Response:"
    echo "  1. Blocking IP: $attacker_ip"
    echo "  2. Increasing authentication logging"
    echo "  3. Notifying security team"
    
    # Create blocking script
    echo "iptables -A INPUT -s $attacker_ip -j DROP" > "block_$attacker_ip.sh"
    chmod +x "block_$attacker_ip.sh"
    
    echo "✅ Incident response completed"
}

# Simulate incident
handle_brute_force_attack "203.0.113.100"
