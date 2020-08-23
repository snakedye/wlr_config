#!/bin/sh
# Times the screen off and puts it to background
swayidle \
    timeout  'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' &
# Locks the screen immediately
swaylock --clock --indicator -i ~/wallpapers/guitar.jpg --effect-scale 0.4 --effect-vignette 0.2:0.5 --effect-blur 4x2 --datestr "%a %e %m %Y" --timestr "%k:%M" --indicator --indicator-radius 100 --ring-color 4b5162 --ring-ver-color 5e81ac --ring-clear-color 5e81ac --ring-wrong-color 7c818c --separator-color 5e81ac --key-hl-color 5e81ac --bs-hl-color 383c4a --font SanFranciscoText --text-color 7c818c -r
# Kills last background task so idle timer doesn't keep running
kill %%
