{ pkgs, ... }:

{
  imports = [
    ./programs/default.nix
  ];

  home = {
    username = "functionalhacker";
    homeDirectory = "/home/functionalhacker";
    stateVersion = "24.05";

    packages = with pkgs; [
      cargo
      fd
      file
      gcc
      grc
      imagemagick
      neovide
      nerdfonts
      nodejs
      trash-cli
      tree-sitter
      usbutils
      wl-clipboard
      yarn
      zip
    ];
  };
}
