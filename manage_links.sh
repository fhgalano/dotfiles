#!/bin/bash

# color constants
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# functions
create_symlink() {
    sleep 1
    echo -n " creating symlink .... "
    sleep 1

    if [ -f $2 ] | [ -d $2 ]
    then
        echo -e "${YELLOW}IGNORED${NC}"
    else
        echo -e "${GREEN}CREATING${NC}"
        # link symbolic, force, verbose
        ln -sfv $1 $2
    fi
}

# alacritty 
echo "== ALACRITTY =="
echo -n " checking for alacritty install ...."
sleep 1
if [ $(which alacritty) ]
then
    echo -e "${GREEN}INSTALLED${NC}"
    create_symlink "$PWD/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
else
    echo "${RED}NOT INSTALLED${NC}"
fi
sleep 1

# tmux
echo "== TMUX =="
echo -n " checking for tmux instal .... "
sleep 1
if [ $(which tmux) ]
then
    echo -e "${GREEN}INSTALLED${NC}"
    create_symlink "$PWD/.tmux.conf" ~/.tmux.conf
else
    echo -e "${RED}NOT INSTALLED${NC}"
fi

# starship
echo "== STARSHIP =="
echo -n " checking for starship install .... "
sleep 1
if [ $(which starship) ]
then
    echo -e "${GREEN}INSTALLED${NC}"
    create_symlink "$PWD/starship.toml" ~/.config/starship.toml

    echo -n " checking default shell .... "
    if [[ $SHELL == *"bash"* ]] 
    then
        echo -e "${GREEN}BASH${NC}"
        echo -n " checking config.... "
        grep starship ~/.bashrc >> /dev/null
        if [ $? -gt 0 ]
        then
            printf "eval \"\$(starship init bash)\"" >> ~/.bashrc
            echo -e "${GREEN}added starship to .bashrc${NC}"
        else
            echo -e "${YELLOW}STARTUP COMMAND ALREADY INSTALLED${NC}"
        fi
    fi
else
    echo -e "${RED}NOT INSTALLED${NC}"
fi


# neofetch
echo "== NEOFETCH =="
echo -n " checking for neofetch install .... "
sleep 1
if [ $(which neofetch) ]
then
    echo -e "${GREEN}INSTALLED${NC}"
    create_symlink "$PWD/neofetch_config.conf" ~/.config/neofetch/config.conf
else
    echo -e "${RED}NOT INSTALLED${NC}"
fi


# Adds all symlinks to the .gitignore
find . -type l | sed 's/\.\///g' > .gitignore

exit 0
