{ pkgs, ... }:

{
  programs = {
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    pcscd.enable = true;
    udev.packages = [
      pkgs.yubikey-personalization
    ];
  };
}
