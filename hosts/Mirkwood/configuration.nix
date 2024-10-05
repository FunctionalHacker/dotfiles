{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../wifi.nix
  ];

  networking.hostName = "Mirkwood";
  boot.initrd.kernelModules = [ "amdgpu" ];
}
