{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ../../modules/home-manager/xmonad.nix
    ../../modules/home-manager/xmobar.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/picom.nix
    ../../modules/home-manager/dunst.nix
    ../../modules/home-manager/gnome.nix
  ];

  custom.desktop.xmonad.enable = true;
  custom.desktop.gnome.enable = true;

  home.username = "jacob";
  home.homeDirectory = "/home/jacob";

  # This value should match the NixOS release you installed from.
  # Do NOT change it unless you have read the relevant documentation.
  home.stateVersion = "25.11";

  # Let home-manager manage itself.
  programs.home-manager.enable = true;

  # ---------------------------------------------------------------------------
  # User packages:
  #   - Use `pkgs.*`          for stable (nixos-25.11) packages.
  #   - Use `pkgs-unstable.*` for the latest unstable packages.
  # ---------------------------------------------------------------------------
  home.packages = with pkgs; [
    pkgs.openmw

    pkgs-unstable.antigravity
    pkgs-unstable.brave
    pkgs-unstable.prismlauncher
  ];
}
