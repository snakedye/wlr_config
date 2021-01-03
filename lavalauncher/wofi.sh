#!/bin/bash

if ! killall wofi; then
  wofi -c ~/.config/wofi/bar
fi

