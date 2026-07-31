#!/usr/bin/env bash

OUTPUT_FILE="$HOME/.config/niri/outputs.kdl"

declare -a NAMES
declare -a PORTS

while IFS="|" read -r name port; do
    NAMES+=("$name")
    PORTS+=("$port")
done < <(
    niri msg outputs |
    grep '^Output ' |
    sed -E 's/^Output "(.+)" \((.+)\)/\1|\2/'
)

echo "Écrans détectés :"
echo

for i in "${!PORTS[@]}"; do
    echo "$((i+1))) ${NAMES[$i]} (${PORTS[$i]})"
done

echo

read -rp "Numéro de l'écran à gauche : " LEFT_CHOICE
read -rp "Numéro de l'écran à droite : " RIGHT_CHOICE

LEFT_INDEX=$((LEFT_CHOICE-1))
RIGHT_INDEX=$((RIGHT_CHOICE-1))

LEFT="${PORTS[$LEFT_INDEX]}"
RIGHT="${PORTS[$RIGHT_INDEX]}"

if [[ -z "$LEFT" || -z "$RIGHT" ]]; then
    echo "Choix invalide"
    exit 1
fi

cat > "$OUTPUT_FILE" <<EOF
// Généré automatiquement

output "$LEFT" {
    mode "1920x1080@60"
    position x=0 y=0
    scale 1
}

output "$RIGHT" {
    mode "1920x1080@60"
    position x=1920 y=0
    scale 1
}
EOF

echo
echo "Fichier créé : $OUTPUT_FILE"
cat "$OUTPUT_FILE"
