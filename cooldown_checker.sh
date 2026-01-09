#!/bin/bash
check_cooldown() {
    local tier="$1"
    local cooldown_minutes="$2"
    local last_action_file="${tier}_last_action.txt"
    
    echo "Checking cooldown for $tier (cooldown: $cooldown_minutes minutes)..."
    
    if [ ! -f "$last_action_file" ]; then
        echo "No previous scaling action found - OK to scale"
        return 0
    fi
    
    local last_action_time=$(cat "$last_action_file")
    local current_time=$(date +%s)
    local time_diff=$(((current_time - last_action_time) / 60))
    
    echo "Last action: $time_diff minutes ago"
    
    if [ "$time_diff" -lt "$cooldown_minutes" ]; then
        echo "Cooldown active - $(($cooldown_minutes - $time_diff)) minutes remaining"
        return 1
    else
        echo "Cooldown expired - OK to scale"
        return 0
    fi
}

# Test cooldown logic
echo $(date +%s) > web_tier_last_action.txt
check_cooldown "web_tier" 10
