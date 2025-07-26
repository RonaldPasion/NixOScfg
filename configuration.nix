{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./disk-config.nix
    ];

  boot =
  {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "resume_offset=533760" ];
    resumeDevice = "/dev/disk/by-label/nixos";
  };

  networking.hostName = "NixOS";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  services =
  {
    xserver =
    {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb =
      {
        layout = "us";
        options = "caps:hyper"; # turn Capslock into Hyper key
      };  
    };
    
    printing.enable = true;

    pipewire =
    {
      enable = true;
      pulse.enable = true;
    };

    libinput.enable = true;
    
    power-profiles-daemon.enable = false;
    tlp =
    {
      enable = true;
      settings =
      {
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };

  users.users.hakkero =
  {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ];
    packages = with pkgs; 
    [
      tree 
    ];
  };
  
  environment.systemPackages = with pkgs;
    [
      vim
      wget
      git
      brave
    ];

  system.stateVersion = "25.05";
}
