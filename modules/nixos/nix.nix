{ config, lib, pkgs, ... }:

{
  nix.settings = {
    # Deduplicate and optimize nix store automatically
    auto-optimise-store = true;
    # Explicitly enable flakes and nix-command
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
