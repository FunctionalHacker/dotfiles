{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../wifi.nix
  ];

  networking.hostName = "Shire";

  boot = {
    kernelParams = config.boot.kernelParams ++ [
      "intel_idle.max_cstate=1"
    ];
    initrd.unl0kr.enable = true;

    # Does not work with unl0kr now
    # https://github.com/NixOS/nixpkgs/issues/291935
    plymouth.enable = false;
  };
}
