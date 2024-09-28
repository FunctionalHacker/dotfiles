{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd -Ht f";
    defaultOptions = [
      "-m"
      "--ansi"
      "--bind ctrl-a:toggle-all,ctrl-d:deselect-all,ctrl-t:toggle-all"
    ];
    fileWidgetCommand = "fd -Ht f --strip-cwd-prefix";
    fileWidgetOptions = [ "--preview 'bat --color=always --style=numbers --line-range=:500 {}'" ];
    changeDirWidgetCommand = "fd -Ht d";
    changeDirWidgetOptions = [ "--preview 'eza -l {}'" ];
  };
}
