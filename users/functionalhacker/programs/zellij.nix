{ ... }:

{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "kanagawa";
      session_serialization = false;
      keybinds = {
        unbind = "Ctrl g";
        shared_except = {
          _args = [ "locked" ];
          "bind \"Ctrl l\"" = {
            SwitchToMode = "Locked";
          };
        };
        locked = {
          "bind \"Ctrl l\"" = {
            SwitchToMode = "Normal";
          };
        };
      };
    };
  };
}
