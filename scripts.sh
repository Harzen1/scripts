#!/bin/bash
cd $HOME/scripts/
sh=$(ls | grep /*.sh)
script=$(printf '%s\n' $sh | rofi -dmenu -i -p "Run: ")
if [[ -z "$script" ]];then
  exit 0
else
  ./$script
fi
