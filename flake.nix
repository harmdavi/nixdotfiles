{
  description = "My first Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-src = {
      url = "github:neovim/neovim?ref=release-0.12";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim-src, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          # specialArgs passes 'self' into configuration.nix so it can read packages.${system}.default
          specialArgs = { inherit self; }; 
          modules = [ ./configuration.nix ];
        };
      };

      homeConfigurations = {
        david = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };

      # Build and export the package directly right here
packages.${system}.default = pkgs.wrapNeovim (pkgs.callPackage "${neovim-src}/contrib/nix" {}) {};
    };
}
