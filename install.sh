#!/bin/sh

set -euo pipefail

# Confirmation prompt
prompt () {
  echo -e "Do you want to $1 $2 (y/n)"
  read ans
}

# Pacman
install () {
  if [ -n $(pacman -Q | grep "$1") ] ; then
  ans=""
  if [[ $ans == "y"  ]]; then
    if pacman -Q | grep yay; then
    sudo pacman -S yay
    fi
    if yay -S $1; then
    	break
    fi
  fi
fi
}

# Installing configuration files
for config in $(ls -A ./)
do
  if [[ $config =~ ^.+\.[a-z]+$|.git || $config == "LICENSE" ]]; then
    continue
  else
    ans=""
    if [[ $1 != 'y' ]]; then
      prompt copy $config
    else
      ans="y"
    fi
    if [[ $ans == "y" ]]; then
      case $config in
        .vimrc | .zshrc | .azotebg)
          cp ./$config ~/
          ;;
        wallpapers)
          cp -r ./$config ~/
          ;;
        *)
          cp -r ./$config ~/.config/
          ;;
      esac
      install $config
    fi
    echo "Done!"
    echo ""
fi
done

# Extra packages
echo "Optionnal but recommended"

for pkg in "azote" "qt5ct" "grim" "slurp" "swappy" "brightnessctl"
  "otf-font-awesome" "kdeconnect" "ttf-nerd-fonts-symbols" "autotiling" "fish"
do
  echo ""
  if ! install $pkg; then
    continue
  fi
done

# Success message
echo "Installation finished!"
