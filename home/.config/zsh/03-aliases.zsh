# git shorthands
alias gc='git commit'
alias gac='ga && gc'
alias gpull='git pull'
alias gpush='git push'

alias mutt='neomutt'

# make skim zsh plugin use fd
_skim_compgen_dir() {
	fd -Ht d
}
_skim_compgen_path() {
	fd -Ht f
}
# same for fzf
_fzf_compgen_dir() {
	_skim_compgen_dir
}
_fzf_compgen_path() {
	_skim_compgen_path
}

# Modern replacements for cat and ls
alias cat='bat --paging=never'
alias ls='exa'

{%@@ if profile != "mko-laptop" @@%}
# Command not found handler
# source https://wiki.archlinux.org/title/Zsh#pacman_-F_%22command_not_found%22_handler
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=(
        ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}
    )
    if (( ${#entries[@]} ))
    then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}"
        do
            # (repo package version file)
            local fields=(
                ${(0)entry}
            )
            if [[ "$pkg" != "${fields[2]}" ]]
            then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
}
{%@@ endif @@%}

# search and install packages with skim
pi() { 
	SELECTED_PKGS="$(paru -Slq | sk --header='Install packages' -m --preview 'paru -Si {1}')"
	if [ -n "$SELECTED_PKGS" ]; then
		# Append the expanded command to history
		print -s "paru -S $(echo $SELECTED_PKGS)"
		paru -S $(echo $SELECTED_PKGS)
	fi
}

# search and remove packages with skim
pr() { 
	SELECTED_PKGS="$(paru -Qsq | sk --header='Remove packages' -m --preview 'paru -Si {1}')"
	if [ -n "$SELECTED_PKGS" ]; then
		# Append the expanded command to history
		print -s "paru -Rns $(echo $SELECTED_PKGS)"
		paru -Rns $(echo $SELECTED_PKGS)
	fi
}

# find and open man pages with skim
fman() {
	man -k . | sk --prompt='Man> ' | awk '{print $1}' | xargs -r man
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

# connect to metropolia vpn
alias metropoliavpn='sudo openconnect -u markoak --passwd-on-stdin vpn.metropolia.fi'

# read qrcode from selection
qr() { grim -g "$(slurp -d)" - | zbarimg PNG:- }

# generate qr code in terminal
alias qrencode='qrencode -t ansiutf8'

# color picker
cpick() { grim -g "$(slurp -p)" -t ppm - | convert - -format "%[pixel:p{0,0}]" txt:- }

#iwctl aliases
alias i='iwctl station wlan0'

# change cpu power settings
gpulow() { 
	echo low | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
}
gpuauto() {
	echo auto | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
}

# monitor cpu freq
cpufreq() { watch -n 1 eval "cat /proc/cpuinfo | grep MHz" }

# dotdrop
updatesecrets() { bash $DOTREPO/secrets/secrets.sh; chmod 600 $DOTREPO/secrets/secrets }
dotdrop() { source $DOTREPO/secrets/secrets && $DOTREPO/dotdrop.sh $@ }
sdotdrop() { source $DOTREPO/secrets/secrets && sudo -E $DOTREPO/dotdrop.sh --cfg=$DOTREPO/config-root.yaml $@ }
compdef _dotdrop-completion.zsh sdotdrop
alias dotgit='git -C $DOTREPO'
dotsync() { cd $DOTREPO && gpull && ga && gc && gpush && cd $OLDPWD }


# sync password manager
passync() { pass git pull && pass git push && updatesecrets }

update() {
	all() {
		paru
		plugins
		{%@@ if profile == "Moria" @@%}
		repo
		docker-update
		docker system prune --volumes
		{%@@ endif @@%}
		sudo flatpak update
		sudo awman-update
	}

	repo() {
		aur sync -Su --margs --noconfirm
		firefox
	}

	firefox() {
		aur sync -S --rebuild firefox-nightly --margs --noconfirm 
	}

	plugins() {
		nvim +PackerSync +TSUpdate
		zinit self-update
		zinit update -p
		$HOME/.tmux/plugins/tpm/bin/update_plugins all
	}

	docker-update() {
		for dir in $HOME/git/dotfiles/docker/*; do
			cd $dir
			docker-compose pull
			docker-compose up -d
			cd ..
		done
	}

	if [ $# -eq 0 ]; then
		1=base
	fi

	case "$1" in
		all)
			all
			;;
		plugins)
			plugins
			;;
		docker)
			docker-update
			;;
		repo)
			repo
			;;
		firefox)
			firefox
			;;
		*)
			paru
			;;
	esac
}

# remove unneeded packages
autoremove() { sudo pacman -Rns $(pacman -Qdtq) }

# turn on usb tethering on my android phone
tether() { adb shell su -c "service call connectivity 33 i32 1 s16 me" > /dev/null }

# update arch mirrorlist
alias reflect='sudo reflector --latest 200 --threads 8 --verbose --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# default icon for notify-send
alias notify-send='notify-send --icon=alarm'

# download archiso
alias archiso='curl "http://mirror.rackspace.com/archlinux/iso/$(date +%Y.%m).01/archlinux-$(date +%Y.%m).01-x86_64.iso"'

# Update repository


# encrypted tar's with zstd compression
cgpgtar() { tar cf - --zstd $1 | gpg -e -z 0 > $1.tar.zst.gpg }
xgpgtar() { gpg -d $1 | tar x --zstd }

# colorise output
alias cvs='grc cvs'
alias df='grc df'
alias digg='grc digg'
alias gcc='grc gcc'
alias g++='grc g++'
alias ifconfig='grc ifconfig'
alias make='grc make'
alias mount='grc mount'
alias mtr='grc mtr'
alias netstat='grc mount'
alias ping='grc ping'
alias ps='grc ps'
alias tail='grc tail'
alias traceroute='grc traceroute'
alias wdiff='grc wdiff'
alias blkid='grc blkid'
alias du='grc du'
alias dnf='grc dnf'
alias docker='grc docker'
alias docker-machine='grc docker-machine'
alias env='grc env'
alias id='grc id'
alias ip='grc ip'
alias iostat='grc iostat'
alias last='grc last'
alias lsattr='grc lsattr'
alias lsblk='grc lsblk'
alias lspci='grc lspci'
alias lsmod='grc lsmod'
alias lsof='grc lsof'
alias getfacl='grc getfacl'
alias getsebool='grc getsebool'
alias ulimit='grc ulimit'
alias uptime='grc uptime'
alias nmap='grc nmap'
alias fdisk='grc fdisk'
alias findmnt='grc findmnt'
alias free='grc free'
alias semanage='grc semanage'
alias sar='grc sar'
alias ss='grc ss'
alias sysctl='grc sysctl'
alias systemctl='grc systemctl'
alias stat='grc stat'
alias showmount='grc showmount'
alias tune2fs='grc tune2fs'
alias tcpdum='grc tcpdum'

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
