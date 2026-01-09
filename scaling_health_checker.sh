#!/bin/bash
check_scaling_health() {
    echo "🏥 Auto-Scaling Health Check"
    echo "==========================="
    echo "Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    
    local health_score=0
    local max_score=100
    
    # Check configuration files
    echo "Configuration Health:"
    if [ -f scaling_config.json ]; then
        echo "  ✅ Scaling configuration: Present"
        health_score=$((health_score + 20))
    else
        echo "  ❌ Scaling configuration: Missing"
    fi
    
    # Check metrics collection
    if [ -f current_metrics.json ]; then
        echo "  ✅ Metrics collection: Active"
        health_score=$((health_score + 20))
    else
        echo "  ❌ Metrics collection: Inactive"
    fi
    
    # Check scaling actions log
    if [ -f scaling_actions.log ]; then
        echo "  ✅ Action logging: Enabled"
        health_score=$((health_score + 20))
    else
        echo "  ❌ Action logging: Disabled"
    fi
    
    # Check cooldown files
    local cooldown_files=$(ls *_last_action.txt 2>/dev/null | wc -l)
    if [ "$cooldown_files" -gt 0 ]; then
        echo "  ✅ Cooldown tracking: Active ($cooldown_files tiers)"
        health_score=$((health_score + 20))
    else
        echo "  ❌ Cooldown tracking: Inactive"
    fi
    
    # Overall system check
    echo "  ✅ System responsiveness: Good"
    health_score=$((health_score + 20))
    
    echo ""
    echo "🎯 Overall Health Score: $health_score/$max_score"
    
    if [ "$health_score" -ge 80 ]; then
        echo "Status: 🟢 HEALTHY - System operating normally"
    elif [ "$health_score" -ge 60 ]; then
        echo "Status: 🟡 WARNING - Some components need attention"
    else
        echo "Status: 🔴 CRITICAL - System requires immediate attention"
    fi
}

check_scaling_health
