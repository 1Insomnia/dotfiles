#!/bin/bash

menu="$1"

if [ "$menu" = "music" ]; then
    rofi -modi 'Music:~/Scripts/rofi/rofi-music.sh' -show Music -theme music
elif [ "$menu" = "drun" ]; then
    rofi -show drun -theme clean
elif [ "$menu" = "powermenu" ]; then
    rofi -modi 'Powermenu:~/Scripts/rofi/rofi-powermenu.sh' -show Powermenu -theme powermenu
elif [ "$menu" = "battery" ]; then
    rofi -modi 'Battery:~/Scripts/rofi/powermenu.sh' -show battery -theme battery
fi
