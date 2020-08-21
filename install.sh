#!/bin/bash

CONFIG=~/.config/
YES="y"
NO="n"
# Copy config files to .config folder

echo "Directories will be added to ~/.config"

echo ""

# SWAY
echo -e "Do you want to copy ./sway? (y/n)"
read ans
while [ "$ans" != "$YES" ]
do
if [ "$ans" == "$YES" ]; then
    echo "Copying directory"
	cp -r ./sway $CONFIG
	cp -r ./wallpapers ~/
	echo "Done"
    break
fi
if [ "$ans" == "$NO" ]; then
  break
fi
echo -e "Please input your answer correctly (y/n)"
read ans
done

# WAYBAR
echo -e "Do you want to copy ./waybar? (y/n)"
read ans
while [ "$ans" != "$YES" ]
do
if [ "$ans" == "$YES" ]; then
    echo "Copying directory"
	cp -r ./waybar $CONFIG
	echo "Done"
    break
fi
if [ "$ans" == "$NO" ]; then
  break
fi
echo -e "Please input your answer correctly (y/n)"
read ans
done

# WOFI
echo -e "Do you want to copy ./wofi? (y/n)"
read ans
while [ "$ans" != "$YES" ]
do
if [ "$ans" == "$YES" ]; then
    echo "Copying directory"
	cp -r ./wofi $CONFIG
	echo "Done"
    break
fi
if [ "$ans" == "$NO" ]; then
  break
fi
echo -e "Please input your answer correctly (y/n)"
read ans
done

# TERMITE
echo -e "Do you want to copy ./termite? (y/n)"
read ans
while [ "$ans" != "$YES" ]
do
if [ "$ans" == "$YES" ]; then
    echo "Copying directory"
	cp -r ./termite $CONFIG
	echo "Done"
    break
fi
if [ "$ans" == "$NO" ]; then
  break
fi
echo -e "Please input your answer correctly (y/n)"
read ans
done

echo ""


echo "Installation finished!"
