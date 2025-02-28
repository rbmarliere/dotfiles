if [[ $- != *i* ]]; then
	return
fi

# https://gist.github.com/mcattarinussi/834fc4b641ff4572018d0c665e5a94d3
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=$(tty)

export EDITOR="vi"
export LESS="-R --mouse"
export PATH="/usr/lib/ccache:$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/node_modules/.bin:/var/lib/flatpak/exports/bin:$PATH"
export PROJECTS="$HOME/src/**"
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/home/$(whoami)/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"

export HISTCONTROL="ignoreboth"
export HISTIGNORE="tmux_loader:ls:la:history:pwd:htop:bg:fg:clear"
export HISTFILE="$HOME/.bash_eternal_history"
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%F %T "
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s cmdhist
shopt -s histappend

PS0='\[\e]0;$HOSTNAME\a\]'$PS0
PS1='\[\e[00;36m\]\t \[\e[00;91m\]${debian_chroot:+$debian_chroot }\[\e[$( [ "$UID" -eq 0 ] && echo "01;91" || echo "00" )m\]\u@\h \[\e[00;32m\]\w\[\e[00;33m\]$(__git_ps1 " %s")\[\e[00m\]\n\$ '

type vim > /dev/null 2>&1 && export MANPAGER="/bin/sh -c \"col -b | vim -M +MANPAGER -c 'colorscheme default | set laststatus=0 showtabline=0 notermguicolors ft=man ts=8 nomod nolist nonu noma' -\""
type nvim > /dev/null 2>&1 && export MANPAGER="nvim +Man! -c 'colorscheme vim | set laststatus=0 showtabline=0 notermguicolors'"

BASH_PREEXEC="$(dirname "$(readlink -f $BASH_SOURCE)")/.deps/bash-preexec/bash-preexec.sh"
if [[ -f $BASH_PREEXEC ]]; then
	source "$BASH_PREEXEC"
fi
if [[ -n $TMUX ]]; then
	refresh() {
		# https://raimue.blog/2013/01/30/tmux-update-environment/
		local v
		while read v; do
			if [[ $v == -* ]]; then
				unset ${v/#-/}
			else
				# Add quotes around the argument
				v=${v/=/=\"}
				v=${v/%/\"}
				eval export $v
			fi
		done < <(tmux show-environment)
	}
else
	refresh() {
		true
	}
fi
preexec() {
	refresh
}

FZF_TAB_COMPLETION="$(dirname "$(readlink -f $BASH_SOURCE)")/.deps/fzf-tab-completion/bash/fzf-bash-completion.sh"
if [[ -f $FZF_TAB_COMPLETION ]]; then
	source "$FZF_TAB_COMPLETION"
	bind -x '"\t": fzf_bash_completion'
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
	source /usr/share/bash-completion/bash_completion
	if [ -f /usr/share/bash-completion/completions/git ]; then
		source /usr/share/bash-completion/completions/git
		__git_complete g __git_main
	fi
	for f in "$HOME"/.local/bin/*.completion; do
		source "$f"
	done
fi

if [[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
	# debian
	source /usr/share/bash-completion/completions/fzf #1013356 ("fzf: Bash completions not active by default")
	source /usr/share/doc/fzf/examples/key-bindings.bash
fi
if [[ -f /usr/share/bash-completion/completions/fzf-key-bindings ]]; then
	# leap
	source /usr/share/bash-completion/completions/fzf-key-bindings
fi
if [[ -f /etc/profile.d/fzf-bash.sh ]]; then
	# tumbleweed
	source /etc/profile.d/fzf-bash.sh
fi

[[ -f $HOME/.bash_aliases ]] && source "$HOME/.bash_aliases"
[[ -f $HOME/.bashrc.local ]] && source "$HOME/.bashrc.local"
