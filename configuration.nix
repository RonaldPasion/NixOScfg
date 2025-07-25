{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./disk-config.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "NixOS";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultlocale = "en_US.UTF-8";

  services.xserver = 
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

  services.printing.enable = true;

  services.pipewire =
  {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.user.hakkero =
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
    ];

  system.stateVersion = "25.05";
}
