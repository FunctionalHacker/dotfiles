{ config, lib, pkgs, ... }:

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

   environment.shellInit = ''
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      export MARKON_MUUTTUJA="test"
   '';
}
