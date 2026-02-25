#!/bin/bash

# 1. बॅकअप फोल्डर नसेल तर तयार करणे
if [ ! -d "/tmp/backups" ]; then
    mkdir -p /tmp/backups
    echo "Backup directory created."
fi

# 2. सर्व .txt फाइल्स कॉपी करणे
cp /tmp/*.txt /tmp/backups/ 2>/dev/null

# 3. टाइमस्टॅम्प फाइल बनवणे
date > /tmp/backups/backup_timestamp.txt

# 4. किती फाइल्स कॉपी झाल्या ते मोजणे आणि लॉग करणे
count=$(ls /tmp/backups/*.txt 2>/dev/null | wc -l)
echo "Total files backed up: $count" > /tmp/backup_log.txt

echo "Backup process finished!"
