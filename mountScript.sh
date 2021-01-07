#!/bin/sh
FSs=$(ls /dev | grep -E 'sd[a-z][0-9]|nvme[0-9]n[0-9]p[0-9]')
toMount=$(echo -e "$FSs" | dmenu)
if [ "$toMount" == "" ]; then 
	exit 1
fi
toMount=/dev/"$toMount"

mountPoints=$(ls ~/mnt)
mountPoint=$(echo -e "$mountPoints" | dmenu)
if [ "$mountPoint" == "" ]; then 
	exit 1
fi

sudo cryptsetup isLuks "$toMount" &&
dmenu -p "Enter Password" <&- | sudo cryptsetup open "$toMount" SSD &&
toMount="/dev/mapper/SSD"

echo $toMount
sudo mount "$toMount" ~/mnt/"$mountPoint"
