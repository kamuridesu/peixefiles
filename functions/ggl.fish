function ggl --wraps='git pull origin (git branch --show-current)' --description 'alias ggl=git pull origin (git branch --show-current)'
  git pull origin (git branch --show-current) $argv; 
end
