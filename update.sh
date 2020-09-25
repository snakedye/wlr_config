#!/bin/bash

set -euo pipefail

INSTALL=$(ls ./)
CONFIG=~/.config/

# Confirmation prompt
prompt () {
  echo -e "Do you want to $1 $2 (y/n)"
  read ans
}

# Update configuration files
for config in $INSTALL
do
  if [[ $config =~ ^[a-zA-Z0-9_]+\.[a-z]+$ || $config == "LICENSE" || $config == "wallpapers" ]]; then
    continue
  else
    ans=""
    prompt update $config
    while [ "$ans" != "n" ]
    do
      if [[ $ans == "y" ]]; then
        if [[ $config == "vimrc" || "$config" == "zshrc" ]] ; then
          cp ~/.$config ./$config
        else
          cp -r $CONFIG$config ./
        fi
        break
      fi
    echo "Done!"
    done
  echo ""
fi
done

# Success message
echo "Update finished!"
