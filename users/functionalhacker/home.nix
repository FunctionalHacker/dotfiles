{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./eza.nix
    ./firefox.nix
    ./fzf.nix
    ./git.nix
    ./gnome.nix
    ./gpg.nix
    ./neovim.nix
    ./pass.nix
    ./ripgrep.nix
    ./ssh.nix
    ./zellij.nix
    ./zsh.nix
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
