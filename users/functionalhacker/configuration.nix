{ config, pkgs, ... }:

{
  users.users.functionalhacker = {
     description = "Marko";
     isNormalUser = true;
     extraGroups = [ "networkmanager" "wheel" ];
  };
}
