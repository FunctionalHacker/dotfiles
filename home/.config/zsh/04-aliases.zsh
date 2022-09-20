# git shorthands
alias gc='git commit'
alias gac='ga && gc'
alias gs='git status'
alias gpull='git pull'
alias gpush='git push'

# Rename grc alias from forgit since it
# collides with the grc colorizer
forgit_revert_commit=fgrc

# Modern replacement for ls
alias ls='exa'

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
    cmd="paru -S $(echo $SELECTED_PKGS)"
    {%@@ elif distro_id == "ubuntu" @@%}
    cmd="sudo apt install $(echo $SELECTED_PKGS)"
    {%@@ elif distro_id == "termux" @@%}
    cmd="apt install $(echo $SELECTED_PKGS)"
    {%@@ endif @@%}

		# Append the expanded command to history
		print -s "$cmd"

    # Finally, excecute the command
    eval "$cmd"
	fi
}

pr() {
  {%@@ if distro_id == "arch" @@%}
	SELECTED_PKGS="$(paru -Qsq | fzf --header='Remove packages' -m --preview 'paru -Si {1}' | tr '\n' ' ')"
  {%@@ else @@%}
	SELECTED_PKGS="$(apt list --installed 2>/dev/null | cut -d '/' -f 1 | tail +2 | fzf --header='Remove packages' -m --preview 'apt show 2>/dev/null {1}' | tr '\n' ' ')"
  {%@@ endif @@%}
	if [ -n "$SELECTED_PKGS" ]; then
    {%@@ if distro_id == "arch" @@%}
    cmd="paru -Rns $(echo $SELECTED_PKGS)"
    {%@@ elif distro_id == "ubuntu" @@%}
    cmd="sudo apt remove $(echo $SELECTED_PKGS)"
    {%@@ elif distro_id == "termux" @@%}
    cmd="apt remove $(echo $SELECTED_PKGS)"
    {%@@ endif @@%}

		# Append the expanded command to history
		print -s "$cmd"

    # Finally, excecute the command
    eval "$cmd"
	fi
}

{%@@ if distro_id == "termux" @@%}
alias gp='okc-gpg'
{%@@ endif @@%}

# find and open man pages with fzf
fman() {
	man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
}

# I'm retarded so I need this
alias :q='exit'
alias :wq='exit'

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

# move to trash instead of remove
alias rm='trash'

# clean stuff
clean() {
	DFCMD="df -h / | tail -n 1 | cut -d' ' -f8- | cut -d' ' -f1 | sed 's/[^0-9]*//g'"
	SPACEBEFORE=$(eval "$DFCMD")
	trash-empty 10
	sudo journalctl --vacuum-size=500M
	paru -Sc
	SPACEAFTER=$(eval "$DFCMD")
	echo "Saved $(calc $SPACEAFTER - $SPACEBEFORE)G of space"
}

# connect to wireguard
alias startvpn='sudo systemctl start wg-quick@wg0.service'
alias stopvpn='sudo systemctl stop wg-quick@wg0.service'

# read qrcode from selection
qr() { grim -g "$(slurp -d)" - | zbarimg PNG:- }

# generate qr code in terminal
alias qrencode='qrencode -t ansiutf8'

# color picker
cpick() { grim -g "$(slurp -p)" -t ppm - | convert - -format "%[pixel:p{0,0}]" txt:- }

#iwctl aliases
alias i='iwctl station wlan0'

# monitor cpu freq
cpufreq() { watch -n 1 eval "cat /proc/cpuinfo | grep MHz" }

# dotdrop
dotdrop() { source $DOTREPO/secrets/secrets && $DOTREPO/dotdrop/dotdrop.sh --cfg=$DOTREPO/config.toml {%@@ if profile == "Isengard" @@%} -p Isengard{%@@ endif @@%} $@ }
sdotdrop() { source $DOTREPO/secrets/secrets && sudo -E $DOTREPO/dotdrop/dotdrop.sh --cfg=$DOTREPO/config-root.toml $@ }
updatesecrets() { bash $DOTREPO/secrets/secrets.sh; chmod 600 $DOTREPO/secrets/secrets }
compdef _dotdrop-completion.zsh sdotdrop
alias dotgit='git -C $DOTREPO'
dotsync() { cd $DOTREPO && gac && gpull && gpush && cd $OLDPWD }

# sync password manager
passync() { pass git pull && pass git push && updatesecrets }

update() {
	all() {
		packages
		{%@@ if profile == "Moria" @@%}
		repo
		docker-update
		{%@@ endif @@%}
		plugins
	}

	packages() {
		{%@@ if distro_id == "arch" @@%}
		paru
		{%@@ elif distro_id == "ubuntu" @@%}
		sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
		{%@@ elif distro_id == "termux" @@%}
		pkg update
		{%@@ endif @@%}
	}

	plugins() {
		echo "Updating NeoVim plugins"
		nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
		echo "Updating NeoVim TreeSitter"
		nvim --headless +TSUpdateSync +qa
		zinit self-update
		zinit update -p
		$HOME/.tmux/plugins/tpm/bin/update_plugins all
	}

	{%@@ if profile == "Moria" @@%}
	repo() {
		aur sync -Su --margs --noconfirm
	}

	docker-update() {
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
	}

	{%@@ endif @@%}
	case "$1" in
		all)
			all
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
			packages
			;;
	esac
}

# turn on usb tethering on my android phone
tether() { adb shell su -c "service call connectivity 33 i32 1 s16 me" > /dev/null }

# update arch mirrorlist
alias reflect='sudo reflector --latest 200 --threads 8 --verbose --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

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
