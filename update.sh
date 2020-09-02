# /bin/bash

# This is only meant to be used by me

set -euo pipefail

for config in 'sway' 'waybar' 'wofi' 'termite' 'rofi' 'nwg-launchers' 'mako' 'swaylock'
do
	cp -r ~/.config/$config ./
done

cp ~/.vimrc ./

cp -r ~/wallpapers ./

# Push to Github

git add ./

git commit -m update

git push

echo "Directory updated!"
