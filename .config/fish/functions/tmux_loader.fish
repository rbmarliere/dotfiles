function tmux_loader
    if test -z "$PROJ_DIRS"
        echo "PROJ_DIRS not set"
        return
    end

    set -l selected $(find $(string split ':' $PROJ_DIRS) -mindepth 1 -maxdepth 1 -type d 2>/dev/null | fzf)

    if test -z "$selected"
        return
    end

    set session (basename $selected | tr . _)

    if not tmux has-session -t="$session" 2> /dev/null
        tmux new-session -ds "$session" -c "$selected"
    end

    if test -z "$TMUX"
        tmux attach-session -t "$session"
    else
        tmux switch-client -t "$session"
    end
end
