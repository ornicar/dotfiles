#!/bin/sh

server=$1
background="-fNL"
foreground="-NL"

if [ "$server" = "sec" ]; then

	host="rodan"
	ssh $background 27117:$host.vrack.lichess.ovh:27017 root@$host.lichess.ovh

elif [ "$server" = "study" ]; then

	host="study"
	ssh $background 27118:$host.vrack.lichess.ovh:27017 root@$host.lichess.ovh

elif [ "$server" = "pri" ]; then

	host="kaiju"
	ssh $foreground 27917:$host.vrack.lichess.ovh:27017 root@$host.lichess.ovh

else
	echo "Usage: $0 [sec|study|pri]"
fi
