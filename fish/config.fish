if status is-interactive
    # aliases
    alias yass="echo && command yass"
    alias fish_greeting=yass
    alias cat=bat
    alias ls="exa -lFh --git --icons --sort type"
    alias rg="rg -ip"
    alias clear="clear && yass"

    # abbreviations
    abbr s "sudo"
    abbr i "paru -Si"
    abbr R "paru -Rns"
    abbr S "paru -S"
    abbr v "nvim"
    abbr p "paru"
    abbr e "exit"
    abbr q "exit"
    abbr sp "speedtest --secure"
    abbr r "rm -rfv"
    abbr dc "distrobox create -i"
    abbr de "distrobox enter"
    abbr ds "distrobox stop"
    abbr dr "distrobox rm"

    # variables
    set -x PAGER most
    set -x BAT_THEME "Catppuccin-frappe"
    set -x EDITOR nvim
    fish_add_path ~/.local/bin/

    # catppuccin theme
    fish_config theme choose "Catppuccin Frappe"

    # starship
    starship init fish | source
end
