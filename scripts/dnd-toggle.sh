#!/usr/bin/env bash
dunstctl set-paused toggle
pkill -SIGRTMIN+8 waybar
