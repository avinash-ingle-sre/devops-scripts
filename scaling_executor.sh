#!/bin/bash
execute_scaling_action() {
    local tier="$1"
    local action="$2"
    
    echo "🔧 Executing scaling action: $action on $tier"
    
    case "$action" in
        "SCALE_UP")
            echo "  1. Launching new $tier instance..."
            sleep 2
            echo "  2. Configuring instance..."
            sleep 1
            echo "  3. Adding to load balancer..."
            echo "  ✅ Scale up completed"
            ;;
        "SCALE_DOWN")
            echo "  1. Draining connections from $tier instance..."
            sleep 1
            echo "  2. Removing from load balancer..."
            echo "  3. Terminating instance..."
            echo "  ✅ Scale down completed"
            ;;
        *)
            echo "  ↔️ No scaling action required"
            ;;
    esac
    
    # Record action timestamp
    echo $(date +%s) > "${tier}_last_action.txt"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $action on $tier" >> scaling_actions.log
}

# Test scaling actions
execute_scaling_action "web_tier" "SCALE_UP"
execute_scaling_action "app_tier" "SCALE_DOWN"
