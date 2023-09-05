function ch_remove_all_sessions
    set sessions $(schroot -l --all-sessions | cut -d ':' -f 2)
    for session in $sessions
        schroot -e -c $session
    end
end
