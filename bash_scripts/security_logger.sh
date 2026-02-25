#!/bin/bash
log_security() {
    local level="$1"
    local message="$2"
    echo "[$level] $(date '+%Y-%m-%d %H:%M:%S') - $message"
}
log_security "INFO" "Security system initialized"
log_security "WARN" "Test warning message"
log_security "ERROR" "Test error message"
