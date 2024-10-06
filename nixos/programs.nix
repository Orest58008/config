{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs = {
    gnupg.agent.enable = true;
    zsh = {
      enable = true;
      vteIntegration = true;
    };
  };

  environment.systemPackages = let
    consolePackages = with pkgs; [
      bat
      gnupg
      eza
      imagemagick
      starship
      trashy
      vim
      wlprop
      zsh
    ];

    DEPackages = with pkgs; [
      gnomeExtensions.appindicator
      materia-theme
      papirus-icon-theme
    ];

    devPackages = with pkgs; [
      emacs-gtk
      nil
    ];

    gnomePackages = with pkgs.gnome; [
      cheese
      dconf-editor
      eog
      file-roller
      geary
      gnome-terminal
      nautilus
      sushi
    ];

    programPackages = with pkgs; [
      baobab
      evince
      firefox
      gnome-text-editor
      libreoffice
      steam
      telegram-desktop
      vesktop
      zoom-us
    ];
    
  in builtins.concatLists
  [ consolePackages DEPackages devPackages gnomePackages programPackages ];

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
