#!/usr/bin/python3

import os
import subprocess
from enum import Enum

class PlayerStatus(Enum):
    PLAYING = 0
    PAUSED = 1
    NOPLAYER = 2

class Song():
    def __init__(self, songname: str, artist: str):
        self.name = songname
        self.artist = artist

def get_player_status() -> PlayerStatus:
    cmd = "/usr/bin/playerctl -p spotify status 2>&1"
    res = subprocess.run(cmd, shell=True, capture_output=True, encoding='utf-8').stdout.strip()
    
    match res:
        case "Playing":
            return PlayerStatus.PLAYING
        case "Paused":
            return PlayerStatus.PAUSED
        case "No players found":
            return PlayerStatus.NOPLAYER

def get_current_playing_song() -> Song:
    cmd = "/usr/bin/playerctl -p spotify metadata --format \"{{ artist }}\" 2>&1"
    artist = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.strip()

    cmd = "/usr/bin/playerctl -p spotify metadata --format \"{{ title }}\" 2>&1"
    title = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.strip()

    max_length = 20
    if len(title) > max_length:
        title = title[:max_length] + "..."

    return Song(title, artist)

def main():
    playerstat: PlayerStatus = get_player_status()
    outstring: str = ""

    if playerstat == PlayerStatus.NOPLAYER:
        outstring = "No music playing :("
    elif playerstat == PlayerStatus.PAUSED:
        outstring = f"󰎆 {get_current_playing_song().artist} - {get_current_playing_song().name}"
    elif playerstat == PlayerStatus.PLAYING:
        outstring = f"󰎆  {get_current_playing_song().artist} - {get_current_playing_song().name}"

    print(outstring)


if __name__ == "__main__":
    main()
