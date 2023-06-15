#!/usr/bin/env bash

if [[ $1 == "title" ]]; then
  playerctl -p spotify metadata --format "{{title}}" || echo "音楽が再生されていません"
fi

if [[ $1 == "artist" ]]; then
  playerctl -p spotify metadata --format "{{artist}}" || echo "アーティストがいない"
fi

if [[ $1 == "status" ]]; then
  playerctl -p spotify status
fi
