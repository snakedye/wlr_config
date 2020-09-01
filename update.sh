# /bin/bash

# This is only meant to be used by me

set -euo pipefail

for config in 'sway' 'waybar' 'wofi' 'termite' 'rofi' 'nwg-launchers' 'mako' 'micro' 'vem'
do
	if [ "$config" == "micro" ]; then
		cp -r ~/.config/$config/bindings.json ./micro/
		cp -r ~/.config/$config/settings.json ./micro/
	else
		cp -r ~/.config/$config ./
	fi
done

cp ~/.vimrc ./

cp -r ~/wallpapers ./

echo "Directory updated!"
