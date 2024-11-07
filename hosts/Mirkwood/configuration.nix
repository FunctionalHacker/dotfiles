{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../wifi.nix
  ];

  networking.hostName = "Mirkwood";
  boot.initrd.kernelModules = [ "amdgpu" ];

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];
}
