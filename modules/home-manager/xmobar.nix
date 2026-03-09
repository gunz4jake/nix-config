{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.desktop.xmonad;

  bg = "#282828";
  fg = "#ebdbb2";
  yellow = "#d79921";
  orange = "#fe8019";
  active = "#504945";
  red = "#cc241d";
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xmobar
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    home.file.".config/xmobar/xmobarrc".text = ''
      Config { font = "xft:FiraCode Nerd Font:size=10:bold"
             , additionalFonts = [ "xft:FiraCode Nerd Font:size=12" ]
             , bgColor = "${bg}"
             , fgColor = "${fg}"
             , position = Top
             , commands = [ Run Cpu ["-L","3","-H","50","--normal","${fg}","--high","${red}"] 10
                          , Run Memory ["-t","Mem: <usedratio>%"] 10
                          , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                          , Run StdinReader
                          ]
             , sepChar = "%"
             , alignSep = "}{"
             , template = " %StdinReader% }{ <fn=1></fn>  %cpu% | <fn=1></fn>  %memory% | <fc=${yellow}><fn=1>󰃭</fn>  %date%</fc> "
             }
    '';
  };
}
