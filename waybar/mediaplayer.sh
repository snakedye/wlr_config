#!/bin/sh

echo '{"text": "'$(playerctl metadata artist) - $(playerctl metadata title)'", "tooltip": "'$(playerctl metadata title)'", "class": "'$(playerctl status)'" }' | sed -e 's/" - "/""/'
