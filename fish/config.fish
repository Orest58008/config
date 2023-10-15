if status is-interactive
    # aliases
    alias cat bat
    alias clear "clear && yass"
    alias cp "cp -v"
    alias fish_greeting yass
    alias ls "exa -GFhl --git --icons --sort type"
	alias lt "ls -T"
	alias la "ls -a"
    alias mv "mv -v"
    alias rg "rg -ip"

    # abbreviations
    abbr m "micro"
    abbr q "exit"
    abbr r "rm -rfv"
    abbr sp "speedtest --secure"
    abbr v "nvim"
    abbr yt-mus "yt-dlp -f bestaudio -x --audio-format mp3 --embed-metadata --embed-thumbnail"

    set AUR_HELPER yay
    set SUDO_COMMAND sudo
    if command -qa $AUR_HELPER
	abbr i "$AUR_HELPER -Qi"
	abbr R "$AUR_HELPER -Rns"
	abbr s "$AUR_HELPER -Ss"
	abbr S "$AUR_HELPER -S"
	abbr y "$AUR_HELPER"
    else if command -qa xbps-install
	abbr i "xbps-query -i"
	abbr R "$SUDO_COMMAND xbps-remove -Rv"
	abbr S "$SUDO_COMMAND xbps-install -Syv"
	abbr u "$SUDO_COMMAND xbps-install -Suv"
    end

    abbr dc "distrobox create -i"
    abbr de "distrobox enter"
    abbr dr "distrobox rm"
    abbr ds "distrobox stop"

    abbr ga "git add ."
    abbr gc "git commit -m"
    abbr gl "git log"
    abbr gp "git push"

    abbr gob "go build"
    abbr gor "go run main.go"
    
    # bindings
    bind \ct "tmux"

    # variables
    set -x BAT_THEME "Catppuccin-mocha"
    set -x EDITOR nvim
    set -x FZF_DEFAULT_COMMAND "find -H"
    set -x GPG_TTY $(tty)
    set -x LANG C.UTF-8
    set -x MICRO_TRUECOLOR 1
    set -x PAGER most

    fish_add_path ~/.local/bin/
    fish_add_path ~/.local/share/cargo/bin/

    # XDG fixes
    set -x XDG_CONFIG_HOME "$HOME/.config"
    set -x GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc

    set -x XDG_DATA_HOME "$HOME/.local/share"
    set -x CARGO_HOME $XDG_DATA_HOME/cargo
    set -x GOPATH $XDG_DATA_HOME/go
    set -x GNUPGHOME $XDG_DATA_HOME/gnupg
    alias wget "wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"

    set -x XDG_CACHE_HOME "$HOME/.cache"
    set -x TEXMFVAR $XDG_CACHE_HOME/texlive/texmf-var

    # catppuccin theme
    fish_config theme choose "Catppuccin Mocha"

    # starship
    starship init fish | source
end
