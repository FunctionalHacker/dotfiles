{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd -Hlt f";
    defaultOptions = [ "-m --ansi --bind ctrl-a:toggle-all,ctrl-d:deselect-all,ctrl-t:toggle-all" ];
    fileWidgetCommand = "fd -Hlt f --strip-cwd-prefix";
    fileWidgetOptions = [ "--preview 'bat --color=always --style=numbers --line-range=:500 {}" ];
    changeDirWidgetCommand = "fd -Hlt d";
    changeDirWidgetOptions = [ "--preview 'eza -l {}'" ];
  };

}
