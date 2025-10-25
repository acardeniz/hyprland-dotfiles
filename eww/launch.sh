#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  Eww startup script - opens only desired windows
# ─────────────────────────────────────────────────────────────────────────────

# Close all first
eww close-all

# Open desired windows
eww open audio_status
eww open visualizer_window
eww open cpu_ram_storage_bars
eww open ascii_decor_frame
eww open net_bars
eww open right_internet_text
eww open active_workspace
eww open four_boxes
eww open orange_workspace
eww open workspace_window_text

# Excluded windows (will not open):
# - power-cooling_header_text
# - power_mode_text
# - right_fan_data
# - welcome_text
