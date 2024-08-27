#!/bin/bash
THRESHOLD=80
EMAIL="saurabhanavkarmh07@gmail.com"
for partition in $(df -h | grep '^/dev/' | awk '{print $5 " " $1}')
do
  usage=$(echo $partition | awk '{print $1}' | sed 's/%//')
  partition_name=$(echo $partition | awk '{print $2}')
  if [ $usage -ge $THRESHOLD ]; then
    echo "Warning: Partition $partition_name is ${usage}% full" | mail -s "Disk Space Alert" $EMAIL
  fi
done
