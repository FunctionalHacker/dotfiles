{ pkgs, ... }:

{
  users.users.functionalhacker = {
    description = "Marko";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}
