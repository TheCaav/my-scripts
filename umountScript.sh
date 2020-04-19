#!/bin/sh
mounteds=$(find ~/mnt -mindepth 1 -maxdepth 1 -not -empty -type d)
toUmount=$(echo -e "$mounteds" | dmenu)

sudo umount $toUmount
