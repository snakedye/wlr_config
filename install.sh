#!/bin/bash

set -euo pipefail

INSTALL=$(ls ./)
CONFIG=~/.config/
HOME=("wallpapers" "fonts")

# Confirmation prompt
prompt () {
  echo -e "Do you want to $1 $2 (y/n)"
  read ans
}

install () {
if [[ ! -f /usr/bin/"$1" ]]; then
  ans=""
  prompt install $1
  if [[ $ans == "y"  ]]; then
    if [[ ! -f /usr/bin/yay ]]; then
      sudo pacman -S yay
    fi
    if [[ $1 == "arc-theme" ]]; then
      if [[ ! -f /usr/bin/yay ]]; then
        sudo pacman -S sass
      fi
      cd arc-theme
      ./autogen.sh --prefix=$HOME/.local --disable-gnome-shell --disable-cinnamon --disable-plank --disable-unity --disable-xfwm
      make install
      cd ..
    else
      sudo yay -S "$1"
    fi
  fi
  echo ""
fi
}

for config in $INSTALL 
do
  if [[ $config =~ ^[a-zA-Z0-9]+\.[a-z]+$ || $config == "LICENSE" ]]; then
    continue
  elif [[ $config =~ "arc-theme" ]]; then
    install $config
    continue
  else
    ans=""
    prompt copy $config
    while [ "$ans" != "n" ]
    do
      if [[ $ans == "y" ]]; then
        if [[ " ${HOME[@]} " =~ " ${config} " ]]; then
          cp -r ./$config ~/
        elif [[ $config == "vimrc" || "$config" == "zshrc" ]] ; then
          cp ./$config ~/.$config
        else
          cp -r ./$config $CONFIG
          if [[ $config == "rofi"  ]]; then
            install rofi-lbonn-wayland
          else
            install $config
          fi
        fi
        break
      else
        prompt install $config
      fi
    echo "Done!"
  done
  echo ""
fi
done

# Success message
echo "Installation finished!"
