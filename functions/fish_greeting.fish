function fish_greeting -d "What's up, fish?"
    set_color $fish_color_autosuggestion
    uname -nmsr
    echo "Total running containers: $(math $(docker ps | wc -l) - 1)"

    command -q uptime
    and command uptime

    set_color normal
end
