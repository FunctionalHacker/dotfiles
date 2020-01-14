# signoff every commit
git() {
	if [[ "$1" == "commit" && $# -eq 1 ]]; then
		/usr/bin/git commit -S -s
	else
		/usr/bin/git $@
	fi
}

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
battery() { 
	sudo cpupower frequency-set -g powersave
	echo low | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
}
plugged() {
	sudo cpupower frequency-set -g schedutil
	echo auto | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
}
ultimatepowersave() {
	battery
	powersave
	sudo ryzenadj --stapm-limit=25000 --fast-limit=25000 --slow-limit=25000 --tctl-temp=20;
}
performance() { 
	sudo cpupower frequency-set -g performance
	sudo ryzenadj --stapm-limit=45000 --fast-limit=45000 --slow-limit=45000 --tctl-temp=90
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
plugupdate() { vim +PlugUpgrade +PlugUpdate +CocUpdate +qa && zplugin update && $HOME/.tmux/plugins/tpm/bin/update_plugins all }
update() { yay -Syu --devel firefox-nightly }
updateall() { update; plugupdate; sudo awman-update }

# remove unneeded packages
autoremove() { sudo pacman -R $(pacman -Qdtq) }

# turn on usb tethering on my android phone
tether() { adb shell su -c "service call connectivity 33 i32 1 s16 me" > /dev/null }

# update arch mirrorlist
alias reflect='sudo reflector --latest 200 --threads 8 --verbose --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# better ls
alias ls='ls_extended'

# default icon for notify-send
alias notify-send='notify-send --icon=alarm'


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
docke-machine() { grc docker-machine $@ }
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
