{ ... }:

{
  programs = {
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

                # fzf settings
                _fzf_compgen_path() {
                  resultcmd="$FZF_DEFAULT_COMMAND . $1"
                  eval "''${resultcmd}
                }
                _fzf_compgen_dir() {
                  resultcmd="$FZF_ALT_C_COMMAND . $1"
                  eval "''${resultcmd}
                }
        # nvim ftw!
                export PAGER="$EDITOR -R +\"lua require 'pager'\""
                export GIT_PAGER="$EDITOR -c 'set ft=git' -R +\"lua require 'pager'\""
                export MANPAGER="$EDITOR +\"lua require 'pager'\" +Man!"
                export SYSTEMD_EDITOR=$EDITOR
                export SYSTEMD_PAGER=less


                if [ "''${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
                  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
                fi

                # use <ESC> e to open command in editor
                autoload edit-command-line; zle -N edit-command-line
                bindkey -M vicmd e edit-command-line

                # bind delete in normal mode
                bindkey -M vicmd '^[[3~' delete-char

                # Rebind fzf to ctrl+f
                bindkey '^F' fzf-file-widget
                bindkey '^T' transpose-chars

                # Remove grc alias from forgit since it
                # collides with the grc colorizer
                unalias grc;

                # Launch or attach zellij to existing session if logging in over ssh
                if [[ -z "$ZELLIJ" && -n "$SSH_CONNECTION" ]]; then
                  exec zellij attach -c SSH
                fi
      '';
      shellAliases = {
        # Navigation
        ".." = "cd ..";

        # Editor
        vi = "nvim";
        vim = "nvim";
        dv = "nvim +DiffviewOpen";

        # systemd
        sc = "systemctl";
        scu = "systemctl --user";
        jc = "journalctl";
        jcu = "journalctl --user";

        # Move to trash instead of remove
        rm = "trash";

        # git shorthands
        gc = "git commit";
        gac = "ga && gc";
        gs = "git status";
        gpull = "git pull";
        gpush = "git push";

        o = "xdg-open";

        # Fix aliases with sudo
        sudo = "sudo ";
      };

      history = {
        share = true;
        extended = true;
        ignoreAllDups = true;
      };

      historySubstringSearch.enable = true;

      dirHashes = {
        git = "$HOME/git";
        dotfiles = "$HOME/git/dotfiles";
        dl = "$HOME/Downloads";
      };
    };
  };
}
