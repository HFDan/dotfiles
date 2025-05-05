#!/usr/bin/bash
if [[ -z $(playerctl -l 2>&1 | grep "No players found") ]]; then
    echo true
else
    echo false
fi
