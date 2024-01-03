# XDG fixes
export XDG_CONFIG_HOME="$HOME/.config"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
alias d-fi="d-fi -conf $XDG_CONFIG_HOME/d-fi/config.json"

export XDG_DATA_HOME="$HOME/.local/share"
export ANDROID_HOME="$XDG_DATA_HOME"/android
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export NIMBLE_DIR="$XDG_DATA_HOME"/nimble
export WINEPREFIX="$XDG_DATA_HOME"/wine
alias wget="wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"

export XDG_CACHE_HOME="$HOME/.cache"
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var

export XDG_STATE_HOME="$HOME/.local/state"

# $PATH fixes
typeset -U path PATH
path=($path ~/.local/bin $CARGO_HOME/bin $GOPATH/bin $NIMBLE_DIR/bin)
export PATH

# Only in interactive mode
if [[ $- == *i* ]]; then
    # Greeting
    nightfetch

    # Shell configuration
    HISTFILE=~/.config/zsh/.histfile
    setopt autocd beep extendedglob nomatch
    bindkey -e

    # Variables
    export BAT_THEME="Catppuccin-mocha"
    export EDITOR=nvim
    export FZF_DEFAULT_COMMAND="find -H"
    export GPG_TTY=$(tty)
    export MICRO_TRUECOLOR=1
    export PAGER=most

    # Aliases
    alias cat=bat
    alias clear="clear && yass"
    alias cp="cp -v"
    alias imv=imv-dir
    alias ls="exa -GFhl --git --icons --sort type"
    alias lt="ls -T"
    alias la="ls -a"
    alias mv="mv -v"
    alias rg="rg -ip"

    # zcomet setup
    if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
	command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
    fi

    source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

    # Completion
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
	abbr -q -S i="xbps-query -i"
	abbr -q -S R="$SUDO_COMMAND xbps-remove -Rv"
	abbr -q -S S="$SUDO_COMMAND xbps-install -Syv"
	abbr -q -S u="$SUDO_COMMAND xbps-install -Suv"
    fi

    # NOTE: Load zsh-history-substring-search and zsh-autosuggestions after zsh-syntax-highlighting
    # Syntax highlighting
    zcomet load zsh-users/zsh-syntax-highlighting

    # Substring history search
    zcomet load zsh-users/zsh-history-substring-search
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    # Autosuggestions
    zcomet load zsh-users/zsh-autosuggestions

    # Starship
    eval "$(starship init zsh)"
fi
