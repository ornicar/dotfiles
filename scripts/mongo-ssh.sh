#!/bin/sh

server=$1
background="-fNL"
foreground="-NL"
options=$background

rodan=27117
study=27118
achoo=27119
snafu=27217
rubik=27317
kaiju=27917

if [ "$server" = "sec" ]; then

  host="rodan"
  port=rodan

elif [ "$server" = "study" ]; then

  host="study"
  port=study

elif [ "$server" = "achoo" ]; then

  host="achoo"
  port=achoo

elif [ "$server" = "stage" ]; then

  host="snafu"
  port=snafu
  as="localhost"

elif [ "$server" = "puzzle" ]; then

  host="rubik"
  port=rubik

elif [ "$server" = "pri" ]; then

  host="kaiju"
  port=kaiju

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
  echo "Usage: $0 [sec|study|stage|puzzle|pri]"
fi
