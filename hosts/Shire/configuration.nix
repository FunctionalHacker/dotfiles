{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../wifi.nix
  ];

  networking.hostName = "Shire";

  boot = {
    kernelParams = [
      "intel_idle.max_cstate=1"
    ];
    plymouth.enable = lib.mkForce false;
    initrd = {
      unl0kr.enable = true;
      availableKernelModules = [
        "hid-multitouch"
        "i2c-hid"
        "i2c-hid-acpi"
        "hid_generic"
        "evdev"
      ];
    };
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];
}