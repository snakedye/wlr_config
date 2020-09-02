# /bin/bash

# This is only meant to be used by me

set -euo pipefail

for config in 'sway' 'waybar' 'wofi' 'termite' 'rofi' 'nwg-launchers' 'mako' 'swaylock'
do
	cp -r ~/.config/$config ./
done

cp ~/.vimrc ./

cp -r ~/wallpapers ./

echo "Directory updated!"
