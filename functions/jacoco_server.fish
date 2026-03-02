function jacoco_server
    set -l JACOCO_FOLDER "$(pwd)/target/site/jacoco"
    cd $JACOCO_FOLDER || exit 1
    python -m http.server 8085
    cd -
end
