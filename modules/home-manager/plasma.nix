{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.desktop;
in {
  config = mkIf (cfg.environment == "plasma") {
    home.packages = with pkgs; [
      kdePackages.discover
    ];
  };
}
