#!/bin/bash

# Variables
BACKUP_DIR="/root/backups"
TIMESTAMP=$(date +%F_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/system_backup_$TIMESTAMP.tar.gz"
RESTORE_DIR="/tmp/restore-check"

# Functions
backup_system() {
    echo "📦 Backup सुरू करत आहे..."
    sudo mkdir -p $BACKUP_DIR
    sudo tar -czf $BACKUP_FILE /etc /var /home 2>/dev/null
    if [[ $? -eq 0 ]]; then
        echo "✅ Backup यशस्वी: $BACKUP_FILE"
    else
        echo "❌ Backup अयशस्वी"
        exit 1
    fi
}

restore_system() {
    echo "🔁 Restore सुरू करत आहे..."
    sudo mkdir -p $RESTORE_DIR
    sudo tar -xzf $1 -C $RESTORE_DIR
    if [[ $? -eq 0 ]]; then
        echo "✅ Restore यशस्वी: $RESTORE_DIR मध्ये फाईल्स"
    else
        echo "❌ Restore अयशस्वी"
        exit 1
    fi
}

# Main
case "$1" in
    backup)
        backup_system
        ;;
    restore)
        if [[ -f $2 ]]; then
            restore_system $2
        else
            echo "❗ Restore साठी योग्य फाईल द्या"
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 {backup|restore <backup_file_path>}"
        exit 1
        ;;
esac

