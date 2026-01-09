#!/bin/bash
display_metrics_dashboard() {
    echo "📊 Auto-Scaling Metrics Dashboard"
    echo "=================================="
    echo "Updated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    
    # Simulate current metrics
    local web_cpu=$((60 + RANDOM % 30))
    local app_cpu=$((65 + RANDOM % 25))
    local db_cpu=$((45 + RANDOM % 20))
    
    echo "Current Resource Usage:"
    echo "  Web Tier:  CPU ${web_cpu}% | Instances: 3 | Load: Normal"
    echo "  App Tier:  CPU ${app_cpu}% | Instances: 4 | Load: Moderate"
    echo "  DB Tier:   CPU ${db_cpu}% | Instances: 2 | Load: Low"
    echo ""
    
    echo "Scaling Status:"
    if [ $web_cpu -gt 85 ]; then
        echo "  Web Tier: 🔴 Scale up recommended"
    elif [ $web_cpu -lt 40 ]; then
        echo "  Web Tier: 🟡 Scale down opportunity"
    else
        echo "  Web Tier: 🟢 Within target range"
    fi
    
    if [ $app_cpu -gt 85 ]; then
        echo "  App Tier: 🔴 Scale up recommended"
    elif [ $app_cpu -lt 40 ]; then
        echo "  App Tier: 🟡 Scale down opportunity"
    else
        echo "  App Tier: 🟢 Within target range"
    fi
    
    echo ""
    echo "Recent Scaling Actions:"
    if [ -f scaling_actions.log ]; then
        tail -n 3 scaling_actions.log || echo "  No recent actions"
    else
        echo "  No scaling actions recorded"
    fi
}

display_metrics_dashboard
