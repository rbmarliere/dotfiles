source "$HOME/.bash_aliases"
source "$HOME/.bash_env"

if [ -f /usr/share/bash-completion/bash_completion ]; then
	source /usr/share/bash-completion/bash_completion
	if [ -f /usr/share/bash-completion/completions/git ]; then
		source /usr/share/bash-completion/completions/git
		__git_complete g __git_main
	fi
	for f in $HOME/.local/bin/*.completion; do
		source $f
	done
fi

if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
	# debian
	source /usr/share/bash-completion/completions/fzf #1013356 ("fzf: Bash completions not active by default")
	source /usr/share/doc/fzf/examples/key-bindings.bash
fi
if [ -f /usr/share/bash-completion/completions/fzf-key-bindings ]; then
	# leap
	source /usr/share/bash-completion/completions/fzf-key-bindings
fi
if [ -f /etc/profile.d/fzf-bash.sh ]; then
	# tumbleweed
	source /etc/profile.d/fzf-bash.sh
fi


root_runner() {
	if [ -z "$1" ]; then
		return
	fi
	if [[ $(cat /etc/debian_chroot 2>/dev/null) != "" ]]; then
		# inside chroot, must execute outside
		sudo chroot /proc/1/cwd /bin/sudo -u $(whoami) /bin/bash -c "XDG_RUNTIME_DIR=/run/user/$(id -u) $1"
		return $?
	else
		eval "$1"
		return $?
	fi
}

shut() {
	if [ -n "$TMUX" ]; then
		tmux detach-client -E "/bin/bash -lc 'shut $@'"
		return
	fi
	echo shut?
	read
	if root_runner "systemctl --user status tmux >/dev/null 2>&1"; then
		root_runner "systemctl --user stop tmux"
	fi
	root_runner "sudo shutdown -h --no-wall now"
}

reboot() {
	if [ -n "$TMUX" ]; then
		tmux detach-client -E "/bin/bash -lc 'reboot $@'"
		return
	fi
	echo reboot $1?
	read
	if root_runner "systemctl --user status tmux >/dev/null 2>&1"; then
		root_runner "systemctl --user stop tmux"
	fi
	if [ -n "$1" ]; then
		root_runner "sudo grub-reboot $1 || sudo grub2-reboot $1"
	fi
	root_runner "sudo shutdown -r --no-wall now"
}
