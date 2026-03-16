{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.desktop.xmonad;
  inherit (import ./gruvbox.nix) bg fg yellow red;
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
