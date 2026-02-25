#!/bin/bash
# collect_metrics.sh - simulate lightweight metrics collection
METRICS_DIR="/tmp/metrics"
mkdir -p "$METRICS_DIR"

timestamp() { date +%s; }
human_time() { date '+%Y-%m-%d %H:%M:%S'; }

# Simulate realistic but safe metrics (small ranges to fit tiny VM)
CPU=$((30 + RANDOM % 40))        # 30-69%
MEMORY=$((40 + RANDOM % 30))     # 40-69%
DISK=$((30 + RANDOM % 40))       # 30-69%
RESP_MS=$((100 + RANDOM % 500))  # 100-599 ms
ERR_RATE=$((RANDOM % 6))         # 0-5 %

TS=$(timestamp)
OUT="$METRICS_DIR/metrics_$TS.json"

cat > "$OUT" <<JSON
{
  "timestamp": $TS,
  "time": "$(human_time)",
  "cpu": $CPU,
  "memory": $MEMORY,
  "disk": $DISK,
  "response_ms": $RESP_MS,
  "error_rate": $ERR_RATE
}
JSON

echo "Collected metrics -> $OUT"
