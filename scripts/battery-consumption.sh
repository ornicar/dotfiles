#!/bin/sh

file=/sys/class/power_supply/BAT0/uevent
log=/tmp/battery-consumption-log

while true
do
  sleep 3
  content=$(cat $file)
  voltage=$(echo "$content" | awk '/VOLTAGE_NOW/ { print substr($1,26) }')
  current=$(echo "$content" | awk '/CURRENT_NOW/ { print substr($1,26) }')
  consumption=$((voltage / 1000000 * current / 1000000))
  echo "$(date +"%m/%d %H:%M:%S") $consumption" >> $log
done
