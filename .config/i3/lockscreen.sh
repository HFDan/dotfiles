#!/usr/bin/bash

if [[ $1 == "--no-show-music" ]]; then
  /usr/bin/betterlockscreen -l dimblur -- --pass-media-keys
else
  /usr/bin/betterlockscreen -l dimblur -- --pass-media-keys &
  sleep .5
  /usr/bin/eww open lockscreenplayerstatus &
  wait
fi
