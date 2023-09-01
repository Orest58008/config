if status is-interactive
    # aliases
    alias fish_greeting yass
    alias cat bat
    alias ls "exa -hlF --git --icons --sort type"
    alias lt "ls -T"
    alias rg "rg -ip"
    alias cp "cp -v"
    alias mv "mv -v"
    alias clear "clear && yass"

    # abbreviations
    abbr v "nvim"
    abbr q "exit"
    abbr sp "speedtest --secure"
    abbr r "rm -rfv"

    set AUR_HELPER yay
    set SUDO_COMMAND sudo
    if command -qa $AUR_HELPER
	abbr y "$AUR_HELPER"
	abbr S "$AUR_HELPER -S"
	abbr R "$AUR_HELPER -Rns"
	abbr i "$AUR_HELPER -Si"
	abbr s "$AUR_HELPER -Ss"
    else if command -qa xbps-install
	abbr S "$SUDO_COMMAND xbps-install -Syv"
	abbr R "$SUDO_COMMAND xbps-remove -Rv"
	abbr u "$SUDO_COMMAND xbps-install -Suv"
	abbr i "xbps-query -i"
    end

    abbr dc "distrobox create -i"
    abbr de "distrobox enter"
    abbr ds "distrobox stop"
    abbr dr "distrobox rm"

    abbr ga "git add ."
    abbr gc "git commit -m"
    abbr gp "git push"
    abbr gl "git log"

    abbr gor "go run main.go"
    abbr gob "go build"
    
    # bindings
    bind \ct "tmux"

    # variables
    set -x BAT_THEME "Catppuccin-mocha"
    set -x EDITOR nvim
    set -x PAGER "bat -n"
    set -x FZF_DEFAULT_COMMAND "find -H"
    set -x GPG_TTY $(tty)
    fish_add_path ~/.local/bin/
    fish_add_path ~/.config/emacs/bin/

    # catppuccin theme
    fish_config theme choose "Catppuccin Mocha"

    # starship
    starship init fish | source
end
