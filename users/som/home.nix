{ ... }:

{
  imports = [
    ./programs/gnome.nix
  ];

  home = {
    username = "som";
    homeDirectory = "/home/som";
    stateVersion = "24.05";
  };
}
