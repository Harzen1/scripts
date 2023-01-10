#!/bin/bash
id="991002"
if [ "$1" == "up" ];then
  pamixer -i 3
elif [ "$1" == "down" ];then
  pamixer -d 3
fi
volume=$(pamixer --get-volume)
notify-send -r "$id" "Volume: $volume""%"
