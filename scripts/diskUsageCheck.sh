#!/bin/sh
[[ $# -lt 1 ]] && { echo "Usage: /bin/bash $0 slackHookKey"; exit 1; }

df -Ph | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5,$1,$6,$4 }' | while read output;
do
  used=$(echo $output | awk '{print $1}' | sed s/%//g)
  remaining=$(echo $output | awk '{print $4}')
  partition=$(echo $output | awk '{print $2}')
  mount=$(echo $output | awk '{print $3}')
  data_drive='/data'
  if [ $used -ge 5 ] && ([ $mount == $data_drive ]) && ([ $used -gt 1 ]); then
    if [ $mount == $data_drive ]; then
      drive='Data Drive'
    fi
    messageText="The $drive mounted on $mount on host $(hostname) has used $used% with $remaining remaining at $(date)"
    curl -X POST -H 'Content-type: application/json' --data '{"text":"'"$messageText"'"}' https://hooks.slack.com/services/$1
  fi
done