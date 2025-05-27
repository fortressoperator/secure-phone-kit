#!/data/data/com.termux/files/usr/bin/bash

echo "[*] Fortress Setup: Initializing Secure Phone..."

# Step 1: Update packages
pkg update -y && pkg upgrade -y

# Step 2: Install dependencies
pkg install git curl tsu cronie -y

# Step 3: Clone the Fortress repo (if not already)
cd ~
[ ! -d "secure-phone-kit" ] && git clone https://github.com/fortressoperator/secure-phone-kit.git

# Step 4: Create directories
mkdir -p ~/FortressTools ~/FortressPayloads ~/FortressDocs ~/.vault_logs

# Step 5: Copy tools from repo
cp ~/secure-phone-kit/*.sh ~/FortressTools/
chmod +x ~/FortressTools/*.sh

# Step 6: Add vault launcher shortcut
echo "" >> ~/.bashrc
echo "# Auto-launch Fortress Vault" >> ~/.bashrc
echo "alias vault='cd ~/secure-phone-kit && ./launch_vault.sh'" >> ~/.bashrc

# Step 7: Enable cron service (idle_wipe, usb_monitor, sim_monitor)
crontab -l > tempcron
echo "@reboot bash ~/FortressTools/usb_monitor.sh" >> tempcron
echo "@reboot bash ~/FortressTools/sim_monitor.sh" >> tempcron
echo "@daily bash ~/FortressTools/idle_wipe.sh" >> tempcron
crontab tempcron
rm tempcron

# Step 8: Finish
echo "[✓] Fortress OS setup complete."
echo "[*] Reboot your phone to activate all triggers."
echo "[*] To launch the vault, type: vault"

# Optional: Offer to reboot now
read -p "Do you want to reboot now? (y/n): " confirm
[ "$confirm" == "y" ] && termux-reboot
