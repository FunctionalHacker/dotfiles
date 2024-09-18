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
      usbutils
      wl-clipboard
      yarn
    ];

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
      initExtra = ''
        # key timeout
        export KEYTIMEOUT=1

        # prompt customization
        export PURE_PROMPT_SYMBOL="λ"
        export PURE_PROMPT_VICMD_SYMBOL="y"

        # history settings
        export HISTFILE=~/.zsh_history
        export HISTSIZE=10000
        export SAVEHIST=10000
        # Additional settings (source https://jdhao.github.io/2021/03/24/zsh_history_setup)
        setopt HIST_IGNORE_ALL_DUPS
        setopt HIST_SAVE_NO_DUPS
        setopt HIST_REDUCE_BLANKS
        setopt INC_APPEND_HISTORY_TIME
        setopt EXTENDED_HISTORY

        # Enable completions for aliases
        setopt no_complete_aliases

        # fzf settings
        export FD_COMMAND='fd -HLt'
        export FZF_DEFAULT_COMMAND="$FD_COMMAND f"
        export FZF_ALT_C_COMMAND="$FD_COMMAND d"
        export FZF_ALT_C_OPTS="--preview 'eza -l {}'"
        export FZF_DEFAULT_OPTS='-m --ansi --bind ctrl-a:toggle-all,ctrl-d:deselect-all,ctrl-t:toggle-all'
        export FZF_COMPLETION_TRIGGER='**'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --strip-cwd-prefix"
        export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'

        # nvim ftw!
        export EDITOR=nvim
        export PAGER="$EDITOR -R +\"lua require 'pager'\""
        export GIT_PAGER="$EDITOR -c 'set ft=git' -R +\"lua require 'pager'\""
        export MANPAGER="$EDITOR +\"lua require 'pager'\" +Man!"
        export SYSTEMD_EDITOR=$EDITOR
        export SYSTEMD_PAGER=less


        if [ "''${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
          export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
        fi
      '';
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = "Marko Korhonen";
      userEmail = "marko@korhonen.cc";

      extraConfig = {
        user.signingkey = "F2B9F713E7ED627336DD85E444FA3F28CD931BB0";
        commit = {
          gpgsign = true;
          signoff = true;
        };
        tag = {
          gpgsign = true;
          signoff = true;
        };
        merge = {
          prompt = false;
          conflictstyle = "diff3";
          tool = "nvim";
        };
      };
    };
  };
}
