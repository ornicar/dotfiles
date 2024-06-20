#!/bin/sh

server=$1
background="-fNL"
foreground="-NL"
options=$background

if [ "$server" = "sec" ]; then

	host="rodan"
	port=27117

elif [ "$server" = "study" ]; then

	host="study"
	port=27118

elif [ "$server" = "stage" ]; then

	host="snafu"
	port=27217
	as="localhost"

elif [ "$server" = "pri" ]; then

	host="kaiju"
	port=27917

fi

if [ -z "$as" ]; then
	as="$host.vrack.lichess.ovh"
fi

# if port is defined
if [ -n "$port" ]; then
	echo "Terminating previous connections to $port"
	for pid in $(lsof -t -i:$port); do
		kill -9 $pid
	done
	echo "Connecting $server to $host.$vrack on port $port"
	command="ssh $options $port:$as:27017 root@$host.lichess.ovh"
	echo $command
	$command
else
	echo "Usage: $0 [sec|study|stage|pri]"
fi
