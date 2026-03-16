{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.custom.xanmod-bore;
in {
  options.custom.xanmod-bore = {
    enable = mkEnableOption "XanMod kernel with BORE scheduler";
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };
}
