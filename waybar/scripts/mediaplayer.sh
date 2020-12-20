#!/bin/bash

if [ -z $(pgrep ncmpcpp) ]; then
  playerctl play-pause
else
  mpc toggle --host 127.0.0.1 --port 6002
fi

