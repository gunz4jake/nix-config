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
      gnome-tweaks
      gnome-extension-manager
    ];

    gtk = {
      enable = true;
      theme.name = "Adwaita";
    };

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "blur-my-shell@aunetx"
        ];
      };

      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
        clock-format = "12h";
        cursor-theme = "Bibata-Modern-Classic";
        cursor-size = 24;
        color-scheme = "prefer-dark";
        accent-color = "red";
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };
    };

    home.pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    xdg.configFile."autostart/1password.desktop".text = ''
      [Desktop Entry]
      Name=1Password
      Exec=1password --silent
      Terminal=false
      Type=Application
      Icon=1password
      StartupWMClass=1Password
      Comment=Password manager and secure wallet
      Categories=Office;Utility;
    '';
  };
}
