{ config, pkgs, ... }:

{
  home = {
    username = "functionalhacker";
    homeDirectory = "/home/functionalhacker";
    stateVersion = "24.05";

    packages = with pkgs; [
      bat
      cargo
      fd
      gcc
      neovide
      nerdfonts
      nodejs
      pass
      ripgrep
      tree-sitter
      yarn
    ];

    sessionVariables = {

      # key timeout
      KEYTIMEOUT = 1;

      # prompt customization
      PURE_PROMPT_SYMBOL = "λ";
      PURE_PROMPT_VICMD_SYMBOL = "y";

      # history settings
      HISTFILE = "~/.zsh_history";
      HISTSIZE = 10000;
      SAVEHIST = 10000;

      # fzf settings
      FD_COMMAND = "fd -HLt";
      FZF_DEFAULT_COMMAND = "fd -HLt f";
      FZF_ALT_C_COMMAND = "fd -HLt d";
      FZF_ALT_C_OPTS = "--preview 'eza -l {}'";
      FZF_DEFAULT_OPTS = "-m --ansi --bind ctrl-a:toggle-all,ctrl-d:deselect-all,ctrl-t:toggle-all";
      FZF_COMPLETION_TRIGGER = "**";
      FZF_CTRL_T_COMMAND = "fd -HLt f --strip-cwd-prefix";
      FZF_CTRL_T_OPTS = "--preview 'bat --color=always --style=numbers --line-range=:500 {}'";

      # nvim ftw!
      PAGER = "nvim -R +\"lua require 'pager'\"";
      GIT_PAGER = "nvim -c 'set ft=git' -R +\"lua require 'pager'\"";
      MANPAGER = "nvim +\"lua require 'pager'\" +Man!";
      SYSTEMD_PAGER = "less";

      MARKON_NIXOS = "cool";
    };

    # Just symlink neovim configuration for now.
    # Declarative configuration coming soon™
    file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/home/.config/nvim";
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = false;
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
          { name = "RobSis/zsh-completion-generator"; }
        ];
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = "Marko Korhonen";
      userEmail = "marko@korhonen.cc";
    };
  };
}
