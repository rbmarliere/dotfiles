source "$HOME/.bash_aliases"
source "$HOME/.bash_env"

if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
	source /usr/share/doc/fzf/examples/key-bindings.bash
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
	source /usr/share/bash-completion/bash_completion
	source /usr/share/bash-completion/completions/fzf  #1013356 ("fzf: Bash completions not active by default")
	if [ -f /usr/share/bash-completion/completions/git ]; then
		source /usr/share/bash-completion/completions/git
		__git_complete g __git_main
	fi
	for f in $HOME/.local/bin/*.completion; do
		source $f
	done
fi

