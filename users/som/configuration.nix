{ config, pkgs, ... }:

{
  users.users.som = {
     description = "Som";
     isNormalUser = true;
     extraGroups = [ "networkmanager" ];
  };
}
