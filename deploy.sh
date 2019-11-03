#!/bin/bash

# to run this, execute
# bash <(curl -sL git.reekynet.com/ReekyMarko/dotfiles/raw/branch/master/deploy.sh)

# Run this to install my dotfiles on a fresh Arch Linux installation.
# This should work on any Arch Linux install with an internet connection
# and sudo rights

# When asked a hostname, make sure it's already in the dotrop config,
# otherwise dotdrop won't install anything

export DOTREPO="$HOME/Git/dotfiles"
export HOSTNAME="$(hostnamectl | head -n 1 | sed 's/ //g' | cut -d':' -f2-)"
export DISTRO="$(lsb_release -ds | sed 's/"//g')"

if [ "$DISTRO" -ne "Arch Linux" ]; then
	print "Not running on Arch Linux"
	print "Other distros not supported, exiting..."
	exit 1
fi

read -p "Hostname [$HOSTNAME]: " -i $HOSTNAME NEWHOSTNAME
if [ "$HOSTNAME -ne $NEWHOSTNAME" ]; then
	sudo hostnamectl set-hostname $NEWHOSTNAME	
fi
HOSTNAME=$NEWHOSTNAME

# install yay
if ! [ -x "$(command -v yay)" ]; then
	read -p "Install yay? [Y/n] " -i "y" IYAY
	if [ "$(tr '[:upper:]' ':lower:' $IYAY)" -eq "y" ]; then
		print "Installing yay"
	fi
	sudo pacman -Syu --needed --noconfirm git wget base-devel
	cd
	wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
	tar xfv yay.tar.gz
	cd yay
	makepkg -si --noconfirm
	cd ..
	rm -r yay*
fi

mkdir ~/Git
git clone https://git.reekynet.com/ReekyMarko/dotfiles.git $DOTREPO
cd ~/Git/dotfiles
git submodule init
git submodule update
$DOTREPO/dotdrop.sh --cfg=$DOTREPO/config-home.yaml install
chsh -s /bin/zsh
zsh -c "source ~/.zshrc; sdotdrop install"
