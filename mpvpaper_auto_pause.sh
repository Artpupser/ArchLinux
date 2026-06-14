#!/bin/sh
SOCKET="/tmp/mpvpaper-socket"

resume_paper() {
if ! pgrep -x mpvpaper >/dev/null; then
	~/.config/mpvpaper_start.sh &
fi
}
pause_paper() {
        pkill -x mpvpaper
}

handle() {
  case $1 in
    "fullscreen>>1")
      	pause_paper
	;;
    "activewindow>>,"|*">>:,")
	resume_paper
	;;
    "activewindow>>"*)
      	pause_paper
	;;
    "fullscreen>>0")
      	pause_paper
      	;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do 
    handle "$line"
done

