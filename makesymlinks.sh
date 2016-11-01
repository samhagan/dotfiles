#!/bin/bash
##############################
# .make.sh
# This script creates symlinks from the home directory to the dotfiles directory
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
##############################

########### Variables

dir=~/dotfiles          # dotfiles directory
olddir=~/dotfiles_old   # old dotfiles backup directory
files="zshrc oh-my-zsh eslintrc spacemacs"  # list of files to symlink in homedir

###########

main(){
  install_zsh
  clone_OMZ
  confirm_zsh_default
  makeSymLinks
}

makeSymLinks() {
  # create dotfiles_old in homedir
  echo -n "Creating $olddir for backup of any existing dotfiles in ~..."
  mkdir -p $olddir
  echo "done"

  # change to the dotfiles directory
  echo -n "Changing to the $dir directory ..."
  cd $dir
  echo "done"

  # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks dotfiles
  for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory"
    ln -s $dir/$file ~/.$file
  done
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
