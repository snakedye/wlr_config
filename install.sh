#!/bin/sh

set -euo pipefail

if [ -z $@ ]; then
  QUICK_INSTALL=n
else
  QUICK_INSTALL=$@
fi

# Confirmation prompt
prompt () {
  echo -e "Do you want to $1 $2 (y/n)"
  read ans
}

# Pacman
install () {
  if [[ -n $(pacman -Q | grep "$1") ]] ; then
  ans=""
  if [[ $ans == "y"  ]]; then
    if [[ -n $(pacman -Q | grep "$1") ]]; then
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
    if [[ $QUICK_INSTALL != 'y' ]]; then
      prompt copy $config
    else
      ans="y"
    fi
    if [[ $ans == "y" ]]; then
      case $config in
        .vimrc | .zshrc | .azotebg | wallpapers )
          ln ./$config ~/
          ;;
        *)
          ln ./$config ~/.config/
          ;;
      esac
      install $config
    fi
    echo ""
fi
done

# Extra packages
echo "Optionnal but recommended"

for pkg in "azote" "qt5ct" "grim" "slurp" "swappy" "wf-recorder" "brightnessctl" "otf-font-awesome" "ttf-nerd-fonts-symbols" "autotiling" "fish"

do
  if ! install $pkg; then
    continue
  fi
done

# Success message
echo "Installation finished!"
