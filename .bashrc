source "$HOME/.bash_aliases"
source "$HOME/.bash_env"

BASH_PREEXEC="$(dirname "$(readlink -f $BASH_SOURCE)")/.deps/bash-preexec/bash-preexec.sh"
if [ -f "$BASH_PREEXEC" ]; then
	source "$BASH_PREEXEC"
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

if [ -n "$TMUX" ]; then
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
