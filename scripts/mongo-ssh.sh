#!/bin/sh

server=$1
background="-fNL"
foreground="-NL"

if [ "$server" = "sec" ]; then

	host="rodan"
	port=27117

elif [ "$server" = "study" ]; then

	host="study"
	port=27118

elif [ "$server" = "pri" ]; then

	host="kaiju"
	port=27119

fi

# if port is defined
if [ -n "$port" ]; then
	echo "Terminating previous connections to $port"
	for pid in $(lsof -t -i:$port); do
		kill -9 $pid
	done
	echo "Connecting $server to $host on port $port"
	ssh $background $port:$host.vrack.lichess.ovh:27017 root@$host.lichess.ovh
else
	echo "Usage: $0 [sec|study|pri]"
fi
