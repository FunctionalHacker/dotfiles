{ ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {

      # Server
      moria = {
        hostname = "korhonen.cc";
        user = "balrog";
        port = 221;

        remoteForwards = [
          {
            bind.address = "/run/user/1000/gnupg/S.gpg-agent.ssh";
            host.address = "/run/user/1000/gnupg/S.gpg-agent.ssh";
          }
          {
            bind.address = "/run/user/1000/gnupg/S.gpg-agent";
            host.address = "/run/user/1000/gnupg/S.gpg-agent.extra";
          }
        ];

        extraOptions = {
          StreamLocalBindUnlink = "yes";
        };
      };

      # Server LUKS unlock
      moria-unlock = {
        hostname = "korhonen.cc";
        user = "root";
        port = 221;
      };

      # Main OpenWRT router
      beleriand = {
        hostname = "beleriand.korhonen.lan";
        user = "root";
      };

      # CoreELEC box
      rivendell = {
        hostname = "rivendell.korhonen.lan";
        user = "root";
      };

      # OpenWRT AP/travel router
      esgaroth = {
        hostname = "esgaroth.korhonen.lan";
        user = "root";
      };

      # Self hosted forgejo
      forgejo = {
        hostname = "git.korhonen.cc";
        user = "git";
        port = 2882;
      };

      github = {
        hostname = "github.com";
        user = "git";
      };

      gitlab = {
        hostname = "gitlab.com";
        user = "git";
      };

      aur = {
        hostname = "aur.archlinux.org";
        user = "aur";
      };
    };
  };
}
