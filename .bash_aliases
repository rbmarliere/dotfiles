alias ..="cd .."
alias act="source venv/bin/activate || source .venv/bin/activate"
alias g="git"
alias grep="grep --color=auto"
alias la="ls --color=auto -la"
alias ll="ls --color=auto -l"
alias ls="ls --color=auto"
alias py="python3"
alias rr="source ~/.bashrc"

if type sudo >/dev/null 2>&1; then
	alias apt="sudo apt"
	alias blkid="sudo blkid"
	alias cfdisk="sudo cfdisk"
	alias chroot="sudo chroot"
	alias dd="sudo dd status=progress conv=fdatasync"
	alias dmesg="sudo dmesg"
	alias dpkg="sudo dpkg"
	alias fdisk="sudo fdisk"
	alias losetup="sudo losetup"
	alias mount="sudo mount"
	alias reboot="sudo shutdown -r --no-wall now"
	alias shut="sudo shutdown -h --no-wall now"
	alias ss="sudo su -"
	alias ufw="sudo ufw"
	alias umount="sudo umount"
fi

if systemctl --user status tmux >/dev/null 2>&1; then
	alias reboot="systemctl --user stop tmux && sudo shutdown -r --no-wall now"
	alias shut="systemctl --user stop tmux && sudo shutdown -h --no-wall now"
fi
