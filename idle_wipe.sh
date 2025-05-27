#!/bin/bash

# Idle Wipe Script - Secure profile self-destruct if unused for 5+ days

TIMESTAMP_FILE=~/FortressTools/.last_login

# Create timestamp file if not present
if [ ! -f "$TIMESTAMP_FILE" ]; then
    date +%s > "$TIMESTAMP_FILE"
    exit 0
fi

last_login=$(cat "$TIMESTAMP_FILE")
current_time=$(date +%s)
let elapsed=($current_time - $last_login)/86400

if [ "$elapsed" -ge 5 ]; then
    echo "[!] Secure profile inactive for $elapsed days. Wiping data..."

    termux-toast -b red "5 Days Idle. Wiping now..."
    rm -rf ~/storage/* 2>/dev/null
    rm -rf ~/FortressTools ~/FortressAI ~/FortressPayloads ~/FortressDocs 2>/dev/null
    termux-reboot
else
    echo "[*] Last login was $elapsed day(s) ago. No action taken."
fi
