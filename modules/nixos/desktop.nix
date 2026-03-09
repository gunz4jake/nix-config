{ ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Keymap.
  services.xserver.xkb.layout = "us";

  # Touchpad support.
  services.libinput.enable = true;

  # Browser.
  programs.firefox.enable = true;
}
