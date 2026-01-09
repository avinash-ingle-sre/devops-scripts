#!/bin/bash
make_scaling_decision() {
    local tier="$1"
    local current_cpu="$2"
    local target_cpu="$3"
    
    echo "Analyzing $tier scaling decision..."
    echo "Current CPU: ${current_cpu}%"
    echo "Target CPU: ${target_cpu}%"
    
    if [ "$current_cpu" -gt $(($target_cpu + 15)) ]; then
        echo "Decision: SCALE_UP (CPU above threshold)"
        return 0
    elif [ "$current_cpu" -lt $(($target_cpu - 20)) ]; then
        echo "Decision: SCALE_DOWN (CPU below threshold)"
        return 1
    else
        echo "Decision: NO_ACTION (CPU within target range)"
        return 2
    fi
}

# Test scaling decisions
make_scaling_decision "web_tier" 85 70
make_scaling_decision "app_tier" 45 75
