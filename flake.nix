{
  description = "NixOS configuration for nix-hp";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-darwin, ... }:
  let
    system-linux = "x86_64-linux";
    system-darwin = "aarch64-darwin";

    pkgs-unstable-linux = import nixpkgs-unstable {
      system = system-linux;
      config.allowUnfree = true;
    };

    pkgs-unstable-darwin = import nixpkgs-unstable {
      system = system-darwin;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      nix-hp = nixpkgs.lib.nixosSystem {
        system = system-linux;
        modules = [
          ./hosts/nix-hp

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { pkgs-unstable = pkgs-unstable-linux; };
            home-manager.users.jacob = import ./home/jacob;
          }
        ];
      };
    };

    darwinConfigurations = {
      macbook = nix-darwin.lib.darwinSystem {
        system = system-darwin;
        modules = [
          ./hosts/macbook

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { pkgs-unstable = pkgs-unstable-darwin; };
            home-manager.users.jacob = import ./home/jacob/macbook.nix;
          }
        ];
      };
    };
  };
}
