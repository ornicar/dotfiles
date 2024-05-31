#!/bin/sh

# https://nixos.wiki/wiki/Battle.net

export WINEARCH=win64
export WINEPREFIX=$HOME/.wine-battlenet
winetricks dxvk

wine64 ~/.wine-battlenet/dosdevices/c:/Program\ Files\ \(x86\)/Battle.net/Battle.net.exe
