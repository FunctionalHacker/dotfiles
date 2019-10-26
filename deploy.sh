#!/bin/bash

# Short url for this file: bit.ly/reekydots

# to run this, execute
# bash <(curl -sL bit.ly/reekydots)


# Run this to install my dotfiles on a fresh Arch Linux installation.
# This should work on any fresh Arch Linux install with an internet connection

# When asked a hostname, make sure it's already in the dotrop config,
# otherwise dotdrop won't install anything

export DOTREPO="$HOME/Git/dotfiles"

read -p "Hostname: " hostname
read -p "Install pkglist-extra? [y/n]: " extra

# install yay
sudo pacman -Syu --needed --noconfirm git wget base-devel python python-jinja python-pyaml python-docopt
cd ~
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay-bin.tar.gz
tar xfv yay-bin.tar.gz
cd yay-bin
makepkg -sic --noconfirm
cd ..
rm -r yay-bin*
yay -S --noconfirm --combinedupgrade --sudoloop --pgpfetch reflector
printf "\nUpdating mirrorlists, this might take a while"
sudo reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# install dotfiles
mkdir ~/Git
git clone https://gitlab.com/ReekyMarko/dotfiles.git ~/Git/dotfiles
cd ~/Git/dotfiles
git submodule init
git submodule update
./dotdrop.sh -p "$hostname" install
sudo $DOTREPO/dotdrop.sh -p "$hostname" --cfg=$DOTREPO/global-config.yaml install

# setup locale
yay -S --noconfirm locale-en_xx
sudo locale-gen

# set network, timezone and hostname
sudo su -c " echo "$hostname" > /etc/hostname"
yay -S --noconfirm tzupdate 
sudo timedatectl set-ntp true
sudo tzupdate

# install essentials
yay -S --needed - < pkglist

# install all other packages
if [[ "$extra" == "y" ]]; then
	yay -S --noconfirm nodejs-lts-carbon
	yay -S --needed - < pkglist-extra
fi

# install zplugin
mkdir ~/.zplugin
git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# change shell
chsh -s /bin/zsh

# enable autologin for the current user
mkdir /etc/systemd/system/getty@tty1.service.d
sudo su -c "cat <<CONFIG > /etc/systemd/system/getty@tty1.service.d/override.conf
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $(who | sed 's/ .*//') --noclear %I $TERM
CONFIG"

printf "\nEverything done. Install display drivers and reboot"
