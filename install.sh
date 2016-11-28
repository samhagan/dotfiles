#!/bin/bash
##############################
# .make.sh
# This script creates symlinks from the home directory to the dotfiles directory
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
##############################

########### Variables

dir=~/dotfiles          # dotfiles directory
nvim=~/.config/nvim
nvimInit="init.vim"
files="zshrc oh-my-zsh gitconfig eslintrc tmux.conf"  # list of files to symlink in homedir

###########

main(){
  install_zsh
  clone_OMZ
  confirm_zsh_default
  makeSymLinks
}

makeSymLinks() {
  # change to the dotfiles directory
  echo -n "Changing to the $dir directory ..."
  cd $dir
  echo "done"

  # symlink the files, we just force it if needed 
  for file in $files; do
    echo "Creating symlink to $file in home directory"
    ln -sf $dir/$file ~/.$file
  done

  # symlink the nvim configuration file
  ln -sf $dir/$nvimInit $nvim
}

install_zsh() {
# Test if zshell is installed. If not then install it.
if [ ! -f /bin/zsh -o -f /usr/bin/zsh ]; then
  echo -n "Installing zsh via homebrew"
  brew install zsh
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
    chsh -s $(which zsh)
  fi
}

main
