#!/bin/bash
THRESHOLD=80
EMAIL="saurabhanavkarmh07@gmail.com"

# Ensure mail command is available
if ! command -v mail &> /dev/null; then
  echo "mail command not found. Please install mailutils."
  exit 1
fi

df -h | grep '^/dev/' | awk '{print $5 " " $1}' | while read output;
do
  usage=$(echo $output | awk '{print $1}' | sed 's/%//')
  partition=$(echo $output | awk '{print $2}')
  
  # Check if usage is a valid number
  if [[ "$usage" =~ ^[0-9]+$ ]]; then
    if [ "$usage" -ge "$THRESHOLD" ]; then
      echo "Warning: Partition $partition is ${usage}% full" | mail -s "Disk Space Alert" "$EMAIL"
    fi
  fi
done

