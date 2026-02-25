#!/bin/bash
# stop a service: ./task05_helpers.sh stop database
# status: ./task05_helpers.sh status
cmd="$1"; svc="$2"
pidfile="/tmp/pids/${svc}.pid"
if [ "$cmd" = "stop" ]; then
  if [ -f "$pidfile" ]; then
    kill -15 $(cat "$pidfile") || true
    rm -f "$pidfile"
    echo "$svc stopped"
  else
    echo "$svc not running"
  fi
elif [ "$cmd" = "status" ]; then
  for s in database cache api webserver; do
    pf="/tmp/pids/$s.pid"
    if [ -f "$pf" ] && kill -0 $(cat "$pf") 2>/dev/null; then
      echo "$s: RUNNING (PID: $(cat $pf))"
    else
      echo "$s: STOPPED"
    fi
  done
fi
