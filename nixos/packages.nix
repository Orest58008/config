{ config, pkgs, ... }:

{
  nix.package = pkgs.lix;
  nixpkgs.config.allowUnfree = true;

  programs = {
    gnupg.agent.enable = true;
    zsh = {
      enable = true;
      vteIntegration = true;
    };
  };

  environment = {
    systemPackages = let
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
        posy-cursors
      ];

      gnomePackages = with pkgs.gnome; [
        cheese
        dconf-editor
        eog
        file-roller
        geary
        gnome-calculator
        gnome-terminal
        nautilus
        sushi
      ];

      programPackages = with pkgs; [
        baobab
        evince
        celluloid
        firefox
        gimp
        libreoffice
        lutris
        obs-studio
        nicotine-plus
        steam
        telegram-desktop
        transmission_4-gtk
        vesktop
        wineWowPackages.stable
        wineWowPackages.wayland
        zoom-us
      ];

      servicePackages = with pkgs; [
        arrpc
        emacs-gtk
        nil
      ];
      
    in builtins.concatLists
      [ consolePackages DEPackages gnomePackages programPackages servicePackages ];

    variables = {
      XCURSOR_THEME = "Posy_Cursor";
    };
  };
}
