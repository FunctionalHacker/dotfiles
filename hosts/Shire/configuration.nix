{ ... }:

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
    initrd = {
      # Couldn't get unl0kr working yet
      # unl0kr.enable = true;
      # availableKernelModules = [ "hid-multitouch" "i2c-hid" "i2c-hid-acpi" "hid_generic" ];
    };
  };
}
