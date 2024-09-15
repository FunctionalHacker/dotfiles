{ config, pkgs, ... }:

{
   imports = [
      ./users.nix
      ./gpg.nix
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
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
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

   hardware.pulseaudio.enable = false;

   security.rtkit.enable = true;

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
