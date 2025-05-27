#!/bin/bash

# USB Monitor - Wipe system if USB connection is detected
echo "[*] Monitoring USB connection state..."

while true; do
    usb_state=$(cat /sys/class/android_usb/android0/state 2>/dev/null)
    
    if [[ "$usb_state" == "CONFIGURED" || "$usb_state" == "CONNECTED" ]]; then
        echo "[!] Unauthorized USB connection detected. Triggering wipe..."

        # Optional: Flash warning or log event
        termux-toast -b red "USB Plug-In Detected. Wiping now..."

        # Wipe user storage
        rm -rf ~/storage/* 2>/dev/null
        rm -rf ~/FortressTools ~/FortressAI ~/FortressPayloads ~/FortressDocs 2>/dev/null
        termux-reboot

        break
    fi
    sleep 3
done
