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
  config = mkIf (cfg.enable && !config.custom.desktop.gnome.enable) {
    home.packages = with pkgs; [
      xmobar
      nerd-fonts.fira-code
      xorg.xprop
      (pkgs.writeShellScriptBin "trayer-padding-icon.sh" ''
        #!/bin/sh
        width=$(xprop -name panel | awk '/program specified minimum size/ {print $5}')
        if [ -z "$width" ]; then
            width=$(xprop -class trayer | awk '/program specified minimum size/ {print $5}')
        fi
        if [ -z "$width" ]; then
            width=0
        fi
        
        # If width is 0, output nothing instead of an invalid padding icon.
        if [ "$width" -eq 0 ]; then
            echo ""
            exit 0
        fi

        iconfile="/tmp/trayer-padding-''${width}px.xpm"
        if [ ! -f "$iconfile" ]; then
            echo "/* XPM */" > "$iconfile"
            echo "static char * trayer_pad_xpm[] = {" >> "$iconfile"
            echo "\"$width 1 1 1\"," >> "$iconfile"
            echo "\"  c None\"," >> "$iconfile"
            pixels=$(printf "%''${width}s" "")
            echo "\"$pixels\"};" >> "$iconfile"
        fi
        echo "<icon=$iconfile/>"
      '')
    ];

    home.file.".config/xmobar/xmobarrc".text = ''
      Config { font = "xft:FiraCode Nerd Font:size=10:bold"
             , additionalFonts = [ "xft:FiraCode Nerd Font:size=12" ]
             , bgColor = "${bg}"
             , fgColor = "${fg}"
             , position = TopSize L 100 24
             , commands = [ Run Cpu ["-L","3","-H","50","--normal","${fg}","--high","${red}"] 10
                          , Run Memory ["-t","Mem: <usedratio>%"] 10
                          , Run Battery ["-t", "<left>%"] 50
                          , Run Date "%a, %b %d  %I:%M %p" "date" 10
                          , Run Com "trayer-padding-icon.sh" [] "trayerpad" 10
                          , Run StdinReader
                          ]
             , sepChar = "%"
             , alignSep = "}{"
             , template = " %StdinReader% }{ <fn=1></fn>  %cpu% | <fn=1></fn>  %memory% | <fc=${yellow}><fn=1>󰁹</fn>  %battery% | <fn=1>󰃭</fn>  %date%</fc> %trayerpad%"
             }
    '';
  };
}
