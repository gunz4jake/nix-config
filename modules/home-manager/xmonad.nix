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
            , logHook = dynamicLogWithPP xmobarPP
              { ppOutput = hPutStrLn xmproc
              , ppTitle = xmobarColor "${fg}" "" . shorten 50
              , ppCurrent = xmobarColor "${yellow}" "" . wrap "[" "]"
              }
            } `additionalKeys`
            [ ((mod4Mask, xK_p), spawn "wofi --show run")
            ]
      '';
    };

    home.packages = with pkgs; [
      alacritty
      xmobar
      wofi
    ];

    home.file.".config/xmobar/xmobarrc".text = ''
      Config { font = "xft:Sans-9:bold"
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
             , template = "%StdinReader% }{ %cpu% | %memory% | <fc=${yellow}>%date%</fc>"
             }
    '';

    xdg.configFile."wofi/config".text = ''
      width=600
      height=400
      location=center
      show=drun
      prompt=Run
      allow_markup=true
      no_actions=true
      halign=fill
      orientation=vertical
      content_halign=fill
    '';

    xdg.configFile."wofi/style.css".text = ''
      window {
        margin: 0px;
        border: 2px solid ${yellow};
        background-color: ${bg};
        border-radius: 8px;
      }
      #input {
        margin: 5px;
        border: none;
        color: ${fg};
        background-color: ${altBg};
      }
      #inner-box {
        margin: 5px;
        border: none;
        background-color: ${bg};
      }
      #outer-box {
        margin: 5px;
        border: none;
        background-color: ${bg};
      }
      #scroll {
        margin: 0px;
        border: none;
      }
      #text {
        margin: 5px;
        border: none;
        color: ${fg};
      }
      #entry:selected {
        background-color: ${active};
        border-radius: 4px;
        outline: none;
      }
    '';
  };
}
