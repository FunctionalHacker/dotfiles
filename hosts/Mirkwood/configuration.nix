{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking = {
     hostName = "Mirkwood";
     networkmanager = {
        enable = true;
        wifi.backend = "iwd";
     };
     wireless.iwd.enable = true;
  };

  boot = {
     initrd.luks.devices."luks-cf2ca44e-d8d1-4ec8-a072-921f29ed693d".device = "/dev/disk/by-uuid/cf2ca44e-d8d1-4ec8-a072-921f29ed693d";
     loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
     };
  };

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  i18n = {
     defaultLocale = "en_US.UTF-8";

     extraLocaleSettings = {
       LC_ADDRESS = "fi_FI.UTF-8";
       LC_IDENTIFICATION = "fi_FI.UTF-8";
       LC_MEASUREMENT = "fi_FI.UTF-8";
       LC_MONETARY = "fi_FI.UTF-8";
       LC_NAME = "fi_FI.UTF-8";
       LC_NUMERIC = "fi_FI.UTF-8";
       LC_PAPER = "fi_FI.UTF-8";
       LC_TELEPHONE = "fi_FI.UTF-8";
       LC_TIME = "fi_FI.UTF-8";
     };
  };

  services = {
     xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;

        xkb = {
          layout = "us";
          variant = "";
        };
     };

     pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
     };
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.functionalhacker = {
    isNormalUser = true;
    description = "Marko Korhonen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  programs.firefox = {
     enable = true;
     nativeMessagingHosts.packages = [ pkgs.browserpass ];
  };

  environment.systemPackages = with pkgs; [
     neovim
     telegram-desktop
     zsh
     neofetch
     usbutils
     wl-clipboard
     git
     pass
     gnumake
  ];
}
