#!/bin/zsh

lichessdoprod() {
    ssh phobos "cd /home/lichess && $*"
}
