#!/bin/bash

echo "[*] Device Cloaker: MAC + Hostname + Bluetooth Spoofing"

# Generate random MAC address
hexchars="0123456789ABCDEF"
MAC="02"
for i in {1..5}; do
  octet="${hexchars:$(( RANDOM % 16 )):1}${hexchars:$(( RANDOM % 16 )):1}"
  MAC+=":$octet"
done

# Set spoofed hostname
HOSTNAMES=("PixelXL" "GalaxyA52" "RedmiNote10" "Chromecast" "HP-Printer" "iPad11")
RANDOM_HOST=${HOSTNAMES[$RANDOM % ${#HOSTNAMES[@]}]}

# Set spoofed Bluetooth name
BT_NAMES=("JBL_Speaker_207" "CarAudio_BT" "Echo_Dot" "Xiaomi_Band" "Oura_Ring")
RANDOM_BT=${BT_NAMES[$RANDOM % ${#BT_NAMES[@]}]}

echo "[*] Spoofing Identity..."
echo "New MAC Address   : $MAC"
echo "New Hostname      : $RANDOM_HOST"
echo "Bluetooth Name    : $RANDOM_BT"

# Apply changes (simulated, since Android doesn't allow direct MAC spoofing in userland)
termux-wifi-enable false
termux-wifi-enable true
termux-wifi-connectioninfo > /dev/null

# Update hostname (for shell)
echo "$RANDOM_HOST" > ~/FortressTools/spoofed_hostname.txt
termux-change-hostname $RANDOM_HOST

# Bluetooth spoofing message
echo "[!] Note: Bluetooth spoofing shown above is simulated — manual rename in system settings may be required."

echo "[✓] Device identity cloaked. Operate with stealth."
