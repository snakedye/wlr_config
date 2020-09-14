#!/bin/bash

set -euo pipefail

INSTALL=$(ls ./)
CONFIG=~/.config/
HOME=("arc-theme" "wallpapers" "fonts")

install () {
if [[ ! -f /usr/bin/"$1" ]]; then
  echo -e "Do you want to install "$config" (y/n)"
  read ans
  if [[ $ans == "y"  ]]; then
    if [[ ! -f /usr/bin/yay ]]; then
      sudo pacman -S yay
    fi
    yay -S "$1"
    break
  fi
fi
}

for config in $INSTALL 
do
  if [[ $config =~ ^[a-zA-Z0-9]+\.[a-z]+$ || $config == "LICENSE" ]] ; then
    continue
  else
    echo -e "Do you want to copy "$config" (y/n)"
    read ans
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
        echo -e "Do you want to copy "$config" (y/n)"
        read ans
      fi
    echo "Done!"
  done
  echo ""
fi
done


echo "Installation finished!"
