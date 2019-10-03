source ~/.bashrc

# helps actually running startx on boot
sleep 1

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

