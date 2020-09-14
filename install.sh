#!/bin/bash

set -euo pipefail

INSTALL=$(ls ./)
CONFIG=~/.config/
HOME=("arc-theme" "wallpapers" "fonts")

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
          break
        elif [[ $config == "vimrc" || "$config" == "zshrc" ]] ; then
          cp ./$config ~/.$config
          break
        else
          cp -r ./$config $CONFIG
          break
        fi
        if [[ ! -f /usr/bin/$config && -d ~/.config/$config ]]; then
          echo -e "Do you want to install "$config" (y/n)"
          read ans
          if [[ $ans == "yes"  ]]; then
            yay $config
          fi
        fi
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
