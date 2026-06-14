#!/usr/bin/env bash

SOCKET="/tmp/mpvpaper-socket"
SCREENSHOT_DIR="/tmp/mpvpaper-frames"
SCREENSHOT_PATH="${SCREENSHOT_DIR}/current-frame.png"

mkdir -p "$SCREENSHOT_DIR"
rm -f "$SCREENSHOT_PATH"

if command -v socat >/dev/null 2>&1; then
    echo "{\"command\": [\"screenshot-to-file\", \"${SCREENSHOT_PATH}\"]}" | socat - "$SOCKET"
else
    echo "{\"command\": [\"screenshot-to-file\", \"${SCREENSHOT_PATH}\"]}" | nc -U "$SOCKET"
fi

TIMEOUT=100
while [ ! -s "$SCREENSHOT_PATH" ] && [ $TIMEOUT -gt 0 ]; do
    sleep 0.1
    TIMEOUT=$((TIMEOUT - 1))
done

if [ -s "$SCREENSHOT_PATH" ]; then
    wal -i "$SCREENSHOT_PATH"
else
    echo "Error: Frame capture timed out or failed. Ensure mpvpaper is running with:"
    echo "mpvpaper -o \"--input-ipc-server=$SOCKET\" <monitor> <video>"
fi

