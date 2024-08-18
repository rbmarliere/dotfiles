if [ "$(tty)" = "/dev/tty1" ]; then
	export GTK_USE_PORTAL=0
	export XDG_CURRENT_DESKTOP=GNOME
	which sway && exec sway
fi

source "$HOME/.bashrc"
