{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../wifi.nix
  ];

  networking.hostName = "Mirkwood";

  boot.initrd.luks.devices."luks-cf2ca44e-d8d1-4ec8-a072-921f29ed693d".device = "/dev/disk/by-uuid/cf2ca44e-d8d1-4ec8-a072-921f29ed693d";
}
