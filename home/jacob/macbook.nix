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
    # pkgs.brave
    pkgs.pfetch-rs
    pkgs.iterm2

    pkgs-unstable.antigravity
  ];

  programs.chromium = {
    enable = true;
    package = pkgs-unstable.brave;
    commandLineArgs = [
      "--disable-features=OutdatedBuildDetector"
    ];
  };

  programs.zsh = {
    enable = true;
    
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
      ];
    };

    initContent = ''
      pfetch
    '';

    shellAliases = {
      # Rebuild the macOS system using nix-darwin
      darwin-rebuild = "sudo darwin-rebuild switch --flake ~/Jacob/Coding/nix-config#macbook";
      
      # Update flake inputs
      nix-update = "nix flake update --flake ~/Jacob/Coding/nix-config";

      # vim opens neovim
      vim = "nvim";
    };
  };
}
