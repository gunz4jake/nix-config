{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.desktop.gnome;
in {
  options.custom.desktop.gnome = {
    enable = mkEnableOption "GNOME settings and extensions";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnomeExtensions.blur-my-shell
    ];

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "blur-my-shell@aunetx"
        ];
      };

      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };
    };
  };
}
