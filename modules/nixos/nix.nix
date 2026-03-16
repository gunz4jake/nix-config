{ config, lib, pkgs, ... }:

{
  nix.settings = {
    # Deduplicate and optimize nix store automatically
    auto-optimise-store = true;
    # Explicitly enable flakes and nix-command
    experimental-features = [ "nix-command" "flakes" ];
    # Prevent "download buffer is full" warnings on slow connections
    download-buffer-size = 536870912; # 512 MB
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
