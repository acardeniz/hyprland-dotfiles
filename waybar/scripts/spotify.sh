#!/bin/bash

# Spotify durumunu kontrol et
status=$(playerctl -p spotify status 2>/dev/null)

# Spotify çalışmıyorsa
if [ -z "$status" ]; then
    echo '{"text": "󰓇 Spotify", "tooltip": "Spotify is not running", "class": "idle"}'
    exit 0
fi

# Icon seç
if [ "$status" = "Playing" ]; then
    icon="󰏤"
elif [ "$status" = "Paused" ]; then
    icon="󰐊"
else
    icon="󰓇"
fi

# Metadata al
artist=$(playerctl -p spotify metadata artist 2>/dev/null)
title=$(playerctl -p spotify metadata title 2>/dev/null)

# Bilgi yoksa
if [ -z "$artist" ] || [ -z "$title" ]; then
    echo "{\"text\": \"󰓇 $icon Spotify\", \"tooltip\": \"No track info\", \"class\": \"$status\"}"
    exit 0
fi

# Özel karakterleri temizle (JSON için)
artist=$(echo "$artist" | sed 's/"/\\"/g' | sed "s/'/\\'/g")
title=$(echo "$title" | sed 's/"/\\"/g' | sed "s/'/\\'/g")

# Metni kısalt
max_length=30
combined="$artist - $title"
if [ ${#combined} -gt $max_length ]; then
    combined="${combined:0:$max_length}..."
fi

# JSON çıktısı (escape edilmiş)
printf '{"text": "󰓇 %s %s", "tooltip": "%s - %s\\n\\nClick: Play/Pause", "class": "%s"}\n' \
    "$icon" "$combined" "$artist" "$title" "$status"
