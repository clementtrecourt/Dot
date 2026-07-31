#!/usr/bin/env bash

TASK=(
  "  Dot"
  "  NixOS"
  "  nvim"
  "󱔓  waybar"
  "  Niri"
  "󰀻  rofi"
  "  dunst"
  "󰯂  scripts"
)

CHOICE=$(
  printf '%s\n' "${TASK[@]}" | rofi \
    -dmenu \
    -i \
    -p "Control Panel" \
    -theme-str '
        window { width: 350px; }
        listview {
            columns: 2;
            lines: 5;
        }
        '
)

case "$CHOICE" in
*"Dot"*)
  kitty -e nvim ~/Dot
  ;;
*"NixOS"*)
  kitty -e nvim ~/Nix
  ;;
*"nvim"*)
  kitty -e nvim ~/.config/nvim
  ;;
*"waybar"*)
  kitty -e nvim ~/.config/waybar
  ;;
*"Niri"*)
  kitty -e nvim ~/Dot/niri/
  ;;
*"dunst"*)
  kitty -e nvim ~/.config/matugen/templates/dunst.conf
  ;;
*"scripts"*)
  kitty -e nvim ~/.local/bin
  ;;
*"rofi"*)
  kitty -e nvim ~/.config/rofi/config.rasi
  ;;
esac
