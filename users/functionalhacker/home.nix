{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home = {
    username = "functionalhacker";
    homeDirectory = "/home/functionalhacker";
    stateVersion = "24.05";

    file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/home/.config/nvim";

    packages = with pkgs; [
      cargo
      fzf
      gcc
      nerdfonts
      nodejs
      pass
      tree-sitter
      yarn
      zsh
    ];
  };
}
