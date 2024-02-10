if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi

source "$HOME/.bashrc"
