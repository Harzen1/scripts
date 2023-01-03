#!/bin/bash
cd $HOME/Scripts/
script=$(printf '%s\n' $(ls) | rofi -dmenu -i -p "Run: ")
./$script
