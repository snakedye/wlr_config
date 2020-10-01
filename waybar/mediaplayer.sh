#!/bin/sh
player_status=$(playerctl status 2> /dev/null)
PLAYERCTL=$(echo "$(playerctl metadata artist) - $(playerctl metadata title)")
if [ "$player_status" = "Playing" ]; then
	echo '{"text": " '$PLAYERCTL'", "tooltip": "'$PLAYERCTL'", "class": "playing" }'
elif [ "$player_status" = "Paused" ]; then
	echo '{"text": " '$PLAYERCTL'", "tooltip": "'$PLAYERCTL'", "class": "paused" }'
fi
