# /bin/bash

set -euo pipefail

CONFIG=~/.config/
YES="y"
NO="n"
# Copy config files to .config folder
# DIRECTORIES=('sway', 'waybar', 'wofi', 'termite')

# echo "Directories will be added to ~/.config"

echo ""

for config in 'sway' 'waybar' 'wofi' 'termite' 'rofi' 'mako' 'micro'
do
	echo -e "Do you want to copy ${config}?"
	select ans in y n; do
		if [ "$ans" == "$YES" ]; then
			echo "Copying directory"
			cp -r ./$config $CONFIG
			echo "Done"
			echo ""
			break
		elif [ "$ans" == "$NO" ]; then
			break
		fi
	done
	# continue
done

echo ""


echo "Installation finished!"
