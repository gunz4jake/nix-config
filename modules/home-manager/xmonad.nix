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
        import XMonad.Layout.Spacing
        import XMonad.Layout.NoBorders (smartBorders)
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
            , layoutHook = avoidStruts $ smartBorders $ spacingWithEdge 5 $ layoutHook desktopConfig
            , startupHook = do
                spawnOnce "feh --bg-fill ~/.background-image.png"
                spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x282828 --height 24 &"
                spawnOnce "nm-applet &"
                spawnOnce "blueman-applet &"
                spawnOnce "volumeicon &"
                spawnOnce "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"
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
      feh
      trayer
      networkmanagerapplet
      blueman
      volumeicon
      polkit_gnome
    ];
  };
}
