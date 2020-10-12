#!/bin/bash

# Wofi file browser

DIR="/home/$USER"
ENTRY="Home"
EDITOR=micro
FM=ranger

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

menu () {
# 1: DIR; 2: ENTRY
  OPTIONS=$( printf "  Launch $2 \n  Edit in $EDITOR \n  Execute $2\n  Open directory in $FM \n  Delete $2" | wofi --dmenu -i -c ~/.config/wofi/config -s ~/.config/wofi/style.css | sed 's/^[^a-zA-Z0-9\.~//]*//' );
  if [[ $OPTIONS =~ ^Execute ]]; then
    $1/$2 2> /dev/null
  elif [[ $OPTIONS =~ ^Edit ]]; then
    termite -e "$EDITOR $1/$2" 
  elif [[ $OPTIONS =~ ^Launch ]]; then
    launcher $1 $2
  elif [[ $OPTIONS =~ ^Open ]]; then
    termite -e "$FM $1"
  elif [[ $OPTIONS =~ ^Delete ]]; then
    rm $1/$2 2> /dev/null
  else
    break
  fi
}

launcher () {
# 1: DIR; 2: ENTRY 
  if [ ! -d "$1" ]; then
    if [[ $2 =~ \.(jpg|png|svg|webp)$ ]]; then
      feh $1/$2
      break
    else
      xdg-open "$1/$2"
      break
    fi
  fi
}

while [ "$ENTRY" != "" ]
do
  ENTRY=$( lsi "$DIR" | wofi --dmenu -i -p "$ENTRY" -c ~/.config/wofi/config -s ~/.config/wofi/style.css | sed 's/^[^a-zA-Z0-9\.~//]*//' )
  if [ -f "$DIR/$ENTRY" ]; then
    menu $DIR $ENTRY
  elif [[ $ENTRY =~ \.\. && $DIR != "/" ]]; then
    DIR=$( echo $DIR | sed 's|[a-zA-Z0-9_\.-]*/*$||' )
  elif [[ $ENTRY =~ ^[~]*/+ ]]; then
    DIR=$( echo $ENTRY | sed 's/~/\/home\/bryan/' )
  else
    DIR=$DIR"/"$ENTRY
  fi
  echo "$ENTRY"
done

