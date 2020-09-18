#!/bin/bash

set -euo pipefail

INSTALL=$(ls ./)
CONFIG=~/.config/

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
    if [[ $1 == "arc-theme" ]]; then
      if [[ ! -f /usr/bin/sass ]]; then
        sudo pacman -S sass
      fi
      cd arc-theme
      ./autogen.sh --prefix=$HOME/.local --disable-gnome-shell --disable-cinnamon --disable-plank --disable-unity --disable-xfwm
      make install
      cd ..
    else
      yay -S $1
    fi
  fi
  echo ""
fi
}

# Installing configuration files
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
        if [[ $config == "vimrc" || "$config" == "zshrc" ]] ; then
          cp ./$config ~/.$config
        else
          cp -r ./$config $CONFIG
          if [[ $config == "rofi"  ]]; then
            install rofi-lbonn-wayland
            break
          elif [[ $config == "swaylock"  ]]; then
            install swaylock-effects
            break
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

# Extra packages

echo "Optionnal but recommended"
echo ""
for pkg in "azote" "qt5ct" "grim" "slurp" "swappy" "brightnessctl" "otf-font-awesome" "kdeconnect" "ttf-nerd-fonts" "autotiling"
do
  if ! install $pkg; then
    continue
  fi
done

# Success message
echo "Installation finished!"
