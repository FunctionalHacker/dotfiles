{ lib, pkgs, ... }:

with lib.hm.gvariant;

{
  home.packages = with pkgs.gnomeExtensions; [
    gsconnect
    night-theme-switcher
    appindicator
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "gsconnect@andyholmes.github.io"
        "nightthemeswitcher@romainvigier.fr"
        "appindicatorsupport@rgcjonas.gmail.com"
      ];

      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "org.telegram.desktop.desktop"
      ];
    };

    "org/gnome/shell/extensions/nightthemeswitcher/time" = {
      manual-schedule = true;
      nightthemeswitcher-ondemand-keybinding = [ "<Shift><Super>t" ];
      sunrise = 8.0;
      sunset = 18.0;
    };

    "org/gnome/desktop/a11y/mouse" = {
      dwell-click-enabled = false;
      dwell-threshold = 10;
      dwell-time = 1.2;
      secondary-click-enabled = true;
      secondary-click-time = 1.2;
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [
        (mkTuple [ "xkb" "eu" ])
        (mkTuple [ "xkb" "th" ])
      ];
      xkb-options = [ "lv3:ralt_switch" ];
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      disable-microphone = false;
      old-files-age = mkUint32 14;
      recent-files-max-age = -1;
      remove-old-temp-files = true;
      remove-old-trash-files = true;
    };

    "org/gnome/system/location" = {
      enabled = true;
    };
  };
}
