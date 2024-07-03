#!/bin/bash

# alacritty 
if [ $(which alacritty) ]
then
    ln -sfv "$PWD/alacritty" ~/.config/alacritty
else
    echo "alacritty not installed"
fi

# tmux
if [ $(which tmux) ]
then
    ln -sfv "$PWD/.tmux.conf" ~/.tmux.conf
else
    echo "tmux not installed"
fi

# starship
if [ $(which starship) ]
then
    ln -sfv "$PWD/starship.toml" ~/.config/starship.toml

    if [ $SHELL = "/bin/bash" ]
    then
        echo "default shell is bash"
        echo -n "  checking config..."
        grep starship ~/.bashrc >> /dev/null
        if [ $? -gt 0 ]
        then
            printf "eval \"\$(starship init bash)\"" >> ~/.bashrc
            echo "added starship to .bashrc"
        else
            echo "Ok"
        fi
    fi
else
    echo "starship not installed"
fi


find . -type l | sed 's/\.\///g' > .gitignore

exit 0
