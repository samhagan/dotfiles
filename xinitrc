#!/bin/sh

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

exec i3
