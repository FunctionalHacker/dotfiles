{
  description = "FunctionalHacker's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations.Mirkwood = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./common.nix
          ./hosts/Mirkwood/configuration.nix
        ];
      };

      homeConfigurations = {
        functionalhacker = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/functionalhacker/home.nix ];
        };
      };
    };
}
