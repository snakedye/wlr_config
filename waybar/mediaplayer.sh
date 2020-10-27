#!/bin/sh

echo '{"text": "'$icon $(playerctl metadata artist) - $(playerctl metadata title)'", "tooltip": "'$(playerctl metadata title)'", "class": "'$(playerctl status)'" }' | sed -e 's/" - "/""/'
