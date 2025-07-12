function sudo
    if functions -q $argv[1]
        set argv fish -c "$argv"
    end
    command sudo -sE $argv
end
