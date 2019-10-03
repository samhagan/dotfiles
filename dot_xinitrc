#!/bin/sh

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

eval $(dbus-launch --sh-syntax)

exec i3
