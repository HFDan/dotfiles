#!/usr/bin/bash

if [[ $1 == "--no-show-music" ]]; then
  $HOME/.config/i3/lockscreen.sh --no-show-music
else
  $HOME/.config/i3/lockscreen.sh && eww close lockscreenplayerstatus
fi
