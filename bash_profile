#export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# export PS1="\[\033[36m\]\u\[\033[m\]\[\033[32m\]\[\033[33;1m\]\w\[\033[m\]\$(parse_git_branch)\[\033[00m\] $ "

# add color to terminal
# http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
# export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced


# Git branch in prompt
# parse_git_branch() {
#   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }

# make directory and cd into it
mkcdir () {
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

# aliases
alias ls='ls -GhA'                          # preferred 'ls' implementation
alias ..='cd ../'                           # go back 1 directory level
alias ...='cd ../../'                       # go back 2 directory levels
alias .3='cd ../../../'                     # go back 3 directory levels

# improve tab completion
bind "set completion-ignore-case on"       # makes case insensitive
bind "set show-all-if-ambiguous on"        # makes unncessary to pres tab twice if there is more than one match

#Docker
eval "$(docker-machine env default)"

#Docker API -- dealing with certification
export docker_api="--cacert $DOCKER_CERT_PATH/ca.pem --cert $DOCKER_CERT_PATH/cert.pfx --pass supersecret https://192.168.99.100:2376"
