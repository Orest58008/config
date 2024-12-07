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
        tealdeer
        trashy
        vim
        wlprop
        zsh
      ];

      DEPackages = with pkgs; [
        gnomeExtensions.appindicator
        gnomeExtensions.dim-completed-calendar-events
        gnomeExtensions.just-perfection
        materia-theme
        papirus-icon-theme
        posy-cursors
      ];

      gnomePackages = with pkgs; [
        cheese
        dconf-editor
        eog
        file-roller
        geary
        gnome-calculator
        gnome-sound-recorder
        gnome-terminal
        gnome-tweaks
        nautilus
        sushi
      ];

      programPackages = with pkgs; [
        baobab
        evince
        celluloid
        firefox
        gimp
        inkscape
        libreoffice
        lutris
        obs-studio
        nicotine-plus
        rhythmbox
        steam
        telegram-desktop
        transmission_4-gtk
        vesktop
        vscodium-fhs
        wineWowPackages.stable
        wineWowPackages.wayland
        zoom-us
      ];

      servicePackages = with pkgs; [
        arrpc
        bintools
        distrobox
        gamemode
        git
        git-lfs
        linuxHeaders
        nil
        wl-clipboard
      ];

    in builtins.concatLists
    [ consolePackages DEPackages gnomePackages programPackages servicePackages ];
  };
}
