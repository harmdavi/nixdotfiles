{

description = "My first Flake";

inputs = {
 nixpkgs.url = "nixpkgs/nixos-25.11";
 home-manager.url = "github:nix-community/home-manager/release-25.11";
 home-manager.inputs.nixpkgs.follows = "nixpkgs";

stylix = {
url = "github:nix-community/stylix/release-25.11";
inputs.nixpkgs.follows = "nixpkgs";
};

};

outputs = {self, nixpkgs, home-manager, stylix, ...}:
   let
     lib = nixpkgs.lib;
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};
   in{
     nixosConfigurations = {
     nixos = lib.nixosSystem {
     inherit system;
     modules = [
     stylix.nixosModules.stylix
     ./configuration.nix
     ];
   };
  };
  homeConfigurations = {
     david = home-manager.lib.homeManagerConfiguration{
     inherit pkgs;
     modules = [./home.nix];
  };
};
};
}
