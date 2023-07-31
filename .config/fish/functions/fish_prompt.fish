function fish_prompt
    set -g fish_prompt_pwd_dir_length 0
    set -l prompt_symbol '$ '
    fish_is_root_user; and set prompt_symbol '# '

    echo -s (date '+%H:%M:%S') ' ' \
    $USER@(prompt_hostname) ' ' \
    (set_color --bold green) (prompt_pwd) \
    (set_color normal) (set_color yellow) (fish_git_prompt) \
    (set_color --bold white) \n $prompt_symbol \
    (set_color normal)
end

