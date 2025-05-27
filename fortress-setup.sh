#!/bin/bash

echo "[*] Starting Fortress OS Setup..."

pkg update -y && pkg upgrade -y
pkg install git wget curl python openssh proot zip unzip tsu -y

mkdir -p ~/FortressTools ~/FortressDocs ~/FortressAI ~/FortressPayloads
cd ~/FortressTools

pkg install unstable-repo -y
pkg install metasploit -y

pkg install root-repo -y
pkg install steghide exiftool -y

wget https://raw.githubusercontent.com/fortressoperator/secure-phone-kit/main/easy_inject.sh
wget https://raw.githubusercontent.com/fortressoperator/secure-phone-kit/main/device_cloak.sh
wget https://raw.githubusercontent.com/fortressoperator/secure-phone-kit/main/offline_ai.sh
wget https://raw.githubusercontent.com/fortressoperator/secure-phone-kit/main/launch_vault.sh
chmod +x easy_inject.sh device_cloak.sh offline_ai.sh launch_vault.sh

pkg install ollama -y
cd ~/FortressAI
ollama pull mistral

cd ~/FortressTools
wget https://raw.githubusercontent.com/fortressoperator/secure-phone-kit/main/usb_monitor.sh
wget https://raw.githubusercontent.com/fortressoperator/secure-phone-kit/main/sim_monitor.sh
wget https://raw.githubusercontent.com/fortressoperator/secure-phone-kit/main/idle_wipe.sh
chmod +x usb_monitor.sh sim_monitor.sh idle_wipe.sh

pkg install cronie -y
crontab -l > tempcron
echo "@reboot bash ~/FortressTools/usb_monitor.sh" >> tempcron
echo "@reboot bash ~/FortressTools/sim_monitor.sh" >> tempcron
echo "@daily bash ~/FortressTools/idle_wipe.sh" >> tempcron
crontab tempcron
rm tempcron

cd ~/FortressDocs
curl -O https://raw.githubusercontent.com/fortressoperator/secure-phone-kit/main/Fortress_Handbook.pdf

cd ~/FortressTools
wget https://raw.githubusercontent.com/fortressoperator/secure-phone-kit/main/fake_notes_launcher.apk

echo "[✓] Fortress Setup Complete. Use ~/FortressTools/ for tools and ~/FortressDocs/ for your PDF guide."
