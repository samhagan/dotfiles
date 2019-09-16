#!/bin/bash
set -euo pipefail

dir=$HOME/dotfiles

# list of files to symlink to the home directory
home_files=(
  bash_aliases
  bash_logout
  bash_profile
  bashrc
  gitconfig
  tmux.conf
  xinitrc
  Xmodmap
  Xresources
)

# list of files to symlink to the .config directory
config_files=(
  i3/config
  nvim/init.vim
)

make_home_links(){
  for file in "${home_files[@]}"; do
    echo "creating symlink to $file in home directory"
    ln -sf "$dir/$file" "$HOME/.$file"
  done
}

make_config_links(){
  for file in "${config_files[@]}"; do
    src_path="$dir/$file"
    dst_path="$HOME/.config/$file"
    dst_dir=$(dirname "$dst_path")

    mkdir -p "$dst_dir"

    echo "creating symlink from $src_path to $dst_path"
    ln -sf "$src_path" "$dst_path"
  done
}

install_tpm(){
  if [[ ! -d ~/.tmux/plugins ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

install_base16(){
  if [[ ! -d ~/.config/base16-shell ]]; then
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
  fi
}

install_packages(){
  apt-get install -y \
    xorg \
    fonts-liberation \
    git \
    curl \
    fuse \
    make \
    python-pip python3-venv python3-pip \
    libdbus-glib-1-2 \
    libu2f-host0 \
    xclip \
    ripgrep \
    tmux \
    xclip \
    libpolkit-agent-1-0 \
    xautolock \
    ranger \
    zathura \
    pulseaudio \
    sudo \
    i3 \
    zenity \
    fonts-font-awesome \
    kdialog \
    dbus-x11 \
    notify-osd

  install_tpm
  install_base16

  # chrome
  # slack
}

MODE=$1

if [ "$MODE" = "link" ]; then
  make_home_links
  make_config_links
fi

if [ "$MODE" = "packages" ]; then
  install_packages
fi
