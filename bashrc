# XDG configuration
export XDG_CONFIG_HOME="$HOME"/.config
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
alias d-fi='d-fi -conf "$XDG_CONFIG_HOME"/d-fi/config.json'

export XDG_DATA_HOME="$HOME"/.local/share
export ANDROID_HOME="$XDG_DATA_HOME"/android
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export NIMBLE_DIR="$XDG_DATA_HOME"/nimble
export WINEPREFIX="$XDG_DATA_HOME"/wine
alias wget='wget --hsts-file="$XDG_DATA_HOME"/wget-hsts'

export XDG_CACHE_HOME="$HOME"/.cache
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var

export XDG_STATE_HOME="$HOME"/.local/state
export HISTFILE="$XDG_STATE_HOME"/bash/history

# PATH configuration
export PATH="$PATH":"$HOME"/.local/bin:"$CARGO_HOME"/bin:"$GOPATH"/bin:"$NIMBLE_DIR"/bin:/opt/plan9/bin

# Interactive configuration
if [[ $- == *i* ]]; then
	# greeting
	nightfetch
	
	# starship
	eval "$(starship init bash)"
	
	# ble.sh
	source /usr/share/blesh/ble.sh

	# aliases
	alias cat=bat
	alias clear="clear && yass"
	alias cp="cp -v"
	alias imv=imv-dir
	alias ls="exa -GFhl --git --icons --sort type"
	alias lt="ls -T"
	alias la="ls -a"
	alias mv="mv -v"
	alias rg="rg -ip"
	alias sl="command ls"
	alias q=exit

	# abbreviations
	ble-sabbrev gdl=gallery-dl
	ble-sabbrev m=micro
	ble-sabbrev q=exit
	ble-sabbrev r="trash-put -v"
	ble-sabbrev sp="speedtest --secure"
	ble-sabbrev v=nvim
	ble-sabbrev yt-mus="yt-dlp -f bestaudio -x --embed-metadata --embed-thumbnail"

	AUR_HELPER=paru
	SUDO_COMMAND=sudo
	if command -v $AUR_HELPER &> /dev/null; then
	    [ $AUR_HELPER == "yay"  ] && ble-sabbrev y="$AUR_HELPER"
	    [ $AUR_HELPER == "paru" ] && ble-sabbrev p="$AUR_HELPER"
	    ble-sabbrev F="$AUR_HELPER -F"
	    ble-sabbrev i="$AUR_HELPER -Qi"
	    ble-sabbrev l="$AUR_HELPER -Ql"
	    ble-sabbrev R="$AUR_HELPER -Rns"
	    ble-sabbrev S="$AUR_HELPER -S"
	    ble-sabbrev s="$AUR_HELPER -Ss"
	elif command -v xbps-install &> /dev/null; then
	    ble-sabbrev i="xbps-query -i"
	    ble-sabbrev R="$SUDO_COMMAND xbps-remove -Rv"
	    ble-sabbrev S="$SUDO_COMMAND xbps-install -Syv"
	    ble-sabbrev u="$SUDO_COMMAND xbps-install -Suv"
	fi

	ble-sabbrev dc="distrobox create -i"
	ble-sabbrev de="distrobox enter"
	ble-sabbrev dr="distrobox rm"
	ble-sabbrev ds="distrobox stop"
	ble-sabbrev dl="distrobox list"

	ble-sabbrev ga="git add ."
	ble-sabbrev gc="git commit -m"
	ble-sabbrev gl="git log"
	ble-sabbrev gp="git push"
	ble-sabbrev gch="git checkout"
	ble-sabbrev gcb="git checkout -b"
	ble-sabbrev gsm="git switch main"
	
	# variables
	export BAT_THEME=Catppuccin-mocha
	export EDITOR=nvim
	export FZF_DEFAULT_COMMAND="fd -H"
	export GPG_TTY="$(tty)"
	export MICRO_TRUECOLOR=1
	export PAGER=most

	ble-attach
fi
