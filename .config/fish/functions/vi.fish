function vi
    if type -q nvim
        nvim $argv
    else if type -q vim
        vim $argv
    else if type -q /usr/bin/vi
        /usr/bin/vi $argv
    else
        echo "E: no vi found"
    end
end
