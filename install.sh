#!/bin/bash -e
##############################
# .make.sh
# This script creates symlinks from the home directory to the dotfiles directory
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
##############################

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

###########

main(){
  clone_OMZ
  confirm_zsh_default
  makeSymLinks
  install_tpm
}

makeSymLinks() {
  # change to the dotfiles directory
  echo -n "Changing to the $dir directory ..."
  cd $dir
  echo "done"

  # symlink the files, we just force it if needed
  for file in "${home_files[@]}"; do
    echo "Creating symlink to $file in home directory"
    ln -sf $dir/$file ~/.$file
  done

  # symlink the nvim configuration file
  ln -sf $dir/$nvimInit $nvim/$nvimInit
}

install_tpm(){
  if [[ ! -d ~/.tmux/plugins ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

clone_OMZ() {
if [[ ! -d $dir/oh-my-zsh/ ]]; then
  echo -n "cloning oh-my-zsh"
  git clone git@github.com:robbyrussell/oh-my-zsh.git
fi
}

confirm_zsh_default(){
  if [[ ! $(echo /usr/local$SHELL) == $(which zsh) ]]; then
    echo "changin shell"
    chsh -s $(which zsh)
  fi
}

main
