#!/bin/sh

server=$1
background="-fNL"
foreground="-NL"
options=$background

gappa=27117
study=27118
achoo=27119
snafu=27217
rubik=27317
kaiju=27917

if [ "$server" = "sec" ]; then

  host="gappa"
  port=$gappa

elif [ "$server" = "study" ]; then

  host="study"
  port=$study

elif [ "$server" = "achoo" ]; then

  host="achoo"
  port=$achoo

elif [ "$server" = "stage" ]; then

  host="snafu"
  port=$snafu
  as="localhost"

elif [ "$server" = "puzzle" ]; then

  host="rubik"
  port=$rubik

elif [ "$server" = "pri" ]; then

  host="kaiju"
  port=$kaiju

fi

if [ -z "$as" ]; then
  as="$host.vrack.lichess.ovh"
fi

if [ "$server" = "all" ]; then
  echo "Connecting all servers"
  for server in sec study achoo stage puzzle; do
    echo "$0 $server"
    $0 $server
  done
# if port is defined
elif [ -n "$port" ]; then
  echo "Terminating previous connections to $port"
  for pid in $(lsof -t -i:$port); do
    kill -9 $pid
  done
  echo "Connecting $server to $host.$vrack on port $port"
  command="ssh $options $port:$as:27017 root@$host.lichess.ovh"
  echo $command
  $command
else
  echo "Usage: $0 [all|sec|study|achoo|stage|puzzle|pri]"
fi
