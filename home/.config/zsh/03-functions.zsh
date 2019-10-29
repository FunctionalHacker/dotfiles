# signoff every commit
git() {
	if [[ "$1" == "commit" && $# -eq 1 ]]; then
		/usr/bin/git commit -S -s
	else
		/usr/bin/git $@
	fi
}

# git shorthands
gc() { git commit $@ }
gpull() { git pull $@ }
gpush() { git push $@ }

# Syntax highlighting cat
cat() {	nvimpager -c $@ }


rip() {
	abcde
	printf "Ripping done. Importing to library"
	beet import ~/Documents/Rip/flac/*
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
:q() { 'exit' }
:wq() { 'exit' }

# zbar output only data
zbarimg() { /usr/bin/zbarimg -q --raw $@ }
zbarcam() { /usr/bin/zbarcam -q --raw $@ }

# switch to desktop mode
dock() { swaymsg output eDP-1 disable }

# move to trash instead of remove
rm() { trash $@ }

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
startvpn() { sudo systemctl start wg-quick@wg0.service }
stopvpn() { sudo systemctl stop wg-quick@wg0.service }

# connect to metropolia vpn
metropoliavpn() { sudo openconnect -u markoak --passwd-on-stdin vpn.metropolia.fi }

# read qrcode from selection
qr() { grim -g "$(slurp -d)" - | zbarimg PNG:- }

# generate qr code in terminal
qrencode() { /usr/bin/qrencode -t ansiutf8 $@ }

# color picker
cpick() { grim -g "$(slurp -p)" -t ppm - | convert - -format "%[pixel:p{0,0}]" txt:- }

# eclim daemon location
eclimd() { /usr/lib/eclipse/eclimd }

#iwctl aliases
i() { iwctl station wlan $@ }

# download firefox customizations
ffcustom() { wget "https://gist.githubusercontent.com/Sporif/db6b3440fba0b1bcf5477afacf93f875/raw/2a1be65a12f8f0c88ba84a69697e542ad62d4624/userChrome.css" "https://gist.github.com/mrkwatz/277fb19d210a7539304ca2388f24d8e3/raw/d5b47f4089a3ef29cc719ecb9f3bc0d333ab866a/userChrome.js" "https://gist.github.com/mrkwatz/277fb19d210a7539304ca2388f24d8e3/raw/d5b47f4089a3ef29cc719ecb9f3bc0d333ab866a/userChrome.xml" }

# nvim ftw!
vim() { nvim $@ }
v() { nvim $@ }

# change cpu power settings
performanceg() { sudo cpupower frequency-set -g performance }
powersaveg() { sudo cpupower frequency-set -g powersave }
performance() { performanceg && sudo ryzenadj --stapm-limit=45000 --fast-limit=45000 --slow-limit=45000 --tctl-temp=90 }
powersave() { powersaveg && sudo ryzenadj --stapm-limit=25000 --fast-limit=25000 --slow-limit=25000 --tctl-temp=55 }
ultimatepowersave() { powersave && sudo ryzenadj --stapm-limit=25000 --fast-limit=25000 --slow-limit=25000 --tctl-temp=20; }

# monitor cpu freq
cpufreq() { watch -n 1 eval "cat /proc/cpuinfo |grep MHz" }

# dotdrop
updatesecrets() { bash $DOTREPO/secrets/secrets.sh }
dotdrop() { source $DOTREPO/secrets/secrets && $DOTREPO/dotdrop/dotdrop.sh --cfg=$DOTREPO/config-home.yaml $@ }
sdotdrop() { source $DOTREPO/secrets/secrets && sudo -E $DOTREPO/dotdrop/dotdrop.sh --cfg=$DOTREPO/config-root.yaml $@ }
dotgit() { git -C $DOTREPO $@ }
dotsync() { cd $DOTREPO && gpull && ga && gc && gpush && cd $OLDPWD }

# sync password manager
passync() { pass git pull && pass git push && updatesecrets }

# update stuff
plugupdate() { vim +PlugUpgrade +PlugUpdate +qa && zplug update }
dotupdate() { dotgit submodule update --init --recursive && dotgit submodule update --remote dotdrop && dotsync }
update() { yay -Syu firefox-nightly; flatpak update }
updateall() { update; plugupdate; dotupdate; passync; sudo awman-update }

# remove unneeded packages
autoremove() { sudo pacman -R $(pacman -Qdtq) }

# start neomutt instead of mutt
mutt() { neomutt $@ }

# turn on usb tethering on my android phone
tether() { adb shell su -c "service call connectivity 33 i32 1 s16 me" > /dev/null }

# update arch mirrorlist
reflect() { sudo reflector --latest 200 --threads 8 --verbose --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist }

# better ls
ls() { lsd $@ }

# default icon for notify-send
notify-send() { /usr/bin/notify-send --icon=alarm $@ }

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
tail() { grc ping $@ }
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
