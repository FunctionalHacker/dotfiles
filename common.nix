{ config, pkgs, ... }:

{
   imports = [ ./gpg.nix ];
   system.stateVersion = "24.05";
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
