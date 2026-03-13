{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.custom.plymouth;
in {
  options.custom.plymouth = {
    enable = mkEnableOption "Plymouth Boot Screen";
  };

  config = mkIf cfg.enable {
    boot.plymouth.enable = true;
  };
}
