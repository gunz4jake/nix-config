{ lib, ... }:

with lib;

{
  options.custom.desktop = {
    environment = mkOption {
      type = types.enum [ "gnome" "xmonad" "plasma" ];
      default = "gnome";
      description = "Desktop environment/WM to configure for the user session.";
    };
  };
}
