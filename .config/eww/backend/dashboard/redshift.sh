#!/usr/bin/env bash

cache_file=$HOME/.cache/eww/services/redshift_state

initial_hook () {
  if [ ! -d $(dirname $cache_file) ]; then
    mkdir $(dirname $cache_file)
  fi
  if [ ! -f $cache_file ]; then
    echo off > $cache_file
  fi
}

get_state () {
  # check if redshift is running
  cat $cache_file
}

disable_redshift () {
  redshift -x 2>&1 > /dev/null
  # saving state
  echo off > $cache_file
}

enable_redshift () {
  redshift -x 2>&1 > /dev/null
  redshift -O 7400 2>&1 > /dev/null
  # saving new state
  echo on > $cache_file
}

toggle () {
  local state=$(get_state)
  if [[ $state == "on" ]]; then
    # time to disable
    disable_redshift
  else
    # we should enable it
    enable_redshift
  fi
}

restore () {
  local state=$(get_state)
  disable_redshift
  if [[ $state == "on" ]]; then
    enable_redshift
  fi
}

initial_hook

if [[ $1 == "state" ]]; then
  get_state
fi

if [[ $1 == "enable" ]]; then
  enable_redshift
fi

if [[ $1 == "disable" ]]; then
  disable_redshift
fi

if [[ $1 == "toggle" ]]; then
  toggle
fi

if [[ $1 == "restore" ]]; then
  restore
fi