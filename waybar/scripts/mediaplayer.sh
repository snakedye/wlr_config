#!/bin/bash

if ! pgrep ncmpcpp; then
  exit 0
else
  exit 1
fi

