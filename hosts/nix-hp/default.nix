{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/boot.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/packages.nix
  ];

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.jacob = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # This value defines the first NixOS version you installed on this machine,
  # and is used to maintain compatibility with application data created on older
  # versions. Do NOT change this value unless you have read the relevant docs.
  system.stateVersion = "25.11";
}
