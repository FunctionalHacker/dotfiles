{ pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
    };
  };
  home.packages = with pkgs.gnomeExtensions; [
    gsconnect
    night-theme-switcher
  ];
}
