#!/bin/bash
set -euo pipefail

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
  if [[ ! -d ~/.config/k8sbash ]]; then
    git clone https://github.com/amill676/k8sbash.git ~/.config/k8sbash
  fi
}

install_packages(){
  sudo apt-get update
  sudo apt-get install -y \
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
    eog \
    shellcheck \
    fonts-noto-color-emoji \
    gawk \
    libpam-u2f \
    scrot \
    anki \
    make \
    build-essential \
    openssl \
    autoconf \
    automake \
    libtool \
    libgmp3-dev \
    inotify-tools \
    libssl-dev \
    libncurses5-dev \
    snapd

  install_tpm
  install_base16
  install_k8sbash

  # chrome
  # slack
  # gnome-keyring
}

install_packages
