{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.desktop.xmonad;

  bg = "#282828";
  fg = "#ebdbb2";
  yellow = "#d79921";
  active = "#504945";
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rofi
    ];

    xdg.configFile."rofi/config.rasi".text = ''
      configuration {
        modi: "window,run,ssh,drun";
        font: "FiraCode Nerd Font 10";
        show-icons: true;
      }
      * {
        bg: ${bg};
        fg: ${fg};
        yellow: ${yellow};
        active: ${active};
        background-color: @bg;
        text-color: @fg;
      }
      window {
        border: 2px;
        border-color: @yellow;
        border-radius: 8px;
        padding: 5px;
      }
      element {
        padding: 5px;
      }
      element selected {
        background-color: @active;
        text-color: @yellow;
        border-radius: 4px;
      }
    '';
  };
}
