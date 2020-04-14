# git shorthands
alias gc='git commit'
alias gac='ga && gc'
alias gpull='git pull'
alias gpush='git push'

# Syntax highlighting cat
alias cat='nvimpager -c'

rip() {
	abcde
	printf "Ripping done. Importing to library"
	beet import ~/Documents/Rip/flac/*
}

# make fzf zsh plugin use ripgrep
_fzf_compgen_dir() {
	rg --hidden --files --null --sort path "$1" 2>/dev/null | xargs -0 dirname | uniq
}
_fzf_compgen_path() {
	rg --files --hidden "$1" 2>/dev/null
}

# search and install packages with fzf
yi() { 
	SELECTED_PKGS="$(yay -Slq | fzf --header='Install packages' -m --preview 'yay -Si {1}')"
	if [ -n "$SELECTED_PKGS" ]; then
		yay -S $(echo $SELECTED_PKGS)
	fi
}

# search and remove packages with fzf
yr() { 
	SELECTED_PKGS="$(yay -Qsq | fzf --header='Remove packages' -m --preview 'yay -Si {1}')"
	if [ -n "$SELECTED_PKGS" ]; then
		yay -Rns $(echo $SELECTED_PKGS)
	fi
}

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

# shorten systemctl
alias sc='sudo systemctl'
alias scu='systemctl --user'

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
	yay -Sc
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
dotdrop() { source $DOTREPO/secrets/secrets && $DOTREPO/dotdrop/dotdrop.sh --cfg=$DOTREPO/config-home.yaml $@ }
sdotdrop() { source $DOTREPO/secrets/secrets && sudo -E $DOTREPO/dotdrop/dotdrop.sh --cfg=$DOTREPO/config-root.yaml $@ }
compdef _dotdrop-completion.zsh sdotdrop
alias dotgit='git -C $DOTREPO'
dotsync() { cd $DOTREPO && gpull && ga && gc && gpush && cd $OLDPWD }


# sync password manager
passync() { pass git pull && pass git push && updatesecrets }

# update stuff
plugupdate() {
	vim +PlugUpgrade +PlugUpdate +CocUpdate +qa
	zinit self-update
	zinit update -p
	$HOME/.tmux/plugins/tpm/bin/update_plugins all
}

update() { yay -Pw && yay }

{%@@ if profile == "Moria" @@%}
update-docker() {
	for dir in $HOME/Git/dotfiles/docker/*; do
		cd $dir
		docker-compose pull
		docker-compose up -d
		cd ..
	done
}

update-all() {
	update
	plugupdate
	update-docker
}
{%@@ else @@%}
updateall() {
	yay -Pw
	yay -Syu --devel firefox-nightly
	plugupdate
	sudo awman-update
}
{%@@ endif @@%}

# remove unneeded packages
autoremove() { sudo pacman -Rns $(pacman -Qdtq) }

# turn on usb tethering on my android phone
tether() { adb shell su -c "service call connectivity 33 i32 1 s16 me" > /dev/null }

# update arch mirrorlist
alias reflect='sudo reflector --latest 200 --threads 8 --verbose --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# better ls
alias ls='exa --time-style=long-iso --git'

# default icon for notify-send
alias notify-send='notify-send --icon=alarm'

# download archiso
alias archiso='curl "http://mirror.rackspace.com/archlinux/iso/$(date +%Y.%m).01/archlinux-$(date +%Y.%m).01-x86_64.iso"'


# encrypted tar's with zstd compression
cgpgtar() { tar cf - --zstd $1 | gpg -e -z 0 > $1.tar.zst.gpg }
xgpgtar() { gpg -d $1 | tar x --zstd }

# colorise output
cvs() { grc cvs $@ }
df() { grc df $@ }
digg() { grc digg $@ }
gcc() { grc gcc $@ }
g++() { grc g++ $@ }
ifconfig() { grc ifconfig $@ }
make() { grc make $@ }
mount() { grc mount $@ }
mtr() { grc mtr $@ }
netstat() { grc mount $@ }
ping() { grc ping $@ }
ps() { grc ps $@ }
tail() { grc tail $@ }
traceroute() { grc traceroute $@ }
wdiff() { grc wdiff $@ }
blkid() { grc blkid $@ }
du() { grc du $@ }
dnf() { grc dnf $@ }
docker() { grc docker $@ }
docker-machine() { grc docker-machine $@ }
env() { grc env $@ }
id() { grc id $@ }
ip() { grc ip $@ }
iostat() { grc iostat $@ }
last() { grc last $@ }
lsattr() { grc lsattr $@ }
lsblk() { grc lsblk $@ }
lspci() { grc lspci $@ }
lsmod() { grc lsmod $@ }
lsof() { grc lsof $@ }
getfacl() { grc getfacl $@ }
getsebool() { grc getsebool $@ }
ulimit() { grc ulimit $@ }
uptime() { grc uptime $@ }
nmap() { grc nmap $@ }
fdisk() { grc fdisk $@ }
findmnt() { grc findmnt $@ }
free() { grc free $@ }
semanage() { grc semanage $@ }
sar() { grc sar $@ }
ss() { grc ss $@ }
sysctl() { grc sysctl $@ }
systemctl() { grc systemctl $@ }
stat() { grc stat $@ }
showmount() { grc showmount $@ }
tune2fs() { grc tune2fs $@ }
tcpdum() { grc tcpdum $@ }
