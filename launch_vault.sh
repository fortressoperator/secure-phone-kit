#!/bin/bash

# Fortress Vault Launcher – Secure Access

CORRECT_PASS="Thakrar@1997"  # Custom passphrase

echo "====== Fortress Vault Launcher ======"
read -sp "Enter Vault Passphrase: " input
echo

if [[ "$input" != "$CORRECT_PASS" ]]; then
    echo "[!] Incorrect passphrase. Access denied."
    exit 1
fi

echo "[✓] Passphrase accepted. Unlocking tools..."
sleep 1

echo "Choose your tool:"
echo "1) Payload Generator"
echo "2) Offline AI Assistant"
echo "3) Cloaking Tool"
echo "4) Exit"

read -p "Select an option (1–4): " opt

case $opt in
  1)
    ~/FortressTools/easy_inject.sh
    ;;
  2)
    ~/FortressTools/offline_ai.sh
    ;;
  3)
    ~/FortressTools/device_cloak.sh
    ;;
  4)
    echo "Exiting Vault."
    exit 0
    ;;
  *)
    echo "Invalid option."
    ;;
esac
