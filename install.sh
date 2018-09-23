#!/bin/bash
set -euo pipefail

########### Variables
dir=~/dotfiles
nvim=~/.config/nvim
nvimInit="init.vim"

# list of files to symlink to the home directory
home_files=(
  zshrc
  oh-my-zsh
  gitconfig
  tmux.conf
)

# list of programs to confirm are installed
requirements=(
  git
  tmux
)

###########
main()
{
  install_requirements
  clone_OMZ
  confirm_zsh_default
  make_symlinks
  install_tpm
}

install_requirements()
{
    sudo apt-get update

    for req in "${requirements[@]}"; do
      if ! command -v "$req"; then
          echo "Installing $req"
          sudo apt-get install -y "$req"
      fi
    done
}

make_symlinks()
{
  echo "Changing to the $dir directory ..."
  cd $dir

  for file in "${home_files[@]}"; do
    echo "Creating symlink to $file in home directory"
    ln -sf "$dir/$file" ~/."$file"
  done

  echo "Creating nvim symlink"
  ln -sf $dir/$nvimInit $nvim/$nvimInit
}

install_tpm()
{
  if [[ ! -d ~/.tmux/plugins ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

clone_OMZ()
{
if [[ ! -d $dir/oh-my-zsh/ ]]; then
  echo "cloning oh-my-zsh"
  git clone git@github.com:robbyrussell/oh-my-zsh.git
fi
}

confirm_zsh_default()
{
  if [[ ! "$SHELL" == $(which zsh) ]]; then
    echo "changing shell to zsh"
    chsh -s "$(which zsh)"
  fi
}

main
