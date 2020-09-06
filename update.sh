#!/bin/bash

# This is only meant to be used by me

set -euo pipefail

CONFIG=$(ls ~/sway_config)

for dir in $CONFIG
do
  if [[ "$dir" == "wallpapers" || "$dir" == "rofi-spotlight" ]]; then
    echo "Update ${dir}"
    cp -r ~/$dir ./
  elif [[ "$dir" == "install.sh" || "$dir" == "update.sh" || "$dir" == "LICENSE" || "$dir" == "screenshot.png" || "$dir" == "README.md" || "$dir" == "micro" ]]; then
    continue
  else
    echo "Update ${dir}"
    cp -r ~/.config/$dir ./
  fi
done

echo ""
echo "Directory updated!"
echo ""

# Push to Github

git add ./

git commit -m update

git push
