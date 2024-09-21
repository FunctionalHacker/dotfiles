{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Marko Korhonen";
    userEmail = "marko@korhonen.cc";

    extraConfig = {
      user.signingkey = "F2B9F713E7ED627336DD85E444FA3F28CD931BB0";
      commit = {
        gpgsign = true;
        signoff = true;
      };
      tag = {
        gpgsign = true;
        signoff = true;
      };
      merge = {
        prompt = false;
        conflictstyle = "diff3";
        tool = "nvim";
      };
    };
  };
}
