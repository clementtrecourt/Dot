#!/usr/bin/env bash

id=$(
  niri msg windows |
    awk '
    /Window ID/ {id=$3}
    /App ID: "spotify"/ {
        gsub(":", "", id)
        print id
        exit
    }'
)

[ -n "$id" ] && niri msg action focus-window --id "$id"
