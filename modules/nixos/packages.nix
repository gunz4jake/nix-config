{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "jacob" ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
  ];
}
