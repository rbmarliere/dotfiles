function fish_prompt
    set -l prompt_symbol ' $ '
    fish_is_root_user; and set prompt_symbol ' # '

    echo -s (date '+%H:%M:%S') ' ' \
    (prompt_hostname) ' ' \
    (set_color --bold green) (prompt_pwd) \
    (set_color yellow) (fish_git_prompt) \
    (set_color normal) $prompt_symbol
end

