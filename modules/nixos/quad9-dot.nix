{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.networking.quad9-dot;
in {
  options.networking.quad9-dot = {
    enable = mkEnableOption "Quad9 DNS over TLS";
  };

  config = mkIf cfg.enable {
    networking.nameservers = [
      "9.9.9.9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
    ];

    services.resolved = {
      enable = true;
      dnsovertls = "true";
      dnssec = "true";
    };
  };
}
