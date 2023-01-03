#!/bin/bash
###################
# Apps Installation
###################
sudo pacman -S ntfs-3g zsh mpd ncmpcpp firefox veracrypt nitrogen alacritty flameshot guvcview xarchiver gpick lsd blueberry neovim xclip playerctl pamixer
yay -S picom-pijulius-git zsh-autosuggestions-git zsh-sudo-git zsh-syntax-highlighting-git visual-studio-code-bin tor-browser
curl -sS https://starship.rs/install.sh | sh
######################## 
# Auto Mount NTFS Drives 
########################
drive1="/dev/sdd1 /mnt/Seagate ntfs-3g rw,uid=1000,gid=1000,umask=0022,fmask=0022,x-gvfs-show 0 0"
drive2="/dev/sdc1 /mnt/Toshiba ntfs-3g rw,uid=1000,gid=1000,umask=0022,fmask=0022,x-gvfs-show 0 0"
echo "################################ My Drives ###############################################" >> /etc/fstab
echo $drive1 >> /etc/fstab
echo $drive2 >> /etc/fstab
##########################
# Create dotfiles Symlinks
##########################
# make dotfiles directories
mkdir $HOME/.config/alacritty
mkdir $HOME./config/mpd
mkdir $HOME./config/ncmpcpp
mkdir $HOME./config/awesome
mkdir $HOME./config/rofi
mkdir $HOME./config/mpDris2
mkdir $HOME./config/picom
##########################
# make symlinks
# $HOME/.config/alacritty
# $HOME/.config/mpd
# $HOME/.config/ncmpcpp
# $HOME/.config/awesome
# $HOME/.config/rofi
# $HOME/.config/mpDris2
# $HOME/.config/picom
##########################
#
