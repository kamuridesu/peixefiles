function shredir --description "Wraps shred to delete dirs and shred files"
    argparse f/force -- $argv

    set -l DIR "$argv"
    if test -z "$DIR"
        echo "Usage: shredir path/to/dir"
        return 1
    end

    set -l RM rm -r
    set -l SHRED shred --zero --iterations=10 -u --random-source=/dev/urandom 
    if set -q _flag_force
        echo "Warning: All files will be force removed"
        set RM "$RM -f"
        set SHRED "$SHRED -f"
    end

    set -l FILES (find $DIR -type f)
    if test ! $status -eq 0
        return $status
    end

    set -l CONFIRM "N"
    set -l TOTAL (count $FILES)

    echo "$TOTAL files will be FOREVER DELETED, are you sure? [y/N]: "
    set -l CONFIRM (read)

    if test $CONFIRM != "y"
        return 0
    end

    set CURRENT_COUNT 0
    set PLACEHOLDER_LENGTH 0
    for file in $FILES
        set CURRENT_COUNT (math $CURRENT_COUNT + 1)
        echo -en "$(string repeat -n $PLACEHOLDER_LENGTH ' ')\r"
        set MESSAGE "[$CURRENT_COUNT/$TOTAL] Shreding file $file\r"
        if test (string length "$MESSAGE") -gt $PLACEHOLDER_LENGTH
            set PLACEHOLDER_LENGTH (string length "$MESSAGE")
        end
        echo -en "$MESSAGE\r"
        eval $SHRED $file || return 1
    end

    echo ""

    echo "Deleting dir $DIR"
    eval $RM $DIR || return 1
end
