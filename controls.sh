#/bin/bash
brightness=/sys/class/backlight/intel_backlight/brightness
maxBrightness=852
minBrightness=8

function brightness_adjust {
    #xrandr --output eDP-1 --brightness $1
    echo "Curr Brightness: " $(cat $brightness)
    curBrightness=$1
    if [ $curBrightness -lt $minBrightness ]
    then
        curBrightness=8
    elif [ $curBrightness -gt $maxBrightness ]
    then
        curBrightness=852
    fi
	 echo $curBrightness > $brightness
}
