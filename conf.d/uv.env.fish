if test -f "$HOME/.cargo/env.fish"
	source "$HOME/.cargo/env.fish"
end

if test -f "$HOME/.local/bin/env.fish"
    source "$HOME/.local/bin/env.fish"
end

if test -d "$HOME/.local/bin"
    fish_add_path "$HOME/.local/bin"
end
