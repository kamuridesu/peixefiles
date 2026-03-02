if test -f "$HOME/.cargo/env.fish"
	source "$HOME/.cargo/env.fish"
end

source "$HOME/.local/bin/env.fish"

fish_add_path "$HOME/.local/bin"
