{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.desktop.xmonad;
in {
  config = mkIf cfg.enable {
    services.picom = {
      enable = true;
      fade = true;
      fadeDelta = 4;
      shadow = true;
      shadowExclude = [
        "class_g = 'xmobar'"
        "class_g = 'trayer'"
      ];
      settings = {
        corner-radius = 8;
        rounded-corners-exclude = [
          "class_g = 'xmobar'"
          "class_g = 'trayer'"
        ];
      };
    };
  };
}
