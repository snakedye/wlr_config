#!/bin/bash

# This is only meant to be used by me

set -euo pipefail

CONFIG=$(ls ~/sway_config)

for dir in $CONFIG
do
  if [[ "$dir" == "wallpapers" || "$dir" == "rofi-spotlight" ]]; then
    # cp -r ~/$dir ./
    echo "Update ${dir}"
    echo ""
    break
#   elif [[ "$dir" == "install.sh" || "$dir" == "update.sh" || "$dir" == "LICENSE" || "$dir" == "screenshot.png" "$dir" == "README.md" ]]; then
    # echo "Update ${dir}"
    # echo ""
#     break
  else
    echo "Update ${dir}"
	  # cp -r ~/.config/$config ./
    break
  fi
done

# cp ~/.vimrc ./

# cp -r ~/wallpapers ./

# cp -r ~/rofi-spotlight ./

# Push to Github

git add ./

git commit -m update

git push

echo "Directory updated!"
