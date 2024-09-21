{
  description = "FunctionalHacker's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, nur, ... } @inputs:
    {
      nixosConfigurations.Mirkwood = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/Mirkwood/configuration.nix
          ./nixos_common.nix
          { nixpkgs.overlays = [ nur.overlay ]; }

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              backupFileExtension = "bak";
              users.functionalhacker =
                import ./users/functionalhacker/home.nix;
            };
          }
        ];
      };
    };
}
