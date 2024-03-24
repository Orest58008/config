# XDG fixes
export XDG_CONFIG_HOME="$HOME/.config"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship/starship.toml
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
alias d-fi="d-fi -conf $XDG_CONFIG_HOME/d-fi/config.json"

export XDG_DATA_HOME="$HOME/.local/share"
export ANDROID_HOME="$XDG_DATA_HOME"/android
export CABAL_DIR="$XDG_DATA_HOME"/cabal
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export NIMBLE_DIR="$XDG_DATA_HOME"/nimble
export OPAMROOT="$XDG_DATA_HOME"/opam
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export W3M_DIR="$XDG_DATA_HOME"/w3m
export WINEPREFIX="$XDG_DATA_HOME"/wine
alias wget="wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"

export XDG_CACHE_HOME="$HOME/.cache"
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority/texlive/texmf-var
export PKG_CACHE_PATH="$XDG_CACHE_HOME"/pkg-cache
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var

export XDG_STATE_HOME="$HOME/.local/state"

export GHCUP_USE_XDG_DIRS=1

# $PATH fixes
typeset -U path PATH
path=(~/.local/bin $CARGO_HOME/bin $GOPATH/bin $NIMBLE_DIR/bin $path)
export PATH

# Opam setup
[[ ! -r /home/orest/.local/share/opam/opam-init/init.zsh ]] || source /home/orest/.local/share/opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Only in interactive mode
if [[ $- == *i* ]]; then
	# Greeting
	mycofetch -m $XDG_CONFIG_HOME/mycofetch/template.mfc

	# Shell configuration
	setopt autocd beep extendedglob nomatch

	# History configuration
	HISTSIZE=5000
	SAVEHIST=$HISTSIZE
	HISTFILE=~/.config/zsh/.histfile
	setopt appendhistory
	setopt INC_APPEND_HISTORY  
	setopt SHARE_HISTORY
	setopt histignorealldups

	# Bindings
	bindkey -e
	bindkey "^[[H" beginning-of-line # Home
	bindkey "^[[F" end-of-line # End
	bindkey "^[[3~" delete-char # Delete
	bindkey "^[[1;5C" forward-word # C-Right
	bindkey "^[[1;5D" backward-word # C-Left

	# Variables
	export EDITOR=vim
	export FZF_DEFAULT_COMMAND="fd -H"
	export GPG_TTY=$(tty)
	export MICRO_TRUECOLOR=1
	export MANPAGER="bat -l man -p"
	export PAGER=less
	export PINENTRY_USER_DATA="USE_CURSES=1"

	# Aliases
	alias cat="bat -n"
	alias cp="cp -v"
	alias grep="grep -ni --color"
	alias imv=imv-dir
	alias ls="eza -F -Ghl --git --icons --sort type"
	alias mv="mv -v"
	alias mycofetch="mycofetch -m $XDG_CONFIG_HOME/mycofetch/template.mfc"
	alias rg="rg -ip"
	find /opt/plan9 &> /dev/null && alias 9=/opt/plan9/bin/9

	# zcomet setup
	if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
		command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
	fi

	source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

	# Completion
	zstyle ':completion:*' menu select
	zmodload zsh/complist
	zcomet compinit
	zcomet load zsh-users/zsh-completions

	# Abbreviations
	zcomet load olets/zsh-abbr

	# NOTE: keep other abbreviations in $XDG_CONFIG_HOME/zsh-abbr/user-abbreviations
	# NOTE: you can add to that file by `abbr add abbreviation=expansion`
	AUR_HELPER=paru
	SUDO_COMMAND=sudo
	if command -v $AUR_HELPER &> /dev/null; then
		[[ $AUR_HELPER == yay ]] && abbr -q -S y=yay
		[[ $AUR_HELPER == paru ]] && abbr -q -S p=paru
		abbr -q -S i="$AUR_HELPER -Qi"
		abbr -q -S l="$AUR_HELPER -Ql"
		abbr -q -S F="$AUR_HELPER -F"
		abbr -q -S R="$AUR_HELPER -Rns"
		abbr -q -S s="$AUR_HELPER -Ss"
		abbr -q -S S="$AUR_HELPER -S"
	elif command -v xbps-install &> /dev/null; then
		abbr -q -S i="xbps-query"
		abbr -q -S s="xbps-query -Rs"
		abbr -q -S R="$SUDO_COMMAND xbps-remove -Rv"
		abbr -q -S S="$SUDO_COMMAND xbps-install -Syv"
		abbr -q -S u="$SUDO_COMMAND xbps-install -Suv"
	fi

	# Syntax highlighting
	zcomet load zdharma-continuum/fast-syntax-highlighting

	# Substring history search
	zcomet load zsh-users/zsh-history-substring-search
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down

	# Autosuggestions
	zcomet load zsh-users/zsh-autosuggestions

	# Starship
	eval "$(starship init zsh)"
fi
