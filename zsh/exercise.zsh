#!/bin/zsh

exdoprod() {
    ssh exerciseprod "cd /www/exercise-deploys/current/ && $*"
}
