#!/bin/sh
scripts="dock-dvi-left\nintern-fhd\nintern"
#prompt="Which xrandr script to run?"
chosen=$(echo -e $scripts | dmenu -i)
path="/home/curankar/.screenlayout/"
if [ $chosen != "" ]; then
	sh $path$chosen
fi
