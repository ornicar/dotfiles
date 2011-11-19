#!/bin/sh

PID=`cat ~/.offlineimap/pid`
ps aux | grep "[ ]$PID" && kill $PID

function sync_normal {
    echo "NORMAL Sync"
    offlineimap -o -u quiet
}
function sync_quick {
    echo "QUICK Sync"
    offlineimap -o -q -u quiet
}

# This is silly.
python -c'import sys, random; sys.exit(random.randint(0, 5))' && sync_normal || sync_quick

exit 0
