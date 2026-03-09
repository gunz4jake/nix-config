{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.custom.desktop.xmonad;
in {
  options.custom.desktop.xmonad = {
    enable = mkEnableOption "xmonad window manager module";
  };

  config = mkIf cfg.enable {
    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ''
        import XMonad
        import XMonad.Config.Desktop

        main = xmonad desktopConfig
          { terminal    = "alacritty"
          , modMask     = mod4Mask
          }
      '';
    };

    home.packages = with pkgs; [
      alacritty
    ];
  };
}
