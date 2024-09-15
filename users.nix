{ config, pkgs, ... }:

{
  users.users = {
     functionalhacker = {
       isNormalUser = true;
       description = "Marko";
       extraGroups = [ "networkmanager" "wheel" ];
     };

     som = {
       isNormalUser = true;
       description = "Som";
       extraGroups = [ "networkmanager" ];
     };
  };
}
