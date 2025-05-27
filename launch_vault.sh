#!/bin/bash

echo "====== Fortress Vault Launcher ======"
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
