#!/bin/bash

source_dir="/tmp/backup"
backup_dir="/mnt/web_backups"
source_webfiles="/var/www/html"
source_logs="/var/log/apache2"
max_backups=3
timestamp=$(date +%Y-%m-%d_%H:%M:%S)
backup_name="web_backup"
backup_file="${backup_name}_${timestamp}.tar.gz"

sudo mkdir -p "$backup_dir" "$source_dir"

#Check if there is webfiles or logs
if [ -d "$source_webfiles" ] || [ -d "$source_logs" ]; then

	if [ -d "$source_webfiles" ]; then
                sudo cp -r "$source_webfiles" "$source_dir"
        fi

        if [ -d "$source_logs" ]; then
                sudo cp -r "$source_logs" "$source_dir"
        fi

        sudo tar -czf "${backup_dir}/${backup_file}" "$source_dir"
	sudo rm -rf "$source_dir"
fi

#Check the quantity of backups, if limit is reached then delete the oldest backup
backup_count=$(ls -1 "$backup_dir" | grep -c "$backup_name")
if [[ $backup_count -gt $max_backups ]]; then
  backup_old=($(ls -ltr --time=atime "$backup_dir" | grep "$backup_name" | awk '{print $9}' | head -n 1))
  sudo rm -f "$backup_dir/$backup_old"
  echo "Removed backup: $backup_old"
fi

echo "Backup completed: $backup_file"
