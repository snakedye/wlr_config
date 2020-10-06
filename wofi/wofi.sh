#!/bin/bash

set -euo pipefail

if [ $XDG_CURRENT_DESKTOP == "wayfire" ]; then
	wofi -s ~/.config/wofi/wayfire.css -c ~/.config/wofi/menu -I
elif [ $XDG_CURRENT_DESKTOP == "sway" ]; then
	wofi -s ~/.config/wofi/sway.css -c ~/.config/wofi/menu -I
else
  wofi -c ~/.config/wofi/menu
fi
