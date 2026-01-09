#!/bin/bash
source ./metrics_collector.sh
source ./scaling_decision.sh
source ./scaling_executor.sh

run_scaling_cycle() {
    echo "🔄 Auto-Scaling Orchestration Cycle"
    echo "==================================="
    echo "Cycle started: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    
    # Step 1: Collect metrics
    echo "Step 1: Collecting metrics..."
    collect_metrics
    
    # Step 2: Check each tier
    echo ""
    echo "Step 2: Analyzing scaling decisions..."
    
    # Web tier analysis
    web_cpu=$(grep -o '"web_cpu": [0-9]*' current_metrics.json | grep -o '[0-9]*')
    echo "Web tier CPU: ${web_cpu}%"
    make_scaling_decision "web_tier" "$web_cpu" "70"
    web_decision=$?
    
    # App tier analysis  
    app_cpu=$(grep -o '"app_cpu": [0-9]*' current_metrics.json | grep -o '[0-9]*')
    echo "App tier CPU: ${app_cpu}%"
    make_scaling_decision "app_tier" "$app_cpu" "75"
    app_decision=$?
    
    echo ""
    echo "Step 3: Executing scaling actions..."
    
    # Execute actions based on decisions
    case $web_decision in
        0) execute_scaling_action "web_tier" "SCALE_UP" ;;
        1) execute_scaling_action "web_tier" "SCALE_DOWN" ;;
        *) echo "Web tier: No action required" ;;
    esac
    
    case $app_decision in
        0) execute_scaling_action "app_tier" "SCALE_UP" ;;
        1) execute_scaling_action "app_tier" "SCALE_DOWN" ;;
        *) echo "App tier: No action required" ;;
    esac
    
    echo ""
    echo "🏁 Scaling cycle completed"
}

# Run multiple cycles
for cycle in {1..3}; do
    echo "Cycle $cycle:"
    run_scaling_cycle
    echo ""
    sleep 2
done
