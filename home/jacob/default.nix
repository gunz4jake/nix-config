{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ../../modules/home-manager/desktop.nix
    ../../modules/home-manager/gnome.nix
    ../../modules/home-manager/xmonad.nix
    ../../modules/home-manager/xmobar.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/picom.nix
    ../../modules/home-manager/dunst.nix
    ../../modules/home-manager/plasma.nix
  ];

  home.username = "jacob";
  home.homeDirectory = "/home/jacob";

  # This value should match the NixOS release you installed from.
  # Do NOT change it unless you have read the relevant documentation.
  home.stateVersion = "25.11";

  # Let home-manager manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set fish_function_path ${pkgs.fishPlugins.pure}/share/fish/vendor_functions.d $fish_function_path
      for f in ${pkgs.fishPlugins.pure}/share/fish/vendor_conf.d/*.fish
        source $f
      end
      pfetch
    '';
    shellAliases = {
      vim = "nvim";
      ":q" = "exit";
    };
  };

  # ---------------------------------------------------------------------------
  # User packages:
  #   - Use `pkgs.*`          for stable (nixos-25.11) packages.
  #   - Use `pkgs-unstable.*` for the latest unstable packages.
  # ---------------------------------------------------------------------------
  home.packages = with pkgs; [
    pkgs.openmw
    pkgs.remmina
    pkgs.htop
    pkgs.pfetch-rs
    pkgs.moonlight-qt

    pkgs-unstable.brave
    pkgs-unstable.prismlauncher
    pkgs-unstable.claude-code-bin
  ];
}
