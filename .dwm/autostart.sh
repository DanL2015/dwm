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

function wifi() {
  wifi=`nmcli con show --active`
  if [[ -z "$wifi" ]]; then
    printf "^c$black^ ^b$blue0^ "
    printf "^c$black^ ^b$blue1^ No Connection"
  else
    printf "^c$black^ ^b$blue0^ "
    printf "^c$black^ ^b$blue1^ $(iwgetid -r)"
  fi
}

function cpu() {
  printf "^c$black^ ^b$blue0^ "
  printf "^c$black^ ^b$blue1^ $(grep -o '^[^ ]*' /proc/loadavg)%%"
}

function bri() {
  printf "^c$black^ ^b$blue0^ "
  printf "^c$black^ ^b$blue1^ $(xbacklight -get)%%"
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
  batVal=`cat /sys/class/power_supply/BAT0/capacity`
  batVal=$(($batVal/5))
  x=$((22-$batVal))
  w=$((batVal+2))
  printf "^c$blue0^^r0,0,100,26^^f5^^c$black^^r0,10,2,4^^r2,6,22,12^^c$blue0^^r4,8,18,8^^c$black^^r%s,7,%s,10^^f28^" "$x" "$w"
  printf "^c$black^ ^b$blue1^$(cat /sys/class/power_supply/BAT0/capacity)%%"
}

xfsettingsd &
killall -q dunst; dunst &
sh $HOME/.fehbg &

while true; do
  xsetroot -name " $(wifi) $(vol) $(bat) $(dat) "
  sleep 15
done
