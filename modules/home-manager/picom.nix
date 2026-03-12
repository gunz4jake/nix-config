{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.desktop.xmonad;
in {
  config = mkIf (cfg.enable && !config.custom.desktop.gnome.enable) {
    services.picom = {
      enable = true;
      fade = true;
      fadeDelta = 4;
      shadow = true;
      shadowExclude = [
        "window_type = 'dock'"
        "class_g = 'xmobar'"
        "class_g = 'Xmobar'"
        "class_g = 'trayer'"
        "class_g = 'Trayer'"
      ];
      settings = {
        corner-radius = 8;
        rounded-corners-exclude = [
          "window_type = 'dock'"
          "class_g = 'xmobar'"
          "class_g = 'Xmobar'"
          "class_g = 'trayer'"
          "class_g = 'Trayer'"
        ];
      };
    };
  };
}
