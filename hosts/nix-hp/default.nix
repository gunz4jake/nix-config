{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/common.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/quad9-dot.nix
    ../../modules/nixos/zram.nix
    ../../modules/nixos/firewall.nix
    ../../modules/nixos/plymouth.nix
  ];

  networking.hostName = "nix-hp";
  networking.quad9-dot.enable = true;

  system.stateVersion = "25.11";
}
