#!/bin/bash

# 📁 Default backup directory
BACKUP_DIR="/home/ubuntu/backups"
LOG_FILE="/var/log/backup_restore.log"

# 📌 Create backup directory if not exists
mkdir -p "$BACKUP_DIR"
mkdir -p "$(dirname $LOG_FILE)"

# 🛠 Logging function
log_action() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# 🔄 Backup function
backup() {
  TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
  BACKUP_FILE="$BACKUP_DIR/system_backup_$TIMESTAMP.tar.gz"
  log_action "📦 Backup सुरू करत आहे..."

  tar -czf "$BACKUP_FILE" /etc /home /var/log 2>> "$LOG_FILE"
  if [ $? -eq 0 ]; then
    log_action "✅ Backup यशस्वी: $BACKUP_FILE"
  else
    log_action "❌ Backup अयशस्वी"
  fi
}

# 🔁 Restore function
restore() {
  if [ -f "$1" ]; then
    log_action "♻️ Restore सुरू: $1"
    tar -xzf "$1" -C / 2>> "$LOG_FILE"
    if [ $? -eq 0 ]; then
      log_action "✅ Restore यशस्वी"
    else
      log_action "❌ Restore अयशस्वी"
    fi
  else
    log_action "❗ Restore साठी योग्य फाईल द्या"
  fi
}

# 🎯 Main function
case "$1" in
  backup)
    backup
    ;;
  restore)
    restore "$2"
    ;;
  *)
    echo "🧾 वापर: $0 {backup|restore <backup-file-path>}"
    ;;
esac

