function ch
    if test -z $argv
        echo "E: chroot name not specified"
        return 1
    end

    if not schroot -l -a | grep -q chroot:$argv
    	echo "E: chroot not found"
        return 1
    end

    if ls /var/lib/schroot/session | grep -q $argv
        if not mount | grep -q /run/schroot/mount/$argv
            schroot --recover-session -c $argv > /dev/null
        end
    else
        schroot -b -n $argv -c $argv > /dev/null
    end

    exec schroot -r -c $argv
end
