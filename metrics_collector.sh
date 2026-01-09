#!/bin/bash
collect_metrics() {
    local timestamp=$(date +%s)
    local cpu_web=$((50 + RANDOM % 30))
    local cpu_app=$((60 + RANDOM % 25))
    
    echo "Timestamp: $timestamp"
    echo "Web CPU: ${cpu_web}%"
    echo "App CPU: ${cpu_app}%"
    
    # Save to file
    echo "{\"timestamp\": $timestamp, \"web_cpu\": $cpu_web, \"app_cpu\": $cpu_app}" > current_metrics.json
}

collect_metrics
