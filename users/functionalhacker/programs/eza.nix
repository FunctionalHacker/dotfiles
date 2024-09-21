{ ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    extraOptions = [ "--git" "--icons" ];
  };

}
