function cb --description 'Copy data to local clipboard via OSC 52'
    read -z -l inp
    set -l data (echo -n "$inp" | base64 | tr -d '\n\r')
    printf "\033]52;c;%s\a" "$data"
end
