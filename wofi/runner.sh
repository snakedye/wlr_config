#!/bin/bash

# Wofi file browser

OUT="/home/bryan"
NAME="i"

while [ "$NAME" != "" ]
do
  NAME=$( ls "$OUT" | wofi --dmenu -c ~/.config/wofi/runner -s ~/.config/wofi/style.css )
  OUT=$OUT"/"$NAME
  if [ ! -d "$OUT" ]; then
    if [[ $NAME =~ \.(mp4|pdf)$ ]]; then
      xdg-open "$OUT" 2> /dev/null
      break
    elif [[ $NAME =~ \.(jpg|png|svg|webp)$ ]]; then
      feh $OUT 2> /dev/null
      break
    elif [[ $NAME =~ \.kra$ ]]; then
      krita $OUT 2> /dev/null
      break
    elif [[ $NAME =~ \.(docx|odt)$ ]]; then
      libreoffice $OUT 2> /dev/null
      break
    elif [[ $NAME == ".." ]]; then
      OUT=$( echo $OUT | sed 's/(\/[a-zA-Z0-9]){2}//' )
      break
    else
      termite -e "vim $OUT" 2> /dev/null
      break
    fi
  fi
done

echo "$OUT"
