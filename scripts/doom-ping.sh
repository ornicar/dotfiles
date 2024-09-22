#!/bin/bash

while ! ping -c 1 141.94.252.178 >/dev/null 2>&1; do
  sleep 1
done

playerctl -p spotify play-pause
