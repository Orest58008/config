# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./programs.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  hardware = {
    pulseaudio.enable = false;

    opengl.extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
    ];

    amdgpu = {
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };

      initrd.enable = true;
    };
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "uk_UA.UTF-8";
      LC_IDENTIFICATION = "uk_UA.UTF-8";
      LC_MEASUREMENT = "uk_UA.UTF-8";
      LC_MONETARY = "uk_UA.UTF-8";
      LC_NAME = "uk_UA.UTF-8";
      LC_NUMERIC = "uk_UA.UTF-8";
      LC_PAPER = "uk_UA.UTF-8";
      LC_TELEPHONE = "uk_UA.UTF-8";
      LC_TIME = "uk_UA.UTF-8";
    };
  };

  networking = {
    hostName = "orest-nixos";
    wireless.enable = false;

    networkmanager.enable = true;

    firewall.enable = true;
    firewall.allowedTCPPorts = [  ];
    firewall.allowedUDPPorts = [  ];
  };

  services = {
    xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
        xorg.xprop
      ];

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    gnome = {
      core-utilities.enable = false;
      sushi.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security = {
    rtkit.enable = true;
    sudo.extraConfig = "Defaults env_reset,pwfeedback
    Defaults env_keep += \"VIMINIT XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME\"";
  };

  time.timeZone = "Europe/Kyiv";

  users.users.orest = {
    isNormalUser = true;
    description = "Orest I";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  xdg.portal.enable = true;

  system.stateVersion = "24.05"; # Don't change
}
