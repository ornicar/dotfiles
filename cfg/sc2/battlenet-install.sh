#!/bin/sh

# https://nixos.wiki/wiki/Battle.net

INSTALLER_FILE=~/Downloads/Battle.net-Setup.exe

wget --output-document $INSTALLER_FILE 'https://downloader.battle.net//download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live'

export WINEARCH=win64
export WINEPREFIX=$HOME/.wine-battlenet

winetricks dxvk

wine64 $INSTALLER_FILE
