{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.nur.hmModules.nur ];
  home = {
    username = "functionalhacker";
    homeDirectory = "/home/functionalhacker";
    stateVersion = "24.05";

    packages = with pkgs; [
      bat
      cargo
      eza
      fd
      gcc
      grc
      neovide
      nerdfonts
      nodejs
      ripgrep
      trash-cli
      tree-sitter
      usbutils
      wl-clipboard
      yarn
      zip
    ];

    file = {
      # Just symlink neovim configuration for now.
      # Declarative configuration coming soon™
      ".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/home/.config/nvim";

      # Get firefox-gnome-theme files from flake inputs
      ".mozilla/firefox/functionalhacker/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
    };
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
                export FD_COMMAND='fd -HLt'
                export FZF_DEFAULT_COMMAND="$FD_COMMAND f"
                export FZF_ALT_C_COMMAND="$FD_COMMAND d"
                export FZF_ALT_C_OPTS="--preview 'eza -l {}'"
                export FZF_DEFAULT_OPTS='-m --ansi --bind ctrl-a:toggle-all,ctrl-d:deselect-all,ctrl-t:toggle-all'
                export FZF_COMPLETION_TRIGGER='**'
                export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --strip-cwd-prefix"
                export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'
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
        ls = "eza --icons --git";

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

    zellij = {
      enable = true;
      settings = {
        theme = "kanagawa";
        session_serialization = false;
        keybinds = {
          unbind = "Ctrl g";
          shared_except = {
            _args = [ "locked" ];
            "bind \"Ctrl l\"" = {
              SwitchToMode = "Locked";
            };
          };
          locked = {
            "bind \"Ctrl l\"" = {
              SwitchToMode = "Normal";
            };
          };
        };
      };
    };

    firefox = {
      enable = true;

      profiles.functionalhacker = {
        name = "FunctionalHacker";
        userChrome = ''
          @import "firefox-gnome-theme/userChrome.css";
        '';
        userContent = ''
          @import "firefox-gnome-theme/userContent.css";
        '';
        settings = {
          ## Firefox gnome theme ## - https://github.com/rafaelmardojai/firefox-gnome-theme/blob/1c32013cdbe17406de496cdf5f6899b84c4bbfed/configuration/user.js
          # (copied into here because home-manager already writes to user.js)
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Enable customChrome.cs
          # Set UI density to normal
          "browser.uidensity" = 0;

          # Enable SVG context-propertes
          "svg.context-properties.content.enabled" = true;

          # Disable private window dark theme
          "browser.theme.dark-private-windows" = false;

          # Enable rounded bottom window corners
          "widget.gtk.rounded-bottom-corners.enabled" = true;

          # Firefox gnome theme optional settings
          "gnomeTheme.hideSingleTab" = true;
          "gnomeTheme.hideWebrtcIndicator" = true;

          # Auto enable installed addons
          "extensions.autoDisableScopes" = 0;
        };
        search = {
          default = "Korhonen Search";
          engines = {
            "Korhonen Search" = {
              urls = [
                {
                  template = "https://search.korhonen.cc/search?q={searchTerms}";
                  iconUpdateURL = "https://search.korhonen.cc/favicon.ico";
                  updateInterval = 24 * 60 * 60 * 1000; # Once a day
                }
              ];
            };
          };
        };

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          browserpass
          darkreader
        ];

      };
    };

    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    };

    browserpass = {
      enable = true;
      browsers = [ "firefox" ];
    };
  };
}
