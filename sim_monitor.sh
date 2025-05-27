#!/bin/bash

# SIM Removal Watcher
echo "[*] Monitoring SIM status..."

# Record current ICCID (SIM ID)
original_iccid=$(termux-telephony-deviceinfo | grep iccid | awk -F ': ' '{print $2}' | tr -d '",')

while true; do
    current_iccid=$(termux-telephony-deviceinfo | grep iccid | awk -F ': ' '{print $2}' | tr -d '",')

    if [[ "$original_iccid" != "$current_iccid" || -z "$current_iccid" ]]; then
        echo "[!] SIM removed or replaced. Initiating wipe..."

        # Optional warning
        termux-toast -b red "SIM Change Detected. Wiping now..."

        # Wipe sensitive data
        rm -rf ~/storage/* 2>/dev/null
        rm -rf ~/FortressTools ~/FortressAI ~/FortressPayloads ~/FortressDocs 2>/dev/null
        termux-reboot
        break
    fi

    sleep 5
done
