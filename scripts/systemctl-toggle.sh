#!/bin/sh

service=$1
systemctl="systemctl --user"

if $systemctl is-active --quiet $service; then
  $systemctl stop $service
else
  $systemctl start $service
fi
