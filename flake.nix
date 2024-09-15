{
   description = "FunctionalHacker's NixOS config";

   inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
   };

   outputs = { self, nixpkgs, ...}@inputs: {
      nixosConfigurations.Mirkwood = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         modules = [
            ./hosts/Mirkwood/configuration.nix
            ./gpg.nix
         ];
      };
   };
}
