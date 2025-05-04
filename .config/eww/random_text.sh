#/usr/bin/bash

msgs[0]="Welcome"
msgs[1]="Preparing hyprland"
msgs[2]="Hi"
msgs[3]="Getting things ready"

size=${#msgs[@]}
index=$(($RANDOM % $size))
printf "${msgs[$index]}"
