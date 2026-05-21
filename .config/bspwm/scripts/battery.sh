#!/bin/bash

BATTERY=$(upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}' | tr -d '%')
STATE=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "state|to full|to empty|percentage" | head -n 1 | awk '{print $2}')


if [[ "$BATTERY" -gt "60" ]] && [[ "$BATTERY" -lt "101" ]]; then
  if [[ "$STATE" == "charging" ]]; then
    echo "%{F#1bbf3e}󱐋%{u-} $BATTERY%"
  else
    echo "%{F#1bbf3e}%{u-} $BATTERY%"
  fi
elif [[ "$BATTERY" -gt "30" ]] && [[ "$BATTERY" -lt "61" ]]; then
  if [[ "$STATE" == "charging" ]]; then
    echo "%{F#FCE300}󱐋%{u-} $BATTERY%"
  else
    echo "%{F#FCE300}%{u-} $BATTERY%"
  fi
elif [[ "$BATTERY" -gt "0" ]] && [[ "$BATTERY" -lt "31" ]]; then
  if [[ "$STATE" == "charging" ]]; then
    echo "%{F#FC2C00}󱐋%{u-} $BATTERY%"
  else
    echo "%{F#FC2C00}%{u-} $BATTERY%"
  fi
else
  echo "%{F#0076FC}%{u-} ???"
fi
