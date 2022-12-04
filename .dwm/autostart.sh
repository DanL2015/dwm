#!/bin/bash

black=#0f0f0f
green=#8aac8b
white=#cacaca
grey=#767676
blue0=#8a98ac
blue1=#a5b4cb;
cyan=#93c3c4
red=#ac8a8c
orange=#c6a679
purple=#8f8aac

function cpu() {
  printf "^c$black^ ^b$blue0^ "
  printf "^c$black^ ^b$blue1^ $(grep -o '^[^ ]*' /proc/loadavg)%%"
}

function vol() {
  printf "^c$black^ ^b$blue0^ "
  printf "^c$black^ ^b$blue1^ $(pamixer --get-volume)%%"
}

function mem() {
  printf "^c$black^ ^b$blue0^ "
  printf "^c$black^ ^b$blue1^ $(free -h | awk '/^Mem/ { print $3"/"$2 }' | sed s/i//g)"
}

function dat() {
  printf "^c$black^ ^b$blue0^ "
  printf "^c$black^ ^b$blue1^ $(date '+%a %b %d %g %I:%M %p')"
}

function bat() {
  printf "^c$black^ ^b$blue0^ "
  printf "^c$black^ ^b$blue1^ $(cat /sys/class/power_supply/BAT0/capacity)%%"
}

xfsettingsd &
killall -q dunst; dunst &
sh $HOME/.fehbg &

while true; do
  xsetroot -name " $(vol) $(cpu) $(mem) $(bat) $(dat) "
  sleep 15
done
