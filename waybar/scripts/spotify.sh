#!/bin/bash

# Daha hızlı çalışması için tek komutla tüm bilgileri al
metadata=$(playerctl -p spotify metadata 2>/dev/null)
status=$(playerctl -p spotify status 2>/dev/null)

# Spotify çalışmıyorsa
if [ -z "$status" ]; then
    echo '{"text": "[ 󰓇  Spotify ]", "tooltip": "Spotify is not running", "class": "idle"}'
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

# Metadata'dan bilgileri çıkar (daha hızlı)
artist=$(echo "$metadata" | grep "xesam:artist" | cut -d' ' -f3- | sed 's/^[ \t]*//')
title=$(echo "$metadata" | grep "xesam:title" | cut -d' ' -f3- | sed 's/^[ \t]*//')

# Bilgi yoksa
if [ -z "$artist" ] || [ -z "$title" ]; then
    echo '{"text": "[ 󰓇  Spotify ]", "tooltip": "No track info", "class": "idle"}'
    exit 0
fi

# Metni kısalt
max_length=35
combined="$artist - $title"
if [ ${#combined} -gt $max_length ]; then
    combined="${combined:0:$max_length}..."
fi

# JSON çıktısı
echo "{\"text\": \"[ 󰓇  $icon  $combined ]\", \"tooltip\": \"$artist\\n$title\\n\\nClick: Play/Pause\\nScroll: Next/Previous\", \"class\": \"$status\"}"
