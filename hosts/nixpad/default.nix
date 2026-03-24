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
    ../../modules/nixos/undervolt.nix
    ../../modules/nixos/xanmod.nix
    ../../modules/nixos/snapper.nix
  ];

  networking.hostName = "nixpad";
  networking.quad9-dot.enable = true;
  custom.xanmod.enable = true;

  # Use S3 deep sleep instead of s2idle — dramatically reduces battery drain on suspend.
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  # Intel UHD 620 — hardware video decoding.
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  # Bluetooth (laptop — disabled at boot to save power, toggle as needed).
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  networking.extraHosts =
    ''
      10.4.24.146 IT-O-22793.masonk12.net
    '';

  system.stateVersion = "25.11";
}
