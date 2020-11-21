#!/bin/zsh

# This is a script that should be ran once
# on a new system. Dotdrop will take it from there.
# It is higly tailored to my own needs and
# you (the random person on the internet) should probably not run it

export DOTREPO="$HOME/git/dotfiles"
DISTRO="$(lsb_release -ds | sed 's/"//g')"

PKGLIST="python-ruamel-yaml python-magic-git python-jinja python-docopt"

if [ -d $DOTREPO ]; then
	print "Dotfile repository already exists, exiting..."
	exit 1
fi

if [ "$DISTRO" -ne "Arch Linux" ]; then
	print "Not running on Arch Linux"
	print "Other distros not supported, exiting..."
	exit 1
fi

# install neovim if not installed
if ! [ -x "$(command -v nvim)" ]; then
	read -p "Install neovim? [Y/n] " -i "y" INVIM
	if [ "$(tr '[:upper:]' ':lower:' $INVIM)" -eq "y" ]; then
		print "Installing neovim"
		PKGLIST=$PKGLIST + " neovim neovim-dropin"
	fi
fi

# install zsh if not installed
if ! [ -x "$(command -v zsh)" ]; then
	read -p "Install zsh? [Y/n] " -i "y" IZSH
	if [ "$(tr '[:upper:]' ':lower:' $INVIM)" -eq "y" ]; then
		print "Installing zsh"
		PKGLIST=$PKGLIST + " zsh"
	fi
fi

# install paru if not installed
if ! [ -x "$(command -v paru)" ]; then
	read -p "Install paru? [Y/n] " -i "y" IYAY
	if [ "$(tr '[:upper:]' ':lower:' $IYAY)" -eq "y" ]; then
		print "Installing paru"
		sudo pacman -Syu --needed --noconfirm git wget base-devel
		cd
		wget https://aur.archlinux.org/cgit/aur.git/snapshot/paru-bin.tar.gz
		tar xfv paru-bin.tar.gz
		cd paru-bin
		makepkg -si --noconfirm
		cd ..
		rm -r paru*
	fi
fi

if [ $PKGLIST -ne "" ]
	if ! [ -x "$(command -v paru)" ]; then
		print "Can't continue without paru"

		paru -S $PKGLIST
	fi
fi

mkdir ~/git
git clone https://git.korhonen.cc/ReekyMarko/dotfiles.git $DOTREPO
cd ~/git/dotfiles
git submodule init
git submodule update
$DOTREPO/dotdrop.sh --cfg=$DOTREPO/config-home.yaml install
chsh -s /bin/zsh
zsh -c "source ~/.zshrc; sdotdrop install"
