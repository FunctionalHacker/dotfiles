{ pkgs, ... }:

{
  users.users.functionalhacker = {
    description = "Marko";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHLUrf0LpumX6XEkPW6Z105sgJMWWOllWy7sxB+lgdUw Marko YubiKey"
    ];
  };
}
