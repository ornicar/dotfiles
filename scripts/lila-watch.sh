#!/bin/sh

journalctl --user --since=now -fu lila | /run/current-system/sw/bin/awk '\
/Listening for HTTP on / { system("/run/current-system/sw/bin/notify-send \"lila ready\" -t 1000 -u low") } \
/Failed with result / { system("/run/current-system/sw/bin/notify-send \"lila fail\" -t 2000 -u critical") }'
