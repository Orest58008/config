{ config, pkgs, ... }:

{
  fonts = {    
    packages = with pkgs; [
      fira-code-nerdfont
      iosevka
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
        monospace = [ "Iosevka Extended" "FiraCode Nerd Font" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
