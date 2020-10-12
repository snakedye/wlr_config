#!/bin/bash

# Wofi file browser

DIR="/home/$USER"
ENTRY="Home"
EDITOR=vim
FM=dolphin

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
  echo "漣  Options"
}

prompt () {
  if [[ "$3" == "-r"  ]]; then
    echo "  Open directory in $FM "
    echo "  Copy $1"
    echo "  Move $1"
    echo "  Delete $1"
  else
    echo "  Launch $2"
    echo "  Edit $2 in $EDITOR"
    echo "  Copy $2"
    echo "  Move $2"
    echo "  Delete $2"
  fi
}

menu () {
# 1: DIR; 2: ENTRY; 3: -r
  OPTIONS=$( prompt $1 $2 $3\
  			| wofi --dmenu -i -c ~/.config/wofi/config -s ~/.config/wofi/style.css | sed 's/^[^a-zA-Z0-9\.~//]*//' );
  LOC=""
  if [[ "$3" == "-r" ]]; then
    LOC="$3 $1"
  else
    LOC="$1/$2"
  fi
  if [[ $OPTIONS =~ ^Execute ]]; then
    $LOC 2> /dev/null
    exit
  elif [[ $OPTIONS =~ ^Edit ]]; then
    echo "$EDITOR $LOC"
    exit
  elif [[ $OPTIONS =~ ^Launch ]]; then
    launcher "$1" "$2"
    exit
  elif [[ $OPTIONS =~ ^Open ]]; then
    $FM $1
    exit
  elif [[ $OPTIONS =~ ^Copy ]]; then
    DESTINATION=$( echo "  Enter the full path to the directory" | wofi --dmenu -i -p "$ENTRY" -c ~/.config/wofi/config -s ~/.config/wofi/style.css \
    | sed 's/~/\/home\/$USER/' )
    cp $LOC $DESTINATION 
  elif [[ $OPTIONS =~ ^Move ]]; then
    DESTINATION=$( echo "  Enter the full path to the directory" | wofi --dmenu -i -p "$ENTRY" -c ~/.config/wofi/config -s ~/.config/wofi/style.css \
    | sed 's/~/\/home\/$USER/' )
    mv $LOC $DESTINATION 
  elif [[ $OPTIONS =~ ^Delete ]]; then
    rm $LOC 2> /dev/null
  else
    :
  fi
}

launcher () {
# 1: DIR; 2: ENTRY 
  if [[ $2 =~ \.(jpg|jpeg|png|svg|webp)$ ]]; then
    feh "$1/$2"
    break
  else
    xdg-open "$1/$2"
    break
  fi
}

while [ "$ENTRY" != "" ]
do
  ENTRY=$( lsi "$DIR" | wofi --dmenu -i -p "$ENTRY" -c ~/.config/wofi/config -s ~/.config/wofi/style.css | sed 's/^[^a-zA-Z0-9\.~//]*//' )
  if [ -f "$DIR/$ENTRY" ]; then
    menu "$DIR" "$ENTRY"
  elif [[ $ENTRY =~ ^Options ]]; then
    menu "$DIR" "$ENTRY" "-r"
  elif [[ $ENTRY =~ \.\. && $DIR != "/" ]]; then
    DIR=$( echo $DIR | sed 's|[a-zA-Z0-9_\.-]*/*$||' )
  elif [[ $ENTRY =~ ^[~]*/+ ]]; then
    DIR=$( echo $ENTRY | sed 's/~/\/home\/bryan/' )
  else
    DIR=$DIR"/"$ENTRY
  fi
  echo "$ENTRY"
done

