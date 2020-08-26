# /bin/bash

set -euo pipefail

CONFIG=~/.config/
YES="y"
NO="n"

echo ""

for config in 'sway' 'wallapers' 'waybar' 'wofi' 'termite' 'rofi' 'mako' 'micro' 
do
	echo -e "Do you want to copy ${config}?"
	select ans in y n; do
		if [ "$ans" == "$YES" ]; then
			if [ "$config" == "wallpapers"]; then
				echo "Copying ${config} to Home"
				# cp -r ./$config ~/
				echo "Done"
				echo ""
				break
			else
				echo "Copying ${config} to ${CONFIG}"
				# cp -r ./$config $CONFIG
				echo "Done"
				echo ""
				break
			fi
		elif [ "$ans" == "$NO" ]; then
			break
		fi
	done
	# continue
done

echo ""


echo "Installation finished!"
