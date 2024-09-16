{ lib, pkgs, ... }:

{
   home = {
      packages = with pkgs; [
         neofetch
         pass
         zsh
      ];

      username = "functionalhacker";
      homeDirectory = "/home/functionalhacker";
      stateVersion = "24.05";
   };
}
