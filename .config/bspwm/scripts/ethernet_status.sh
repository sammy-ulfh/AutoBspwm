#!/bin/sh

interface=$(ip route | grep -i "default" | grep -v "tun0" | awk '{print $5}' | sort -u)
num_interfaces=$(echo "$interface" | wc -l)

if [ "$(/sbin/ifconfig | grep -i "$interface" -A 1 | grep -i 'inet')" ] && [ "$interface" ]; then
  if [ "$num_interfaces" -gt 1 ]; then
    echo "%{F#00FF00}󱚸 %{F#ffffff} Multiple interfaces%{u-}"
  else
    echo "%{F#00FF00}󱚸 %{F#ffffff}$(/sbin/ifconfig | grep -i "$interface" -A 1 | grep -iw 'inet' | awk '{print $2}')%{u-}"
  fi  
else
  echo "%{F#FF0000}󰤭 %{F#ffffff} NO WIFI%{u-}"
fi
