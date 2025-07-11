function shredir --description "Wraps shred to delete dirs and shred files"
    argparse f/force -- $argv

    set -l DIR "$argv"
    if test -z "$DIR"
        echo "Usage: shredir path/to/dir"
        exit 1
    end

    set -l RM rm -r
    set -l SHRED shred --zero --iterations=10 -u --random-source=/dev/urandom 
    if set -q _flag_force
        echo "Warning: All commands will force removed"
        set RM "$RM -f"
        set SHRED "$SHRED -f"
    end

    set -l FILES (find $DIR -type f)
    if test ! $status -eq 0
        exit $status
    end

    for file in $FILES
        echo "Shreding file $file"
        eval $SHRED $file || exit 1
    end

    echo "Deleting dir $DIR"
    eval $RM $DIR || exit 1
end
