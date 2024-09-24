{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs = {
    firefox.enable = true;
    gnome-terminal.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
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
    gnome.geary
    gnome.nautilus
    gnome.sushi
    libreoffice
    materia-theme
    papirus-icon-theme
    starship
    telegram-desktop
    vesktop
    vim
    wlprop
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
