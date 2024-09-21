{ pkgs, inputs, ... }:
{
  home = {
    file = {
      # Get firefox-gnome-theme files from flake inputs
      ".mozilla/firefox/functionalhacker/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
    };
  };

  programs.firefox = {
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
}
