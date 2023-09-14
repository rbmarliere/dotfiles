if [ "$(tty)" = "/dev/tty1" ]; then
	~/.local/bin/ch_wipe
	exec sway
fi

source "$HOME/.bashrc"
