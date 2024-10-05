{ config, lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
    "sdhci_acpi"
    "hid-multitouch"
    "i2c-hid"
    "i2c-hid-acpi"
    "hid_generic"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/973c6741-8cca-4a19-a837-93d192e8c868";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-8b12931e-b40d-4ad7-8cc1-ca25fcceb05b".device = "/dev/disk/by-uuid/8b12931e-b40d-4ad7-8cc1-ca25fcceb05b";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/B63A-4E10";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
