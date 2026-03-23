{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.custom.xanmod;
in {
  options.custom.xanmod = {
    enable = mkEnableOption "XanMod kernel";
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };
}
