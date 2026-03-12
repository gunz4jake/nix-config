{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.desktop.xmonad;
  
  bg = "#282828";
  fg = "#ebdbb2";
  yellow = "#d79921";
  red = "#cc241d";
in {
  config = mkIf (cfg.enable && !config.custom.desktop.gnome.enable) {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          font = "FiraCode Nerd Font 10";
          width = 300;
          height = 300;
          origin = "top-right";
          offset = "10x50"; # Leave space for xmobar
          frame_width = 2;
          frame_color = yellow;
          separator_color = "frame";
          corner_radius = 8;
          padding = 8;
          horizontal_padding = 8;
        };
        urgency_low = {
          background = bg;
          foreground = fg;
        };
        urgency_normal = {
          background = bg;
          foreground = fg;
        };
        urgency_critical = {
          background = bg;
          foreground = fg;
          frame_color = red;
        };
      };
    };
  };
}
