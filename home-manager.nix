{ inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "hm-backup";
    users = {
      functionalhacker = import ./users/functionalhacker/home.nix;
      som = import ./users/som/home.nix;
    };
  };
}
