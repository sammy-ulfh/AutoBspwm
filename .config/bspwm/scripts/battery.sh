#!/bin/bash

BATTERY=$(upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}' | tr -d '%')

if [[ "$BATTERY" -gt "60" ]] && [[ "$BATTERY" -lt "101" ]]; then
  echo "%{F#1bbf3e}%{u-} $BATTERY%"
elif [[ "$BATTERY" -gt "30" ]] && [[ "$BATTERY" -lt "61" ]]; then
  echo "%{F#FCE300}%{u-} $BATTERY%"
elif [[ "$BATTERY" -gt "0" ]] && [[ "$BATTERY" -lt "31" ]]; then
  echo "%{F#FC2C00}%{u-} $BATTERY%"
else
  echo "%{F#0076FC}%{u-} ???"
fi
