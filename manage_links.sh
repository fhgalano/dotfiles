#!/bin/bash

ln -sfv "$PWD/alacritty" ~/.config/alacritty
ln -sfv "$PWD/.tmux.conf" ~/.tmux.conf
ln -sfv "$PWD/starship.toml" ~/.config/starship.toml

find . -type l | sed 's/\.\///g' > .gitignore

exit 0
