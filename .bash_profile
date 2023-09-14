if [ "$(tty)" = "/dev/tty1" ]; then
	ch_wipe
	exec sway
fi

source "$HOME/.bashrc"
