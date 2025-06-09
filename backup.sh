#!/bin/bash

BACKUP_DIR="$HOME/backups"
LOG_FILE="$BACKUP_DIR/backup.log"
mkdir -p $BACKUP_DIR

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="$BACKUP_DIR/system_backup_$TIMESTAMP.tar.gz"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting Backup..." | tee -a $LOG_FILE

tar -czf $BACKUP_FILE /etc /var/log /home/ubuntu 2>>$LOG_FILE

if [[ $? -eq 0 ]]; then
  echo "✅ Backup successful: $BACKUP_FILE" | tee -a $LOG_FILE
else
  echo "❌ Backup failed!" | tee -a $LOG_FILE
fi

echo "" >> $LOG_FILE

