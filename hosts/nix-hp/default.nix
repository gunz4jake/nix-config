{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/quad9-dot.nix
    ../../modules/nixos/zram.nix
  ];

  networking.hostName = "nix-hp";
  networking.quad9-dot.enable = true;

  # Increase download buffer size to prevent "download buffer is full" warnings
  nix.settings.download-buffer-size = 536870912; # 512 MB
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  time.timeZone = "America/Detroit";

  programs._1password-gui.polkitPolicyOwners = [ "jacob" ];

  custom.desktop.environment = "gnome";

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
