#!/bin/bash

# Wofi file browser

DIR="/home/bryan"
ENTRY="Home"

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

while [ "$ENTRY" != "" ]
do
  ENTRY=$( lsi "$DIR" | wofi --dmenu -i -p "$ENTRY" -c ~/.config/wofi/config -s ~/.config/wofi/style.css | sed 's/^[^a-zA-Z0-9\.~//]*//' )
  DIR=$DIR"/"$ENTRY
  if [ ! -d "$DIR" ]; then
    if [[ $ENTRY =~ \.(sh|c|js|txt|)$ ]]; then
      termite -e "vim $DIR" 2> /dev/null
      break
    elif [[ $ENTRY =~ \.(jpg|png|svg|webp)$ ]]; then
      feh $DIR 2> /dev/null
      break
    elif [[ $ENTRY =~ \.(pdf)$ ]]; then
      zathura $DIR 2> /dev/null
      break
    elif [[ $ENTRY == ".." ]]; then
      DIR=$( echo $DIR | sed 's/(\/[a-zA-Z0-9]){2}$//' )
      break
    elif [[ $ENTRY =~ ^[~]*/+ ]]; then
      DIR=$( echo $ENTRY | sed 's/~/\/home\/bryan/' )
    else
      xdg-open "$DIR" 2> /dev/null
      break
    fi
  fi
done

echo "$DIR"
