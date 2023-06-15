#!/usr/bin/bash

export SWWW_TRANSITION_FPS=240
export SWWW_TRANSITION_STEP=2
export SWWW_TRANSITION_TYPE="grow"
export SWWW_TRANSITION_POS="top-right"

TMP_DIR=/tmp/"$(whoami).swww-cache"

wallpapers=(
  "/home/dan/.local/share/wallpapers/Power/contents/images/1920x1080.png"
  "/home/dan/.local/share/wallpapers/Nishikigi-Chisato/3840x2160.png"
  "/home/dan/.local/share/wallpapers/Oni-Shoujo-1/3840x2160.png"
  "/home/dan/.local/share/wallpapers/Oni-Shoujo-3/3840x2160.png"
  "/home/dan/.local/share/wallpapers/Jigoku-shoujo/7680x4320.jpg"
)

function set() {
  /usr/bin/swww img -f Lanczos3 -t $SWWW_TRANSITION_TYPE "${wallpapers[$ID]}"
}

function main() {
  mkdir -p "${TMP_DIR}" || { echo "could not create temp dir ${TMP_DIR}"; exit 1; }
  if [[ ! -f ${TMP_DIR}/id ]]; then
    echo -ne "0" > ${TMP_DIR}/id
    ID=0
    set
  fi

  local ID=$(/usr/bin/cat $TMP_DIR/id)
  ID=$((ID+1))

  if [[ $ID -ge ${#wallpapers[@]} ]]; then
    ID=0
  fi
  echo -ne "${ID}" > ${TMP_DIR}/id
  echo "ID IS NOW $ID"

  set
}


main $@

