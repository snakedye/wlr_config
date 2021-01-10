#!/bin/bash

cd ~/Music

HOST=127.0.0.1

PORT=6002

TITLE=$(mpc current --host $HOST --port $PORT)

FILENAME="$(mpc --host $HOST --port $PORT current --format "%file%")"

OTHER=$(mpc --host $HOST --port $PORT current --format "%id%")

ffmpegthumbnailer -i "$FILENAME" -o /tmp/mpd_thumbnail.png 2> /dev/null

notify-send "$OTHER" "$TITLE" -i /tmp/mpd_thumbnail.png
