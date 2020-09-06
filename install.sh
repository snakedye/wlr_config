#!/bin/bash

set -euo pipefail

CONFIG=~/.config/
YES="yes"
NO="no"

echo ""

for config in 'sway' 'swaylock' 'wallpapers' 'waybar' 'wofi' 'termite' 'nwg-launchers' 'rofi' 'rofi-spotlight' 'mako' 'micro' '.vimrc'
do
	echo -e "Do you want to copy ${config}?"
	select ans in yes no; do
		if [ "$ans" == "$YES" ]; then
			if [[ "$config" == "wallpapers" || "$config" == "rofi-spotlight" || "$config" == ".vimrc" ]]; then
				echo "Copying ${config} to Home"
        if [ "$config" == ".vimrc"  ]; then
          cp $config ~/
        else
				  cp -r ./$config ~/
        fi
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
