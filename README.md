# Peixefiles

My configs for pexe (https://fishshell.com/)

## Features

- Using fisher to manage some plugins (mainly nvm and sdkman)
- Some helper functions such as tf to notify when opentofu commands finishes
- Autoload for envs, such as using pinned java version from sdkman
- Double bang to load previous commands
- Hosname-based custom configs to use the same confs in different machines

## Commands

### Abbr

- ga: git add
- gaa: git add .
- gb: git branch
- gbD: git branch -D
- gba: git branch -a
- gbd: git branch -d
- gc: git commit
- gcb: git checkout -b
- gcn!: git commit -v --no-edit --amend
- gco: git checkout
- gp: git push

### Functions

- ggl: git pull origin (git branch --show-current)
- tf: tofu and notify-send
- shredir: shred and delete files recursively 
