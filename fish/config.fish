if status is-interactive
    # aliases
    alias fish_greeting=yass
    alias cat=bat
    alias ls='exa -lFh --git --icons --sort type'
    alias rg='rg -ip'
    alias cp='cp -v'
    alias mv='mv -v'
    alias clear='clear && yass'

    # abbreviations
    set AUR_HELPER yay
    abbr y '$AUR_HELPER'
    abbr i '$AUR_HELPER -Si'
    abbr R '$AUR_HELPER -Rns'
    abbr S '$AUR_HELPER -S'
    abbr s '$AUR_HELPER -Ss'
    abbr v 'nvim'
    abbr q 'exit'
    abbr sp 'speedtest --secure'
    abbr r 'rm -rfv'
    abbr dc 'distrobox create -i'
    abbr de 'distrobox enter'
    abbr ds 'distrobox stop'
    abbr dr 'distrobox rm'
    abbr ga 'git add .'
    abbr gc 'git commit -m'
    abbr gp 'git push'
    abbr gl 'git log'
    abbr gor 'go run main.go'
    abbr gob 'go build'
    
    # bindings
    bind \ct 'tmux'

    # variables
    set -x BAT_THEME 'Catppuccin-macchiato'
    set -x EDITOR nvim
    set -x FZF_DEFAULT_COMMAND 'find -H'
    set -x GPG_TTY $(tty)
    fish_add_path ~/.local/bin/
    fish_add_path ~/.config/emacs/bin/

    # catppuccin theme
    fish_config theme choose 'Catppuccin Macchiato'

    # starship
    starship init fish | source
end
