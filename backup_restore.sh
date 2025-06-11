#!/bin/bash

# Backup आणि Restore साठी आवश्यक directory
BACKUP_DIR="/root/backups"
RESTORE_DIR="/tmp/restore-check"

# Timestamp format
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Function: Backup
backup() {
    echo "📦 Backup सुरू करत आहे..."

    FILE_NAME="system_backup_${TIMESTAMP}.tar.gz"
    FILE_PATH="${BACKUP_DIR}/${FILE_NAME}"

    # Directory exists नसेल तर तयार करा
    mkdir -p "$BACKUP_DIR"

    # Backup command (basic system folders)
    tar -czf "$FILE_PATH" /etc /var /home 2>/dev/null

    if [[ $? -eq 0 ]]; then
        echo "✅ Backup यशस्वी: $FILE_PATH"
    else
        echo "❌ Backup अयशस्वी"
    fi
}

# Function: Restore
restore() {
    FILE_PATH=$1

    if [[ -z "$FILE_PATH" ]]; then
        echo "❗ कृपया restore साठी पूर्ण file path द्या."
        echo "उदाहरण: ./backup_restore.sh restore /root/backups/system_backup_2025-06-11_10-57-46.tar.gz"
        exit 1
    fi

    if [[ ! -f "$FILE_PATH" ]]; then
        echo "❗ दिलेली फाईल सापडली नाही: $FILE_PATH"
        exit 1
    fi

    echo "🔁 Restore सुरू आहे: $FILE_PATH"
    mkdir -p "$RESTORE_DIR"
    tar -xzf "$FILE_PATH" -C "$RESTORE_DIR"

    if [[ $? -eq 0 ]]; then
        echo "✅ Restore पूर्ण: $RESTORE_DIR मध्ये फाईल्स extract झाल्या."
    else
        echo "❌ Restore मध्ये अडचण आली"
    fi
}

# Main logic
case $1 in
    backup)
        backup
        ;;
    restore)
        restore "$2"
        ;;
    *)
        echo "❗ कृपया योग्य command वापरा: backup किंवा restore"
        echo "उदाहरण:"
        echo "  ./backup_restore.sh backup"
        echo "  ./backup_restore.sh restore /root/backups/system_backup_YYYY-MM-DD_HH-MM-SS.tar.gz"
        ;;
esac

