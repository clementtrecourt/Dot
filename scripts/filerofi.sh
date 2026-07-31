#!/usr/bin/env bash
FILE=$(fd --type f | rofi -dmenu -i -p "Search Files:")
if [ -n "$FILE" ]; then
    xdg-open "$FILE"
fi
