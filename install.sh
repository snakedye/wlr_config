#!/bin/bash

set -euo pipefail

INSTALL=$(ls ./)
CONFIG=~/.config/

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
        if [[ $config == "arc-theme" || "$config" == "wallpapers" || "$config" == "fonts" ]]; then
          cp -r ./$config ~/
          break
        elif [[ $config =~ rc$ ]] ; then
          cp ./$config ~/.$config
          break
        else
          cp -r ./$config $CONFIG
          break
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
