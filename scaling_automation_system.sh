#!/bin/bash
# Scaling Automation Helper Script  
# Purpose: Intelligent auto-scaling system for multi-tier applications
#
# Usage:
#   ./scaling_helper.sh metrics
#   ./scaling_helper.sh decide <tier>
#   ./scaling_helper.sh scale <tier> <action>
#   ./scaling_helper.sh report
#
# Demonstrates:
# - Multi-tier application scaling (web, app, database)
# - Metric collection and analysis
# - Intelligent scaling decisions with cooldowns
# - Cost optimization and predictive scaling
# - Comprehensive scaling reporting and monitoring

SCALING_CONFIG="./scaling_config.json"
METRICS_DIR="./scaling_metrics"
INSTANCES_DIR="./instances"
SCALING_LOG="./scaling.log"
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")

print_scaling_header() {
    echo "========================================"
    echo "  ⚡ $1"
    echo "========================================"
}

log_scaling() {
    local level="$1"
    local msg="$2"
    echo "[$level] $(date "+%Y-%m-%d %H:%M:%S") - $msg" | tee -a "$SCALING_LOG"
}

log_info() { log_scaling "INFO" "$1"; }
log_warn() { log_scaling "WARN" "$1"; }
log_error() { log_scaling "ERROR" "$1"; }

# Initialize scaling environment
init_scaling_system() {
    mkdir -p "$METRICS_DIR" "$INSTANCES_DIR"
    
    # Create scaling configuration
    cat > "$SCALING_CONFIG" <<CONFIG
{
  "web_tier": {
    "min_instances": 2,
    "max_instances": 10,
    "target_cpu": 70,
    "target_memory": 80,
    "scale_up_threshold": 85,
    "scale_down_threshold": 50,
    "cooldown_minutes": 5
  },
  "app_tier": {
    "min_instances": 3,
    "max_instances": 8,
    "target_cpu": 75,
    "target_response_time": 200,
    "scale_up_threshold": 85,
    "scale_down_threshold": 45,
    "cooldown_minutes": 10
  },
  "db_tier": {
    "min_instances": 1,
    "max_instances": 3,
    "target_cpu": 80,
    "scale_up_threshold": 85,
    "cooldown_minutes": 15
  }
}
CONFIG

    # Create current instance state
    cat > "$INSTANCES_DIR/current_state.json" <<INSTANCES
{
  "web_tier": {
    "current_instances": 2,
    "instance_type": "t3.medium",
    "last_action": "none",
    "last_action_time": null
  },
  "app_tier": {
    "current_instances": 3,
    "instance_type": "t3.large", 
    "last_action": "none",
    "last_action_time": null
  },
  "db_tier": {
    "current_instances": 1,
    "instance_type": "r5.xlarge",
    "last_action": "none",
    "last_action_time": null
  }
}
INSTANCES
    
    log_info "Scaling system initialized"
}

# Collect application metrics
collect_scaling_metrics() {
    local timestamp=$(date +%s)
    
    print_scaling_header "Metrics Collection"
    log_info "Collecting application metrics"
    
    # Simulate realistic metrics with traffic patterns
    local hour=$(date +%H)
    local base_load=30
    
    # Simulate daily traffic pattern
    if [ "$hour" -ge 9 ] && [ "$hour" -le 17 ]; then
        base_load=60  # Business hours
    elif [ "$hour" -ge 18 ] && [ "$hour" -le 22 ]; then
        base_load=80  # Evening peak
    fi
    
    # Add random variation
    local cpu_web=$((base_load + RANDOM % 30 - 15))
    local cpu_app=$((base_load + 10 + RANDOM % 20 - 10))
    local cpu_db=$((base_load - 10 + RANDOM % 20 - 10))
    
    local memory_web=$((base_load - 5 + RANDOM % 20 - 10))
    local memory_app=$((base_load + 5 + RANDOM % 20 - 10))
    
    local response_time=$((150 + (base_load - 30) * 5 + RANDOM % 100))
    local active_connections=$((50 + (base_load - 30) * 2 + RANDOM % 30))
    
    # Store metrics
    cat > "$METRICS_DIR/metrics_$timestamp.json" <<METRICS
{
  "timestamp": $timestamp,
  "web_tier": {
    "avg_cpu": $cpu_web,
    "avg_memory": $memory_web,
    "instance_count": 2,
    "requests_per_second": $((base_load * 8))
  },
  "app_tier": {
    "avg_cpu": $cpu_app,
    "avg_memory": $memory_app,
    "avg_response_time": $response_time,
    "instance_count": 3
  },
  "db_tier": {
    "avg_cpu": $cpu_db,
    "active_connections": $active_connections,
    "instance_count": 1
  }
}
METRICS
    
    echo "📊 Current Metrics:"
    echo "  Web Tier - CPU: ${cpu_web}%, Memory: ${memory_web}%"
    echo "  App Tier - CPU: ${cpu_app}%, Response Time: ${response_time}ms"
    echo "  DB Tier - CPU: ${cpu_db}%, Connections: $active_connections"
    
    log_info "Metrics collected successfully"
    return 0
}

# Make scaling decision for a tier
make_scaling_decision() {
    local tier="$1"
    
    print_scaling_header "Scaling Decision: $tier"
    
    # Get latest metrics
    local latest_metrics=$(ls -t "$METRICS_DIR"/metrics_*.json 2>/dev/null | head -1)
    if [ -z "$latest_metrics" ]; then
        log_error "No metrics available for scaling decision"
        return 1
    fi
    
    # Extract metrics for specific tier
    local current_cpu=0
    local current_instances=1
    local target_cpu=70
    local scale_up_threshold=85
    local scale_down_threshold=50
    
    case "$tier" in
        "web_tier")
            current_cpu=$(grep -A5 '"web_tier"' "$latest_metrics" | grep "avg_cpu" | grep -o '[0-9]*')
            current_instances=$(grep -A5 '"web_tier"' "$latest_metrics" | grep "instance_count" | grep -o '[0-9]*')
            target_cpu=70
            scale_up_threshold=85
            ;;
        "app_tier")
            current_cpu=$(grep -A5 '"app_tier"' "$latest_metrics" | grep "avg_cpu" | grep -o '[0-9]*')
            current_instances=$(grep -A5 '"app_tier"' "$latest_metrics" | grep "instance_count" | grep -o '[0-9]*')
            target_cpu=75
            scale_up_threshold=85
            ;;
        "db_tier")
            current_cpu=$(grep -A5 '"db_tier"' "$latest_metrics" | grep "avg_cpu" | grep -o '[0-9]*')
            current_instances=$(grep -A5 '"db_tier"' "$latest_metrics" | grep "instance_count" | grep -o '[0-9]*')
            target_cpu=80
            scale_up_threshold=85
            ;;
    esac
    
    echo "Current State:"
    echo "  CPU Usage: ${current_cpu}%"
    echo "  Instances: $current_instances"
    echo "  Target CPU: ${target_cpu}%"
    echo "  Scale Up Threshold: ${scale_up_threshold}%"
    
    # Scaling logic
    local action="none"
    local reason="Within normal parameters"
    
    if [ "$current_cpu" -gt "$scale_up_threshold" ]; then
        action="scale_up"
        reason="CPU usage above ${scale_up_threshold}%"
        log_warn "Scale up recommended: $reason"
    elif [ "$current_cpu" -lt "$scale_down_threshold" ] && [ "$current_instances" -gt 1 ]; then
        action="scale_down"
        reason="CPU usage below ${scale_down_threshold}%"
        log_info "Scale down opportunity: $reason"
    fi
    
    echo "Decision: $action"
    echo "Reason: $reason"
    
    echo "$action"
    return 0
}

# Execute scaling action
execute_scaling_action() {
    local tier="$1"
    local action="$2"
    
    print_scaling_header "Executing: $action on $tier"
    
    # Check cooldown period
    local last_action_time=$(grep -A5 ""$tier"" "$INSTANCES_DIR/current_state.json" | grep "last_action_time" | grep -o '[0-9]*' | head -1)
    local current_time=$(date +%s)
    local cooldown_minutes=10
    
    if [ -n "$last_action_time" ] && [ "$last_action_time" != "null" ]; then
        local time_diff=$(((current_time - last_action_time) / 60))
        if [ "$time_diff" -lt "$cooldown_minutes" ]; then
            echo "⏳ Cooldown active: $((cooldown_minutes - time_diff)) minutes remaining"
            log_warn "Scaling action blocked by cooldown period"
            return 1
        fi
    fi
    
    case "$action" in
        "scale_up")
            echo "🚀 Scaling up $tier..."
            echo "  1. Launching new instance..."
            sleep 2
            echo "  2. Configuring instance..."
            sleep 1
            echo "  3. Adding to load balancer..."
            sleep 1
            echo "✅ Scale up completed"
            
            # Create launch script
            cat > "/tmp/launch_${tier}.sh" <<LAUNCH
#!/bin/bash
# Auto-scaling launch script for $tier
echo "Launching $tier instance at $(date)"
echo "Instance will be ready in 2-3 minutes"
LAUNCH
            ;;
            
        "scale_down")
            echo "🔽 Scaling down $tier..."
            echo "  1. Draining connections from instance..."
            sleep 2
            echo "  2. Removing from load balancer..."
            sleep 1
            echo "  3. Terminating instance..."
            sleep 1
            echo "✅ Scale down completed gracefully"
            ;;
    esac
    
    # Log scaling action
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $action on $tier" >> "$SCALING_LOG"
    log_info "Scaling action completed: $action on $tier"
    
    return 0
}

# Cost optimization analysis
analyze_cost_optimization() {
    print_scaling_header "Cost Optimization Analysis"
    
    # Calculate current costs (simulated)
    local web_cost=$((2 * 50))    # 2 instances * $50/month
    local app_cost=$((3 * 100))   # 3 instances * $100/month
    local db_cost=$((1 * 200))    # 1 instance * $200/month
    local total_cost=$((web_cost + app_cost + db_cost))
    
    echo "Current Monthly Costs:"
    echo "  Web Tier: \$$web_cost (2 instances)"
    echo "  App Tier: \$$app_cost (3 instances)"
    echo "  DB Tier: \$$db_cost (1 instance)"
    echo "  Total: \$$total_cost/month"
    
    echo ""
    echo "💰 Cost Optimization Opportunities:"
    echo "  • Use spot instances for dev/test (up to 70% savings)"
    echo "  • Reserved instances for baseline capacity (up to 60% savings)"
    echo "  • Right-size instances based on actual usage"
    echo "  • Schedule scale-down during off-hours"
    
    local optimized_cost=$((total_cost * 75 / 100))
    echo ""
    echo "💡 Potential monthly savings: \$$((total_cost - optimized_cost)) (25% reduction)"
}

# Predictive scaling analysis
run_predictive_scaling() {
    print_scaling_header "Predictive Scaling Analysis"
    
    local current_hour=$(date +%H)
    echo "Current time: $(printf "%02d:00" $current_hour)"
    
    echo ""
    echo "Traffic Predictions (next 4 hours):"
    
    for i in {1..4}; do
        local future_hour=$(((current_hour + i) % 24))
        local predicted_load=30
        
        # Simulate traffic patterns
        if [ "$future_hour" -ge 9 ] && [ "$future_hour" -le 17 ]; then
            predicted_load=65
        elif [ "$future_hour" -ge 18 ] && [ "$future_hour" -le 22 ]; then
            predicted_load=85
        fi
        
        printf "  %02d:00 - Expected Load: %d%% " "$future_hour" "$predicted_load"
        
        if [ "$predicted_load" -gt 80 ]; then
            echo "(🚀 Pre-scale recommended)"
        elif [ "$predicted_load" -lt 40 ]; then
            echo "(🔽 Scale-down opportunity)"
        else
            echo "(↔️ Current capacity sufficient)"
        fi
    done
    
    echo ""
    echo "📋 Predictive Actions:"
    echo "  • Pre-scale web tier before evening peak"
    echo "  • Scale down non-critical services overnight"
    echo "  • Prepare for weekend traffic patterns"
}

# Generate comprehensive scaling report
generate_scaling_report() {
    print_scaling_header "Auto-Scaling Report"
    echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    
    # Scaling actions today
    local scaling_actions=$(grep -c "scale_" "$SCALING_LOG" 2>/dev/null || echo 0)
    echo ""
    echo "Scaling Activity (24h):"
    echo "  Total actions: $scaling_actions"
    echo "  Scale-up events: $(grep -c "scale_up" "$SCALING_LOG" 2>/dev/null || echo 0)"
    echo "  Scale-down events: $(grep -c "scale_down" "$SCALING_LOG" 2>/dev/null || echo 0)"
    
    echo ""
    echo "Current Capacity:"
    echo "  Web tier: 2 instances (t3.medium)"
    echo "  App tier: 3 instances (t3.large)"
    echo "  DB tier: 1 instance (r5.xlarge)"
    
    echo ""
    echo "Performance Metrics:"
    echo "  Average response time: 175ms ✅"
    echo "  Error rate: 0.01% ✅"
    echo "  Availability: 99.99% ✅"
    
    echo ""
    echo "🎯 Scaling Efficiency: 89/100"
    echo "  ✅ Reactive scaling: Active"
    echo "  ✅ Cost optimization: Enabled"
    echo "  🟡 Predictive scaling: Learning"
    
    log_info "Scaling report generated successfully"
}

# Main scaling automation dispatcher
ACTION="${1:-help}"
case "$ACTION" in
    init)
        init_scaling_system
        ;;
    metrics)
        collect_scaling_metrics
        ;;
    decide)
        TIER="$2"
        if [ -z "$TIER" ]; then
            echo "Usage: $0 decide <tier>"
            exit 1
        fi
        make_scaling_decision "$TIER"
        ;;
    scale)
        TIER="$2"
        ACTION_TYPE="$3"
        if [ -z "$TIER" ] || [ -z "$ACTION_TYPE" ]; then
            echo "Usage: $0 scale <tier> <action>"
            exit 1
        fi
        execute_scaling_action "$TIER" "$ACTION_TYPE"
        ;;
    cost)
        analyze_cost_optimization
        ;;
    predict)
        run_predictive_scaling
        ;;
    report)
        generate_scaling_report
        ;;
    *)
        cat <<'USAGE'
Scaling Automation Helper

Usage: ./scaling_helper.sh <command> [arguments]

Commands:
  init                        - Initialize scaling system
  metrics                     - Collect current application metrics
  decide <tier>               - Make scaling decision for tier
  scale <tier> <action>       - Execute scaling action
  cost                        - Analyze cost optimization opportunities  
  predict                     - Run predictive scaling analysis
  report                      - Generate comprehensive scaling report

Tiers: web_tier, app_tier, db_tier
Actions: scale_up, scale_down

Examples:
  ./scaling_helper.sh init
  ./scaling_helper.sh metrics
  ./scaling_helper.sh decide web_tier
  ./scaling_helper.sh scale app_tier scale_up
USAGE
        ;;
esac

