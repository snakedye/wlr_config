#!/bin/bash

set -euo pipefail

AUTOMATIC="$1"

# Confirmation prompt
prompt () {
  echo -e "Do you want to $1 $2 (y/n)"
  read ans
}

# Pacman
install () {
if [[ ! -f /usr/bin/"$1" ]]; then
  ans=""
  prompt install $1
  if [[ $ans == "y"  ]]; then
    if [[ ! -f /usr/bin/yay ]]; then
    sudo pacman -S yay
    fi
    if yay -S $1; then
    	break
    fi
  fi
  echo ""
fi
}

# Installing configuration files
for config in $(ls -A ./)
do
  if [[ $config =~ ^.+\.[a-z]+$|.git || $config == "LICENSE" ]]; then
    continue
  else
    ans=""
    if [[ $AUTOMATIC != 'y' ]]; then
      prompt copy $config
    else
      ans="y"
    fi
    while [ "$ans" != "n" ]
    do
      if [[ $ans == "y" ]]; then
        case $config in
          .vimrc | .zshrc | wallpapers)
            cp ./$config ~/
            ;;
          *)
            cp -r ./$config ~/.config/
            ;;
        esac
        prompt install $config
      fi
    echo "Done!\n"
    done
fi
done

# Extra packages
echo "Optionnal but recommended"
echo ""

for pkg in "azote" "qt5ct" "grim" "slurp" "swappy" "brightnessctl" "otf-font-awesome" "kdeconnect" "ttf-nerd-fonts-symbols" "autotiling"
do
  if ! install $pkg; then
    continue
  fi
done

# Success message
echo "Installation finished!"
