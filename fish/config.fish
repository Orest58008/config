if status is-interactive
    # aliases
    alias cat bat
    alias clear "clear && yass"
    alias cp "cp -v"
    alias fish_greeting yass
    alias imv imv-dir
    alias ls "exa -GFhl --git --icons --sort type"
	alias lt "ls -T"
	alias la "ls -a"
    alias mv "mv -v"
    alias rg "rg -ip"

    # abbreviations
    abbr gdl "gallery-dl"
    abbr m "micro"
    abbr q "exit"
    abbr r "trash-put -v"
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

    abbr ga  "git add ."
    abbr gc  "git commit -m"
    abbr gl  "git log"
    abbr gp  "git push"
    abbr gch "git checkout"
    abbr gcb "git checkout -b"
    abbr gsm "git switch main"

    abbr gob "go build"
    abbr gor "go run main.go"
    
    # bindings
    bind \ct "tmux"

    # variables
    set -x BAT_THEME "Catppuccin-mocha"
    set -x EDITOR nvim
    set -x FZF_DEFAULT_COMMAND "find -H"
    set -x GPG_TTY $(tty)
    set -x MICRO_TRUECOLOR 1
    set -x PAGER most

    fish_add_path ~/.local/bin
    fish_add_path ~/.local/share/cargo/bin
    fish_add_path ~/.config/emacs/bin
    fish_add_path ~/.yarn/bin

    # XDG fixes
    set -x XDG_CONFIG_HOME "$HOME/.config"
    set -x _JAVA_OPTIONS -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
    set -x GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc
    alias d-fi "d-fi -conf $XDG_CONFIG_HOME/d-fi/config.json"

    set -x XDG_DATA_HOME "$HOME/.local/share"
    set -x ANDROID_HOME $XDG_DATA_HOME/android
    set -x CARGO_HOME $XDG_DATA_HOME/cargo
    set -x GOPATH $XDG_DATA_HOME/go
    set -x GNUPGHOME $XDG_DATA_HOME/gnupg
    set -x WINEPREFIX $XDG_DATA_HOME/wine
    alias wget "wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"

    set -x XDG_CACHE_HOME "$HOME/.cache"
    set -x TEXMFVAR $XDG_CACHE_HOME/texlive/texmf-var

    set -x XDG_STATE_HOME "$HOME/.local/state"

    # catppuccin theme
    fish_config theme choose flexoki-dark

    # starship
    starship init fish | source
end
