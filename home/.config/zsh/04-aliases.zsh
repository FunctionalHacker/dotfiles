# Fix sudo and doas not expanding aliases
# see: https://unix.stackexchange.com/questions/148545/why-does-sudo-ignore-aliases
alias sudo='sudo '
alias doas='doas '

# git shorthands
alias gc='git commit'
alias gac='ga && gc'
alias gs='git status'
alias gpull='git pull'
alias gpush='git push'

alias o='xdg-open'

# Open nvim with diffview
# Handy plugin for viewing git diffs
# and handling merges
alias dv='nvim +DiffviewOpen'

# Rename grc alias from forgit since it
# collides with the grc colorizer
forgit_revert_commit=fgrc

# Modern replacement for ls
alias ls='eza --icons --git'

# Enable command not found handler
{%@@ if distro_id == "arch" @@%}
source /usr/share/doc/pkgfile/command-not-found.zsh
{%@@ elif distro_id == "ubuntu" @@%}
source /etc/zsh_command_not_found
{%@@ elif distro_id == "termux" @@%}
function command_not_found_handler {
	$PREFIX/libexec/termux/command-not-found $1
}
{%@@ endif @@%}

# search and install/remove packages with fzf
pi() {
  {%@@ if distro_id == "arch" @@%}
	SELECTED_PKGS="$(paru -Slq | fzf --header='Install packages' -m --preview 'paru -Si {1}' | tr '\n' ' ')"
  {%@@ else @@%}
	SELECTED_PKGS="$(apt list 2>/dev/null | cut -d '/' -f 1 | tail +2 | fzf --header='Install packages' -m --preview 'apt show 2>/dev/null {1}' | tr '\n' ' ')"
  {%@@ endif @@%}
	if [ -n "$SELECTED_PKGS" ]; then
    {%@@ if distro_id == "arch" @@%}
    cmd="paru -S $SELECTED_PKGS"
    {%@@ elif distro_id == "ubuntu" or distro_id == "debian" @@%}
    cmd="doas apt install $SELECTED_PKGS"
    {%@@ elif distro_id == "termux" @@%}
    cmd="apt install $SELECTED_PKGS"
    {%@@ endif @@%}

		# Append the expanded command to history
		print -s "$cmd"

    # Finally, excecute the command
    eval "$cmd"
	fi
}

mkcd() {
  mkdir -p $1
  cd $1
}

pr() {
  {%@@ if distro_id == "arch" @@%}
	SELECTED_PKGS="$(paru -Qsq | fzf --header='Remove packages' -m --preview 'paru -Qi {1}' | tr '\n' ' ')"
  {%@@ else @@%}
	SELECTED_PKGS="$(apt list --installed 2>/dev/null | cut -d '/' -f 1 | tail +2 | fzf --header='Remove packages' -m --preview 'apt show 2>/dev/null {1}' | tr '\n' ' ')"
  {%@@ endif @@%}
	if [ -n "$SELECTED_PKGS" ]; then
    {%@@ if distro_id == "arch" @@%}
    cmd="paru -Rns $SELECTED_PKGS"
    {%@@ elif distro_id == "ubuntu" or distro_id == "debian" @@%}
    cmd="doas apt remove $SELECTED_PKGS"
    {%@@ elif distro_id == "termux" @@%}
    cmd="apt remove $SELECTED_PKGS"
    {%@@ endif @@%}

		# Append the expanded command to history
		print -s "$cmd"

    # Finally, excecute the command
    eval "$cmd"
	fi
}

{%@@ if profile == "Moria" @@%}
# Add packages to repo with fzf
ra() {
	SELECTED_PKGS="$(paru -Slqa | fzf --header='Add packages to repo' -m --preview 'paru -Si {1}' | tr '\n' ' ')"
	if [ -n "$SELECTED_PKGS" ]; then
    cmd="aur sync -S $SELECTED_PKGS"

		# Append the expanded command to history
		print -s "$cmd"

    # Finally, excecute the command
    eval "$cmd"
	fi
}
{%@@ endif @@%}

{%@@ if distro_id == "termux" @@%}
alias gp='okc-gpg'
{%@@ endif @@%}

# find and open man pages with fzf
fman() {
	man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
}

alias :q='cowsay "You are not in vim anymore"'

alias reboot-kodi='systemctl reboot --boot-loader-entry=kodi.conf'

# zbar output only data
alias zbarimg='zbarimg -q --raw'
alias zbarcam='zbarcam -q --raw'

# shorten systemctl and journalctl
alias sc='systemctl'
alias scu='systemctl --user'
alias jc='journalctl'
alias jcu='journalctl --user'

# switch to desktop mode
alias dock='swaymsg output eDP-1 disable'

{%@@ if distro_id != "termux" @@%}
# move to trash instead of remove
alias rm='trash'
{%@@ endif @@%}

# clean stuff
clean() {
	DFCMD="df -h / | tail -n 1 | cut -d' ' -f8- | cut -d' ' -f1 | sed 's/[^0-9]*//g'"
	SPACEBEFORE=$(eval "$DFCMD")
	trash-empty 10
  doas journalctl --vacuum-size=500M
	paru -Sc
	SPACEAFTER=$(eval "$DFCMD")
	echo "Saved $(calc $SPACEAFTER - $SPACEBEFORE)G of space"
}

# connect to wireguard
alias startvpn='doas systemctl start wg-quick@wg0.service'
alias stopvpn='doas systemctl stop wg-quick@wg0.service'

# read qrcode from selection
qr() {
  gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Eval 'Main.screenshotUI.open();' 2>&1 > /dev/null && wl-paste | zbarimg -q --raw PNG:-
}

# generate qr code in terminal
alias qrencode='qrencode -t ansiutf8'

# color picker
cpick() { grim -g "$(slurp -p)" -t ppm - | convert - -format "%[pixel:p{0,0}]" txt:- }

#iwctl aliases
alias i='iwctl station wlan0'

# monitor cpu freq
cpufreq() { watch -n 1 eval "cat /proc/cpuinfo | grep MHz" }

# dotdrop
alias dotdrop="source $DOTREPO/secrets/secrets && {%@@ if distro_id != "termux" @@%} UID=$(id -u) {%@@ endif @@%} dotdrop --cfg=$DOTREPO/config.toml {%@@ if profile == "Isengard" @@%} -p Isengard{%@@ endif @@%}"


alias sdotdrop="source $DOTREPO/secrets/secrets && sudo -E dotdrop --cfg=$DOTREPO/config-root.toml"
compdef _dotdrop-completion.zsh sdotdrop

updatesecrets() {
  bash $DOTREPO/secrets/secrets.sh
  chmod 600 $DOTREPO/secrets/secrets
}

alias dotgit='git -C $DOTREPO'
dotsync() { cd $DOTREPO && gac && gpull && gpush && cd $OLDPWD }

# sync password manager
passync() { pass git pull && pass git push && updatesecrets }

update() {
	all() {
    dotfiles
		packages
		{%@@ if profile == "Moria" @@%}
		repo
		docker-update
		{%@@ endif @@%}
		plugins
	}

	packages() {
		{%@@ if distro_id == "arch" @@%}
		paru -Syu --noconfirm
		{%@@ elif distro_id == "ubuntu" or distro_id == "debian" @@%}
		doas apt update && doas apt full-upgrade -y && doas apt autoremove -y && doas apt autoclean -y
		{%@@ elif distro_id == "termux" @@%}
		pkg update && pkg upgrade --yes
		{%@@ endif @@%}
		{%@@ if distro_id == "termux" @@%}
    pip-update-installed
    cargo-update-installed
		{%@@ endif @@%}
	}

	plugins() {
		echo "Updating NeoVim plugins to match lockfiles"
		nvim --headless -c "Lazy! restore" -c 'TSUpdateSync' -c 'MasonLockRestore' -c 'qa'
    echo "Updating zsh plugins"
		zinit self-update
		zinit update -p
	}

  pip-update-installed() {
    pip install --upgrade $(pip list --outdated | tail -n +3 | awk '{print $1}')
  }

  cargo-update-installed() {
    cargo install-update -a
  }

	{%@@ if profile == "Moria" @@%}
	repo() {
		aur sync -Su --margs --noconfirm
	}

	local docker-update() {
		prevpwddocker=$PWD
		for dir in $HOME/git/dotfiles/docker/*; do
			cd $dir
			if [[ -f "$dir/DISABLED" ]]; then
				echo "$(basename $dir) stack is disabled, skipping..."
			else
				dct -f $dir/docker-compose.toml pull
				dct -f $dir/docker-compose.toml up -d
			fi
			cd ..
		done
		cd $prevpwddocker
		docker system prune -af --volumes

    occ upgrade
    occ app:update --all
    occ db:add-missing-indices
	}
	{%@@ endif @@%}

  dotfiles() {
    dotgit pull
    dotdrop install
  }

  if [ $# -eq 0 ]; then
    packages  # Update only packages if no option was provided
  else
    case "$1" in
      all)
        all
        ;;
      dotfiles)
        dotfiles
        ;;
      plugins)
        plugins
        ;;
        {%@@ if profile == "Moria" @@%}
        docker)
        docker-update
        ;;
      repo)
        repo
        ;;
        {%@@ endif @@%}
        *)
        echo "Unknown option: $1"
        return 1
        ;;
    esac
  fi
}

_update() {
  local commands=(
    "all:Update everything"
    "dotfiles:Update dotfiles"
    "plugins:Update plugins for NeoVim and ZSH"
		{%@@ if profile == "Moria" @@%}
    "repo:Update packages in Korhonen AUR repository"
    "docker:Update all Docker containers"
		{%@@ endif @@%}
  )

  _arguments \
    '1: :->command' \
    '*:: :->args'

  case "$state" in
    (command)
      _describe -t commands 'available commands' commands
      ;;
  esac
}
compdef _update update

# turn on usb tethering on my android phone
tether() { adb shell su -c "service call connectivity 33 i32 1 s16 me" > /dev/null }

# update arch mirrorlist
alias reflect='doas reflector --latest 200 --threads 8 --verbose --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# default icon for notify-send
alias notify-send='notify-send --icon=alarm'

# download archiso
alias archiso='curl "http://mirror.rackspace.com/archlinux/iso/$(date +%Y.%m).01/archlinux-$(date +%Y.%m).01-x86_64.iso"'

# encrypted tar's with zstd compression
cgpgtar() { tar cf - --zstd $1 | gpg -e -z 0 > $1.tar.zst.gpg }
xgpgtar() { gpg -d $1 | tar x --zstd }

# Switch to different yubikey
alias switch-yubikey='gpg-connect-agent "scd serialno" "learn --force" /bye'

btw, () {
	echo "                 I use"
	echo "[38;2;23;147;209m                   ▄
                  ▟█▙
                 ▟███▙
                ▟█████▙
               ▟███████▙
              ▂▔▀▜██████▙
             ▟██▅▂▝▜█████▙
            ▟█████████████▙
           ▟███████████████▙
          ▟█████████████████▙
         ▟███████████████████▙
        ▟█████████▛▀▀▜████████▙
       ▟████████▛      ▜███████▙
      ▟█████████        ████████▙
     ▟██████████        █████▆▅▄▃▂
    ▟██████████▛        ▜█████████▙
   ▟██████▀▀▀              ▀▀██████▙
  ▟███▀▘                       ▝▀███▙
 ▟▛▀                               ▀▜▙"
}

# docker-compose with TOML
dct() {
	local file_path=('./docker-compose.toml')

	zmodload zsh/zutil
	zparseopts -D -K -- \
		f:=file_path ||
		return 1

	file_path=${file_path[-1]}

	if [[ ! -a "$file_path" ]]; then
		echo "File $file_path does not exist!"
		return 1
	fi

	yj -ty < $file_path | docker compose -f - $@
}

alias dslr-webcam='pkill -f gphoto2; gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0'

clock() {
  while true; do
    printf '%s\r' "$(date)"
    sleep 0.1
  done
}

# Change file extension made easy
chext() {
  file="$1"
  new_ext="$2"
  dest="${file%.*}.$new_ext"

  help() {
    printf "Change file extension\nUsage: chext file new_extension\nFor example: chext my_script.sh zsh"
  }

  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    help
    return
  fi

  if [ $# -lt 2 ]; then
    help
    return 1
  fi

  if [ ! -e "$1" ]; then
    echo "$file: no such file or directory"
    help
    return 1
  fi

  mv "$file" "$dest"
}
