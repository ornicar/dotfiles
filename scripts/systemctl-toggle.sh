#!/bin/sh

service=$1
systemctl="systemctl --user"

# start service if it's not running
# or stop service if it's running

if $systemctl is-active --quiet $service; then
  $systemctl stop $service
else
  $systemctl start $service
fi
