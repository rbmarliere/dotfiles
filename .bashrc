source "$HOME/.bash_env"
source "$HOME/.bash_aliases"

[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash

if [ -f /usr/share/bash-completion/bash_completion ]; then
	source /usr/share/bash-completion/bash_completion
	source /usr/share/bash-completion/completions/fzf  #1013356 ("fzf: Bash completions not active by default")
	if [ -f /usr/share/bash-completion/completions/git ]; then
		source /usr/share/bash-completion/completions/git
		__git_complete g __git_main
	fi
fi

