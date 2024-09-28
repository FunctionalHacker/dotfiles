{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../wifi.nix
  ];

  networking.hostName = "Shire";

  # TODO
}
