#!/bin/sh
ffmpeg -ss 00:00:01 -i "$HOME/Videos/wallpaper.mp4" -vframes 1 -y /tmp/current-wallpaper.png &>/dev/null

hyprpaper &

sleep 0.5

hyprctl hyprpaper wallpaper ",/tmp/current-wallpaper.png"

mpvpaper -o "loop no-audio --input-ipc-server=/tmp/mpvpaper-socket --mpv-options='--hwdec=auto" '*' "~/Videos/wallpaper.mp4"

