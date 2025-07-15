function shredir --description "Wraps shred to delete dirs and shred files"
    argparse f/force -- $argv

    set -l DIR "$argv"
    if test -z "$DIR"
        echo "Usage: shredir path/to/dir"
        return 1
    end

    set -l RM_ARGS -r
    set -l SHRED_ARGS --zero --iterations=10 -u --random-source=/dev/urandom 
    if set -q _flag_force
        echo "Warning: All files will be force removed"
        set RM_ARGS -r -f
        set SHRED_ARGS --zero --iterations=10 -u --random-source=/dev/urandom -f
    end

    set -l FILES (find $DIR -type f)
    if test ! $status -eq 0
        return $status
    end

    set -l CONFIRM "N"
    set -l TOTAL (count $FILES)

    echo "$TOTAL files will be FOREVER DELETED, are you sure? [y/N]: "
    set -l CONFIRM (read)

    if test "$CONFIRM" != "y"
        return 0
    end

    set CURRENT_COUNT 0
    set PLACEHOLDER_LENGTH 0
    set MAX_CONCURRENT_SHREDS 10
    set FAILED_TMP_FILE "/tmp/$(basename (status -f)).failed"
    echo "" > $FAILED_TMP_FILE

    for file in $FILES

        while test (count (jobs)) -eq $MAX_CONCURRENT_SHREDS
        end
    
        set CURRENT_COUNT (math $CURRENT_COUNT + 1)
        echo -en "$(string repeat -n $PLACEHOLDER_LENGTH ' ')\r"
        set MESSAGE "[$CURRENT_COUNT/$TOTAL] Shreding file $file\r"
        if test (string length "$MESSAGE") -gt $PLACEHOLDER_LENGTH
            set PLACEHOLDER_LENGTH (string length "$MESSAGE")
        end
        echo -en "$MESSAGE\r"
        fish -c "shred $SHRED_ARGS '$file' || echo -e '$file\n' >> $FAILED_TMP_FILE" &
    end

    wait fish

    echo ""

    if test (count (cat $FAILED_TMP_FILE)) -gt 1
        echo "Could not shred all the files, there are errors."
        return 1
    end

    echo "Deleting dir $DIR"
    command rm $RM_ARGS "$DIR" || return 1
end
