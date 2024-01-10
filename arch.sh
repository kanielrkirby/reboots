#!/bin/bash

username="mx"

deps=(
  base
  base-devel
  linux-firmware
  git
  sudo
  python
  python-pip
)

pkgs=(
  alacritty
  ark
  antigen
  bluez
  bluez-utils
  brave-bin
  brightnessctl
  btop
  catfish
  curl
  efibootmgr
  exa
  fuzzel
  fzf
  github-cli
  gnome-keyring
  gopass
  grim
  grub
  gtk4
  hyprland
  hyprpaper
  iptables-nft
  localsend-bin
  mako
  man
  mullvad-vpn-bin
  neofetch
  neovim
  networkmanager
  nfs-utils
  nodejs
  npm
  openssh
  os-prober
  pipewire
  pipewire-alsa
  pipewire-jack
  pipewire-pulse
  qemu-base
  qt5
  sddm
  slurp
  swaylock
  tealdeer
  tessen
  thunar
  thunar-archive-plugin
  thunar-media-tags-plugin
  thunar-shares-plugin
  thunar-volman
  trash
  tree
  ttf-firacode-nerd
  tumbler
  update-grub
  vagrant
  virt-manager
  visual-studio-code-bin
  waybar
  which
  wireplumber
  wl-clipboard
  wlroots
  xdg-desktop-portal-hyprland
  xorg-xev
  xremap
  xwaylandvideobridge
  yarn
  z
  zsh
)

base_conf_dirs=(
  antigen
  astro
  bash
  btop
  cargo
  gh
  git
  github-copilot
  gopass
  npm
  nvim
  reboots
  tealdeer
  wallpapers
  yarn
  zsh
  chrome-flags.conf
  chromium-flags.conf
  code-flags.conf
  electron-flags.conf
  starship.toml
)

conf_dirs=$base_conf_dirs
conf_dirs+=(
  fuzzel
  hypr
  libvirt
  mako
  vagrant.d
  waybar
  yay
  alacritty.toml
  arkrc
  xremap.yml
)

# Arch specific variables
OS_NAME="arch"
USER="mx"
HOME="/home/$USER"
XDG_CONFIG_HOME="$HOME/.config"
BUILDS="$HOME/builds"
PASSWORD_STORE_DIR="$HOME/.password-store"
CLONE="$BUILDS/home"

# Install yay
git clone https://aur.archlinux.org/yay-bin.git $BUILDS/yay
(cd $BUILDS/yay && makepkg -si && rm -rf $BUILDS/yay)

# Install packages
yay -Syu --needed --noconfirm "${pkgs[@]}"

# Make directories
mkdir -p $BUILDS $XDG_CONFIG_HOME $PASSWORD_STORE_DIR

# Login to github through cli
gh auth login

git clone https://github.com/kanielrkirby/home "$CLONE"

for conf in $conf_dirs; do
  cp -r "$CLONE/.config/$conf" "$XDG_CONFIG_HOME"
done

echo "export OS_NAME=\"$OS_NAME\"" > $XDG_CONFIG_HOME/bash/bashrc.d/os.sh

cp $CLONE/.zshrc $HOME
cp $CLONE/.password-store/* $PASSWORD_STORE_DIR
