{ ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      moria = {
        hostname = "korhonen.cc";
        user = "balrog";
        port = 221;
      };

      forgejo = {
        hostname = "git.korhonen.cc";
        user = "git";
        port = 2882;
      };
    };
  };
}
