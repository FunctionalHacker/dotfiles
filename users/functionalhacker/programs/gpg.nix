{ ... }:

{
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ../pubkey.asc;
        trust = 5;
      }
    ];
  };
}
