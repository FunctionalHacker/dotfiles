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

  boot.initrd.luks.devices."luks-cf2ca44e-d8d1-4ec8-a072-921f29ed693d".device = "/dev/disk/by-uuid/cf2ca44e-d8d1-4ec8-a072-921f29ed693d";
}
