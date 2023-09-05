function fish_prompt
    set -g fish_prompt_pwd_dir_length 0
    set -l prompt_symbol '$ '
    set debian_chroot (cat /etc/debian_chroot 2>/dev/null)
    if test -n "$debian_chroot"
        set debian_chroot '('$debian_chroot') '
    end

    echo -s (date '+%H:%M:%S') ' ' \
    (set_color --bold red) $debian_chroot \
    (set_color normal) $USER@(prompt_hostname) ' ' \
    (set_color --bold green) (prompt_pwd) \
    (set_color normal) (set_color yellow) (fish_git_prompt) \
    (set_color --bold white) \n $prompt_symbol \
    (set_color normal)
end

