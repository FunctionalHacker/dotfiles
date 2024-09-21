{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "io/github/celluloid-player/celluloid" = {
      dark-theme-enable = false;
      mpv-config-enable = true;
      mpv-config-file = "file:///home/functionalhacker/.config/mpv/mpv.conf";
      mpv-input-config-enable = true;
      mpv-input-config-file = "file:///home/functionalhacker/.config/mpv/input.conf";
      settings-migrated = true;
    };

    "org/gnome/Connections" = {
      first-run = false;
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
      sources = [ (mkTuple [ "xkb" "eu" ]) (mkTuple [ "xkb" "fi" ]) ];
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

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>w" ];
      move-to-workspace-down = [ "<Shift><Super>j" ];
      move-to-workspace-left = [ "<Shift><Super>h" ];
      move-to-workspace-right = [ "<Shift><Super>l" ];
      move-to-workspace-up = [ "<Shift><Super>k" ];
      switch-to-workspace-down = [ "<Super>j" ];
      switch-to-workspace-left = [ "<Super>h" ];
      switch-to-workspace-right = [ "<Super>l" ];
      switch-to-workspace-up = [ "<Super>k" ];
      toggle-fullscreen = [ ];
      toggle-maximized = [ "<Super>f" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      screensaver = [ "<Super>BackSpace" ];
      volume-step = 1;
      www = [ "<Super>b" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kgx";
      name = "Open terminal";
    };

    "org/gnome/file-roller/dialogs/new" = {
      default-extension = ".tar.zst";
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

  };

}
