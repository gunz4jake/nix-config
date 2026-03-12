{ pkgs, pkgs-unstable, ... }:

{
  home.username = "jacob";
  home.homeDirectory = "/Users/jacob";

  # This value should match the Unix Home Manager state version you started using.
  home.stateVersion = "25.11";

  # Let home-manager manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    pkgs.prismlauncher
  ];
}
