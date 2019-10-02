#!/bin/bash
set -euo pipefail

dir="$HOME/dotfiles"
envfile="$dir/envs.txt"

configs=(
  bash_aliases
  bash_logout
  bash_profile
  bashrc
  gitconfig
  tmux.conf
  xinitrc
  Xmodmap
  Xresources
  config/i3/config
  config/nvim/init.vim
)

copy_config(){
  source "$envfile"
  for file in "${configs[@]}"; do
    src_path="$dir/$file"
    dst_path="$HOME/.$file"
    dst_dir=$(dirname "$dst_path")

    [[ -d "$dst_dir" ]] && mkdir -p "$dst_dir"
    [[ -L "$dst_path" ]] && rm -f "$dst_path"

    echo "copying $src_path to $dst_path"
    cp -f "$src_path" "$dst_path"
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

install_k8sbash(){
  if [[ ! -d ~/.config/base16-shell ]]; then
    git clone https://github.com/amill676/k8sbash.git ~/.config/k8sbash
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
    notify-osd \
    gnome-screenshot \
    eog \
    gnome-keyring \
    shellcheck \
    fonts-noto-color-emoji \
    gawk

  install_tpm
  install_base16
  install_k8sbash

  # chrome
  # slack
}

MODE=$1

if [ "$MODE" = "link" ]; then
  copy_config
fi

if [ "$MODE" = "packages" ]; then
  install_packages
fi
