{ config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Just symlink neovim configuration for now.
  # Declarative configuration coming soon™
  home.file = {
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/home/.config/nvim";
  };
}
