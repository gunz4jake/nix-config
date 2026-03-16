{ config, lib, pkgs, ... }: {
  networking.firewall = {
    enable = true;
    checkReversePath = "loose";
    allowedUDPPorts = [
      51821 # WireGuard
    ];
  };
}