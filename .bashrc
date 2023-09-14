export PATH="$HOME/.local/bin:$PATH"
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%F %T "
export HISTFILE="$HOME/.bash_eternal_history"
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s histappend

function parse_git_dirty {
	[[ $(git status --porcelain 2> /dev/null) ]] && echo " *"
}
function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}
export PS1="\t \[\e[01;91m\]${debian_chroot:+($debian_chroot) }\[\e[00m\]\u@\h \[\e[01;32m\]\w\[\e[00;33m\]\$(parse_git_branch)\[\e[00m\]\n\$ "
export PS0='\[\e]0;$(history 1 | cut -d " " -f5-)\a\]'

alias ..="cd .."
alias g="git"
alias grep="grep --color=auto"
alias la="ls --color=auto -la"
alias ls="ls --color=auto"

[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash

bind '"\006":"tmux_loader\n"'
