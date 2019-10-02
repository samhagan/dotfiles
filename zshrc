
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bazel related
if [ -f "$HOME/.bazel/bin/bazel-complete.bash" ]; then
    export PATH=$PATH:$HOME/bin
    source /home/sam/.bazel/bin/bazel-complete.bash
fi
