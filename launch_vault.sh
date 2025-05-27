#!/bin/bash

# Fortress Vault Launcher – Secure Access with Fake Vault, Logging, and Auto-Wipe

CORRECT_PASS="Thakrar@1997"
LOG_FILE=~/.vault_logs/vault_access.log
FAIL_COUNT_FILE=~/.vault_logs/fail_count

mkdir -p ~/.vault_logs
touch "$LOG_FILE"
touch "$FAIL_COUNT_FILE"

# Log timestamp
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Prompt
echo "====== Fortress Vault Launcher ======"
read -sp "Enter Vault Passphrase: " input
echo

# Check passphrase
if [[ "$input" == "$CORRECT_PASS" ]]; then
    echo "[✓] Passphrase accepted. Unlocking tools..."
    echo "$timestamp - SUCCESS: $input" >> "$LOG_FILE"
    echo "0" > "$FAIL_COUNT_FILE"  # reset fail count

    echo "Choose your tool:"
    echo "1) Payload Generator"
    echo "2) Offline AI Assistant"
    echo "3) Cloaking Tool"
    echo "4) Exit"
    read -p "Select an option (1–4): " opt

    case $opt in
      1) ~/FortressTools/easy_inject.sh ;;
      2) ~/FortressTools/offline_ai.sh ;;
      3) ~/FortressTools/device_cloak.sh ;;
      4) echo "Exiting Vault." ;;
      *) echo "Invalid option." ;;
    esac

else
    echo "$timestamp - FAIL: $input" >> "$LOG_FILE"

    # Read current fail count
    fails=$(cat "$FAIL_COUNT_FILE")
    fails=$((fails + 1))
    echo "$fails" > "$FAIL_COUNT_FILE"

    if [[ $fails -ge 3 ]]; then
        echo "[!] 3 failed attempts detected. Wiping tools..."
        termux-toast -b red "Vault breach — wiping data."
        rm -rf ~/FortressTools ~/FortressAI ~/FortressPayloads ~/FortressDocs
        echo "[!] Tools wiped."
        exit 1
    fi

    # Fake vault
    echo "[!] Incorrect passphrase. Accessing limited vault..."
    echo "Welcome to Notes Pro."
    echo "- Vault Encrypted."
    echo "- AI Access: Restricted"
    echo "- Tools: Inactive"
    echo "- Status: SAFE MODE"

    exit 0
fi
