#!/bin/bash

tmp_dir="/tmp/$USER/eww/spotify"
tmp_cover_path=$tmp_dir/cover.png
tmp_temp_path=$tmp_dir/temp.png
tmp_albumart_path=$tmp_dir/albumart.png
get_song_art () {

  if [ ! -d $tmp_dir ]; then
    mkdir -p $tmp_dir
  fi

  artlink="$(playerctl -p spotify metadata mpris:artUrl | sed -e 's/open.spotify.com/i.scdn.co/g')"

  if [ $(playerctl -p spotify metadata mpris:artUrl) ]; then
    curl -s "$artlink" --output $tmp_temp_path
  else
    cp $HOME/.config/eww/assets/fallback.png $tmp_temp_path
  fi

  # an epic effekt
  # convert $tmp_temp_path -alpha set -channel A -evaluate multiply 0.3  $tmp_cover_path

  cp $tmp_temp_path $tmp_albumart_path

  convert $tmp_temp_path -gravity center +repage -alpha set -channel A \
      -sparse-color Barycentric '%[fx:w+0.5],0 opaque   %[fx:w*2/32],0 transparent' \
    -evaluate multiply 0.5 \
      $tmp_temp_path
  convert $tmp_temp_path -blur 0x8 $tmp_cover_path
}

echo_song_art_url () {
  echo "$tmp_dir/cover.png"
}

echo_albumart_url () {
  echo "$tmp_dir/albumart.png"
}

if [[ $1 == "echo" ]]; then
  echo_song_art_url
fi

if [[ $1 == "albumart" ]]; then
  echo_albumart_url
fi

if [[ $1 == "get" ]]; then
  get_song_art
fi
