#!/usr/bin/env bash
# whatsong.sh — affiche artiste - titre du lecteur média actif (MPRIS)

if ! command -v playerctl &>/dev/null; then
  echo ""
  exit 0
fi

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
  artist=$(playerctl metadata artist 2>/dev/null)
  title=$(playerctl metadata title 2>/dev/null)

  if [ -n "$artist" ] && [ -n "$title" ]; then
    echo "  $artist - $title"
  elif [ -n "$title" ]; then
    echo "  $title"
  else
    echo ""
  fi
else
  echo ""
fi
