{ config, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    zsh = {
      enable = true;
      zplug = {
        enable = true;
        plugins = [
          { name = "mafredri/zsh-async"; }
          {
            name = "sindresorhus/pure";
            tags = [ "use:pure.zsh" "as:theme" ];
          }
          { name = "Aloxaf/fzf-tab"; }
          { name = "zsh-users/zsh-history-substring-search"; }
          { name = "wfxr/forgit"; }
          { name = "zsh-users/zsh-completions"; }
          { name = "zdharma-continuum/fast-syntax-highlighting"; }
          { name = "RobSis/zsh-completion-generator"; }
        ];
      };
    };
  };

  home = {
    username = "functionalhacker";
    homeDirectory = "/home/functionalhacker";
    stateVersion = "24.05";

    file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/home/.config/nvim";

    packages = with pkgs; [
      cargo
      fd
      fzf
      gcc
      neovide
      nerdfonts
      nodejs
      pass
      ripgrep
      tree-sitter
      yarn
    ];
  };
}
