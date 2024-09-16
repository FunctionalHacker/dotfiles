{ lib, pkgs, ... }:

{
   home = {
      username = "functionalhacker";
      homeDirectory = "/home/functionalhacker";
      stateVersion = "24.05";

      packages = with pkgs; [
         neofetch
         pass
         zsh
      ];
   };
}
