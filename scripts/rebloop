#!/bin/sh

systemctl --user stop bloop
fuser -k 8212/tcp -KILL
find /tmp -name 'bsp-launcher*' -or -name -'metals*' -or -name 'bloop*' | xargs rm -rf {}
rm -rf .metals
rm -rf .bloop
rm -rf target
rm -rf modules/*/target
systemctl --user restart bloop
sleep 1
systemctl --user status bloop
