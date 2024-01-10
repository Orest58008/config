#!/bin/sh

PATH=$PATH:$HOME/.local/bin

if command -v nightfetch &> /dev/null; then
	echo $(nightfetch -i "{distro:logo_tiny} ") | sed "s/\x1b\[0m//"
else
	echo " "
fi
