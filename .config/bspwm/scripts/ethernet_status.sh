#!/bin/sh

if [ "$(hostname -I)" ]; then
  echo "%{F#00FF00}󱚸 %{F#ffffff}$(hostname -I | awk '{print $1}')%{u-}"
else
  echo "%{F#FF0000}󰤭 %{F#ffffff} NO WIFI%{u-}"
fi
