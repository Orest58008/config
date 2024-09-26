{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs = {
    file-roller.enable = true;
    firefox.enable = true;
    gnome-terminal.enable = true;
    gnupg.agent.enable = true;
    steam.enable = true;
    zsh = {
      enable = true;
      vteIntegration = true;
    };
  };

  environment.systemPackages = with pkgs; [
    baobab
    bat
    evince
    eza
    gnome.dconf-editor
    gnome.eog
    gnome.geary
    gnome.nautilus
    gnome.sushi
    gnomeExtensions.appindicator
    imagemagick
    libreoffice
    materia-theme
    papirus-icon-theme
    starship
    telegram-desktop
    vesktop
    vim
    wlprop
    zoom-us
  ];

  fonts = {    
    packages = with pkgs; [
      fira-code-nerdfont
      inter
      liberation_ttf
      noto-fonts-cjk-sans
      twitter-color-emoji
    ];

    fontconfig.defaultFonts = {
      emoji = [ "Twitter Color Emoji" ];
      monospace = [ "FiraCode Nerd Font" ];
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Inter Variable" ];
    };
  };
}
