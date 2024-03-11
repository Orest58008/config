#!/bin/sh

PATH=$PATH:$HOME/.local/bin

if command -v mycofetch &> /dev/null; then
	echo $(mycofetch -i "#distro:logo_tiny# ") | sed "s/\x1b\[0m//"
else
	echo " "
fi
