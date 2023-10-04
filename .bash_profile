if [ "$(tty)" = "/dev/tty1" ]; then
	bash ~/.local/bin/ch_wipe
	exec sway
fi

source "$HOME/.bashrc"
