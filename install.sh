# /bin/bash

set -euo pipefail

CONFIG=~/.config/
YES="yes"
NO="no"

echo ""

for config in 'sway' 'swaylock' 'wallapers' 'waybar' 'wofi' 'termite' 'nwg-launchers' 'rofi' 'mako' 'micro' '.vimrc'
do
	echo -e "Do you want to copy ${config}?"
	select ans in yes no; do
		if [ "$ans" == "$YES" ]; then
			if [ "$config" == "wallpapers" ]; then
				echo "Copying ${config} to Home"
				cp -r ./$config ~/
				echo "Done"
				echo ""
				break
			elif [ "$config" == ".vimrc" ]; then
        echo "Copying ${config} to Home"
        cp $config ~/
        echo "Done"
        echo ""
        break
      else
				echo "Copying ${config} to ${CONFIG}"
        cp -r ./$config $CONFIG
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
