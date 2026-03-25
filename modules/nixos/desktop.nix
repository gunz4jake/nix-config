{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.desktop;
in {
  options.custom.desktop = {
    environment = mkOption {
      type = types.enum [ "gnome" "xmonad" "plasma" ];
      default = "gnome";
      description = "Desktop environment to use.";
    };
  };

  config = mkMerge [
    # Propagate the system desktop choice into all home-manager users
    # so it doesn't need to be set separately in the home config.
    {
      home-manager.sharedModules = [{
        custom.desktop.environment = cfg.environment;
      }];
    }
    {
      # Enable the X11 windowing system.
      services.xserver.enable = true;

      # Keymap.
      services.xserver.xkb.layout = "us";

      # Touchpad support.
      services.libinput.enable = true;
    }
    (mkIf (cfg.environment == "gnome") {
      # GNOME Desktop Environment.
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
      # Remove all bundled GNOME utility apps except Nautilus and Console.
      services.gnome.core-utilities.enable = false;
      environment.systemPackages = with pkgs; [ nautilus gnome-console ];
    })
    (mkIf (cfg.environment == "xmonad") {
      # Ly Display Manager
      services.displayManager.ly.enable = true;
      # XMonad Window Manager
      services.xserver.windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    })
    (mkIf (cfg.environment == "plasma") {
      # SDDM Display Manager + KDE Plasma 6
      services.displayManager.sddm.enable = true;
      services.desktopManager.plasma6.enable = true;
    })
  ];
}
