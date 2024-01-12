#!/bin/bash

username="mx"

pkgs=(
  arc
  blackhole-16ch
  blender
  brave-browser
  espanso
  figma
  firefox
  google-chrome
  hammerspoon
  hiddenbar
  httpie
  hyperkey
  kdenlive
  localsend
  macfuse
  monero-wallet
  mullvadvpn-beta
  obs
  obsidian
  openemu
  raycast
  rectangle
  shortcat
  signal
  steam
  tor-browser
  transmission
  veracrypt
  visual-studio-code
  vlc
  wezterm
  zoom
  amar1729/formulae/browserpass
  antigen
  bash
  btop
  colima
  coreutils
  docker
  docker-buildx
  docker-compose
  docker-machine
  exa
  fzf
  gh
  git
  git-lfs
  gnu-sed
  go
  gopass
  httpie
  jq
  koekeishiya/formulae/yabai
  libxau
  libxdmcp
  libzip
  make
  minetest
  monero
  neovim
  netlify-cli
  pass
  python-setuptools
  python-tk@3.11
  ruby
  sqlcipher
  starship
  tealdeer
  trash
  tursodatabase/tap/turso
  yarn
  zellij
)

taps=(
  amar1729/formulae
  koekeishiya/formulae
  tursodatabase/tap
)

base_conf_dirs=(
  antigen
  astro
  bash
  btop
  cargo
  docker
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
  hammerspoon
  wezterm
)

# Arch specific variables
OS_NAME="mac"
USER="mx"
HOME="/Users/$USER"
XDG_CONFIG_HOME="$HOME/.config"
BUILDS="$HOME/builds"
PASSWORD_STORE_DIR="$HOME/.password-store"
CLONE="$BUILDS/home"

# Install packages
brew tap $taps
brew install $pkgs

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

# Get Parallels (free)
brew tap homebrew/cask-versions/parallels18
brew install --cask parallels18
git clone git@github.com:andrewssobral/parallels_desktop_crack_18.0.1-53056.git $BUILDS/parallels
cd $BUILDS/parallels
# Log out of parallels here
chmod +x ./install.sh && sudo ./install.sh
