{ pkgs, ... }:

{
  imports = [
    ./gpg.nix
    ./users/functionalhacker/configuration.nix
    ./users/som/configuration.nix
  ];

  system.stateVersion = "24.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        timeoutStyle = "hidden";
      };
    };

    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    consoleLogLevel = 0;

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    plymouth = {
      enable = true;
      theme = "bgrt";
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
      pulse.enable = true;
    };
  };

  networking.networkmanager.enable = true;

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  programs = {
    firefox = {
      enable = true;
      nativeMessagingHosts.packages = [ pkgs.browserpass ];
    };
    zsh.enable = true;
  };

  environment = {
    shells = [ pkgs.zsh ];
    systemPackages = with pkgs;
      [
        telegram-desktop
      ];
  };
}
