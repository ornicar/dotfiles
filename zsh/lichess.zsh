#!/bin/zsh

lichessdoprod() {
    ssh lichess "cd /home/lichess/ && $*"
}
