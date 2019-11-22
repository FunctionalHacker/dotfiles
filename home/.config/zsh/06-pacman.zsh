# from https://wiki.archlinux.org/index.php/Zsh#On-demand_rehash
catch_signal_usr1() {
  trap catch_signal_usr1 USR1
  rehash
}
trap catch_signal_usr1 USR1
