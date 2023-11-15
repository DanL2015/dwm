#!/bin/bash

function media() {
	status=`playerctl status`
	if [[ -z "$status" ]]; then
		printf "MEDIA: NO PLAYERS"
	else
		metadata=`playerctl metadata --format '{{artist}} - {{title}}'`
		printf "${status^^}: ${metadata^^}"
	fi
}

function wifi() {
  wifi=`nmcli -t -f active,ssid dev wifi | grep -E '^yes' | cut -d\' -f2 | cut -b 5-`
  printf "WIFI: "
  if [[ -z "$wifi" ]]; then
	  printf "DISCONNECTED"
  else
	  printf "${wifi^^}"
  fi
}

function cpu() {
  printf "CPU: $(grep -o '^[^ ]*' /proc/loadavg)%%"
}

function bri() {
  printf "BRIGHT: $(xbacklight -get)%%"
}

function vol() {
  printf "VOL: $(pamixer --get-volume)%%"
}

function mem() {
  printf "MEM: $(free -h | awk '/^Mem/ { print $3"/"$2 }' | sed s/i//g)"
}

function dat() {
  printf "DATE: $(date '+%b %d, %I:%M %p')"
}

function bat() {
  printf "BAT: $(cat /sys/class/power_supply/BAT0/capacity)%%"
}

xfsettingsd &
xsetroot -solid "#1d1f21"

while true; do
	xsetroot -name " [$(media)] [$(cpu)] [$(mem)] [$(vol)] [$(wifi)] [$(bat)] [$(dat)] "
  sleep 5
done
