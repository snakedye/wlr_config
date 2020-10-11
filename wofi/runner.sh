#!/bin/bash

# Wofi file browser

OUT="/home/bryan"
NAME="Home"

while [ "$NAME" != "" ]
do
  NAME=$( ls "$OUT" | wofi --dmenu -i -p "$NAME" -c ~/.config/wofi/config -s ~/.config/wofi/style.css )
  OUT=$OUT"/"$NAME
  if [ ! -d "$OUT" ]; then
    if [[ $NAME =~ \.(sh|c|js|txt|)$ ]]; then
      termite -e "vim $OUT" 2> /dev/null
      break
    elif [[ $NAME =~ \.(jpg|png|svg|webp)$ ]]; then
      feh $OUT 2> /dev/null
      break
    elif [[ $NAME == ".." ]]; then
      OUT=$( echo $OUT | sed 's/(\/[a-zA-Z0-9]){2}//' )
      break
    elif [[ $NAME =~ ^[~]*/+ ]]; then
      OUT=$( echo $NAME | sed 's/~/\/home\/bryan/' )
    else
      xdg-open "$OUT" 2> /dev/null
      break
    fi
  fi
done

echo "$OUT"
