{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.custom.desktop.xmonad;

  # Gruvbox Dark Colors
  bg = "#282828";
  fg = "#ebdbb2";
  yellow = "#d79921";
  orange = "#fe8019";
  active = "#504945";
  red = "#cc241d";
  altBg = "#3c3836";

in {
  options.custom.desktop.xmonad = {
    enable = mkEnableOption "xmonad window manager module";
  };

  config = mkIf cfg.enable {
    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = pkgs.writeText "xmonad.hs" ''
        import XMonad
        import XMonad.Config.Desktop
        import XMonad.Hooks.DynamicLog
        import XMonad.Hooks.ManageDocks
        import XMonad.Util.Run (spawnPipe)
        import XMonad.Util.SpawnOnce (spawnOnce)
        import XMonad.Util.EZConfig (additionalKeys)
        import System.IO

        main = do
          xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
          xmonad $ desktopConfig
            { terminal    = "alacritty"
            , modMask     = mod4Mask
            , focusedBorderColor = "${yellow}"
            , normalBorderColor = "${active}"
            , borderWidth = 2
            , manageHook = manageDocks <+> manageHook desktopConfig
            , layoutHook = avoidStruts $ layoutHook desktopConfig
            , startupHook = do
                spawnOnce "feh --bg-fill ~/.background-image.png"
                startupHook desktopConfig
            , logHook = dynamicLogWithPP xmobarPP
              { ppOutput = hPutStrLn xmproc
              , ppTitle = xmobarColor "${fg}" "" . shorten 50
              , ppCurrent = xmobarColor "${yellow}" "" . wrap "[" "]"
              }
            } `additionalKeys`
            [ ((mod4Mask, xK_p), spawn "rofi -show drun")
            ]
      '';
    };

    home.packages = with pkgs; [
      alacritty
      xmobar
      rofi
      picom
      feh
      nerd-fonts.fira-code
    ];

    services.picom = {
      enable = true;
      fade = true;
      fadeDelta = 4;
      shadow = true;
      shadowExclude = [ "class_g = 'xmobar'" ];
      settings = {
        corner-radius = 8;
      };
    };

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
