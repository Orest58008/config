if status is-interactive
   # aliases
    alias yass="echo && command yass"
    alias fish_greeting=yass
    alias cat=bat
    alias find=fd
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
    set -x EDITOR nvim
    fish_add_path ~/.local/bin/

   # one dark palette
    set fish_color_command c678dd    #magenta
    set fish_color_quote 98c379      #green
    set fish_color_error be5046      #dark red
    set fish_color_param abb2bf      #white
    set fish_color_valid_path 61afef #blue
    set fish_color_option afbfbf     #light white
    set fish_color_comment 5c6370    #comment grey
    set fish_color_operator 61afef   #blue
    set fish_color_escape be5046     #dark red

   # starship
    starship init fish | source
end
