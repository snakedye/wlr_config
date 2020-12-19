#!/bin/bash

if [ -z $(mpc current --host 127.0.0.1 --port 6002) ]; then
  playerctl play-pause
else
  mpc toggle --host 127.0.0.1 --port 6002
fi

