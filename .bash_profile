if [ "$(tty)" = "/dev/tty1" ]; then
	export GTK_USE_PORTAL=0
	export XDG_CURRENT_DESKTOP=GNOME
	if lsmod | grep -qi nvidia; then
		export WLR_NO_HARDWARE_CURSORS=1
		which sway && exec sway --unsupported-gpu
	else
		which sway && exec sway
	fi
fi

source "$HOME/.bashrc"
