#!/bin/bash

# Wofi file browser

OUT="/home/bryan"
NAME="Home"

lsi () {
  echo ".."
  ls "$1" | while read entry; do
    if [ -d "$1/$entry" ]; then
      echo "  $entry"
    elif [[ $entry =~ \.(sh|c|js|txt|)$ ]]; then
      echo "  $entry"
    elif [[ $entry =~ \.(jpg|png|svg|webp)$ ]]; then
      echo "  $entry"
    elif [[ $entry =~ \.mp4$ ]]; then
      echo "  $entry"
    elif [[ $entry =~ \.mp3$ ]]; then
      echo "  $entry"
    elif [[ $entry =~ \.(pdf)$ ]]; then
      echo "  $entry"
    else
      echo "  $entry"
    fi
  done
}

while [ "$NAME" != "" ]
do
  NAME=$( lsi "$OUT" | wofi --dmenu -i -p "$NAME" -c ~/.config/wofi/config -s ~/.config/wofi/style.css | sed 's/^[^a-zA-Z0-9\.~//]*//' )
  OUT=$OUT"/"$NAME
  if [ ! -d "$OUT" ]; then
    if [[ $NAME =~ \.(sh|c|js|txt|)$ ]]; then
      termite -e "vim $OUT" 2> /dev/null
      break
    elif [[ $NAME =~ \.(jpg|png|svg|webp)$ ]]; then
      feh $OUT 2> /dev/null
      break
    elif [[ $NAME =~ \.(pdf)$ ]]; then
      zathura $OUT 2> /dev/null
      break
    elif [[ $NAME == ".." ]]; then
      OUT=$( echo $OUT | sed 's/(\/[a-zA-Z0-9]){2}$//' )
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
