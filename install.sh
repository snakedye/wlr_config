#!/bin/bash

CONFIG=~/.config/
YES="y"
NO="n"
# Copy config files to .config folder

echo "The following directories are about to be move in ~/.config"
echo "termite"
echo "sway"
echo "waybar"
echo "wofi"
echo -e "Do you want to continue? (y/n)"
read ans
while [ "$ans" != "$YES" ]
do
if [ "$ans" == "$YES" ]; then
    echo "Moving directories"
    break
fi
if [ "$ans" == "$NO" ]; then
  exit
fi
echo -e "Please input your answer correctly (y/n)"
read ans
done

cp -r ./wallpapers ~/

cp -r ./termite $CONFIG

cp -r ./sway $CONFIG

cp -r ./waybar $CONFIG

cp -r ./wofi $CONFIG

echo "Done!"
