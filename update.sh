# /bin/bash

set -euo pipefail

for config in 'sway' 'waybar' 'wofi' 'termite' 'rofi' 'mako' 'micro'
do
	cp -r ~/.config/$config ./
done

echo ""

echo "Directory updated!"
