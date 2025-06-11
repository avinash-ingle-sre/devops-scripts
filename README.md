# DevOps Utility Scripts

This repository contains useful bash scripts for DevOps monitoring and automation:

- `monitor.sh`: System health monitoring
- `backup.sh`: Backup and archive important directories
- `logrotate`: Auto-rotate log files weekly

## Setup

1. Clone the repo
2. Make scripts executable
3. Add cron jobs for automation


## 🛠️ DevOps Script Library

| Script Name             | Description                                  |
|-------------------------|----------------------------------------------|
| cleanup_logs.sh         | Deletes old log files                        |
| monitor_disk_usage.sh   | Checks and alerts if disk usage exceeds 80% |
| backup_restore.sh       | Performs backup and restore of system files |
| ec2_health_check.sh     | Checks EC2 instance health                   |
| check_port.sh           | Verifies if specific ports are open         |
| git_auto_commit.sh      | Auto-commits Git changes with timestamp     |
| apache_restart.sh       | Restarts Apache service with logging         |
| user_audit_report.sh    | Generates user login audit logs             |
| cron_job_checker.sh     | Lists and audits cron jobs per user         |
| resource_alert.sh       | Sends alerts if CPU/memory usage is high    |
