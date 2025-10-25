#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  Returns window titles for each workspace (1-4)
# ─────────────────────────────────────────────────────────────────────────────

for ws in {1..4}; do
  # Get first window title for this workspace
  title=$(hyprctl clients -j 2>/dev/null | jq -r --arg ws "$ws" '
    .[] | select(.workspace.id == ($ws | tonumber)) | .title
  ' | head -1)
  
  if [[ -n "$title" && "$title" != "null" ]]; then
    # Truncate if too long
    if [[ ${#title} -gt 20 ]]; then
      title="${title:0:17}..."
    fi
    echo "ws${ws}_window=$title"
  else
    echo "ws${ws}_window="
  fi
done
