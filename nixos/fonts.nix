{ config, pkgs, ... }:

{
  fonts = {    
    packages = with pkgs; [
      cascadia-code
      fira-code-nerdfont
      source-sans
      source-han-sans
      source-serif
      source-han-serif
      twitter-color-emoji
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Source Sans 3"];
        serif = [ "Source Serif 4" ];
        monospace = [ "Cascadia Code" "FiraCode Nerd Font" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
