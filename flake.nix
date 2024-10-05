{
  description = "FunctionalHacker's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, nur, ... } @inputs:
    let
      configureNixSystem = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Common settings for all hosts
          ({ pkgs, ... }: import ./nixos_common.nix
            { inherit inputs; inherit pkgs; })

          # Host specific configuration
          ./hosts/${hostname}/configuration.nix

          # home-manager
          home-manager.nixosModules.home-manager
          ({ ... }: import ./home-manager.nix { inherit inputs; })
        ];
      };

    in
    {
      nixosConfigurations = {
        Mirkwood = configureNixSystem "Mirkwood";
        Shire = configureNixSystem "Shire";
      };
    };
}
