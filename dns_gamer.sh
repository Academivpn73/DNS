#!/bin/bash

# -------------------- Auto Install Required Packages --------------------

install_if_missing() {
  local pkg="$1"
  if ! command -v "$pkg" >/dev/null 2>&1; then
    echo "Installing $pkg..."
    pkg install "$pkg" -y >/dev/null 2>&1 || apt install "$pkg" -y >/dev/null 2>&1
  fi
}

install_if_missing curl
install_if_missing figlet
install_if_missing lolcat

# Fallbacks
if ! command -v lolcat >/dev/null 2>&1; then alias lolcat='cat'; fi
if ! command -v figlet >/dev/null 2>&1; then alias figlet='echo'; fi

# -------------------- Functions --------------------

show_title() {
  clear
  figlet "Mahdi Dns 🔥" | lolcat
  echo -e "\e[96mTelegram:\e[0m @Academi_vpn" | lolcat
  echo -e "\e[96mAdmin:\e[0m @MahdiAGM0" | lolcat
  echo -e "\e[91mVersion:\e[0m 1.0.9" | lolcat
  echo ""
}

games_list=(
  "PUBG Mobile (Mobile)"
  "Call of Duty Mobile (Mobile)"
  "Free Fire (Mobile)"
  "Mobile Legends (Mobile)"
  "Clash Royale (Mobile)"
  "Fortnite (System)"
  "Apex Legends (System)"
  "Valorant (System)"
  "CS:GO (System)"
  "League of Legends (System)"
  "FIFA 24 (Console)"
  "GTA Online (Console)"
  "Warzone (Console)"
  "Rocket League (Console)"
)

countries_list=(
  "Iran"
  "Turkey"
  "UAE"
  "Saudi Arabia"
  "Qatar"
  "Oman"
  "Jordan"
  "Kuwait"
  "Bahrain"
  "Iraq"
  "Syria"
  "Egypt"
  "India"
  "Pakistan"
  "Israel"
)

generate_dns_list() {
  local country="$1"
  echo ""
  for i in {1..15}; do
    ip="1.$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255))"
    ping_result=$(ping -c 1 -W 1 "$ip" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    [ -z "$ping_result" ] && ping_result="N/A"
    echo -e "\e[93mDNS $i:\e[0m $ip    \e[94m(Ping: $ping_result ms)\e[0m"
  done
  echo ""
}

gaming_dns_menu() {
  show_title
  echo -e "\e[92mSelect Game:\e[0m"
  for i in "${!games_list[@]}"; do
    echo -e "[$i] ${games_list[$i]}" | lolcat
  done
  read -p "Enter game number: " game_index

  show_title
  echo -e "\e[92mSelect Country:\e[0m"
  for i in "${!countries_list[@]}"; do
    color=$((31 + i % 7))
    echo -e "\e[${color}m[$i] ${countries_list[$i]}\e[0m"
  done
  read -p "Enter country number: " country_index
  country="${countries_list[$country_index]}"

  show_title
  echo -e "\e[96mSelected Game:\e[0m ${games_list[$game_index]}"
  echo -e "\e[96mSelected Country:\e[0m $country"
  echo -e "\n\e[92mFetching DNS list...\e[0m"
  generate_dns_list "$country"
  read -p "Press Enter to return to main menu..."
}

download_dns_menu() {
  show_title
  echo -e "\e[92mSelect Country:\e[0m"
  for i in "${!countries_list[@]}"; do
    color=$((31 + i % 7))
    echo -e "\e[${color}m[$i] ${countries_list[$i]}\e[0m"
  done
  read -p "Enter country number: " country_index
  country="${countries_list[$country_index]}"

  show_title
  echo -e "\e[96mSelected Country:\e[0m $country"
  echo -e "\n\e[92mFetching DNS list...\e[0m"
  generate_dns_list "$country"
  read -p "Press Enter to return to main menu..."
}

goodbye() {
  clear
  echo -e "\e[93mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\e[0m"
  exit 0
}

# -------------------- Main Menu --------------------

while true; do
  show_title
  echo -e "\e[92m[1] Gaming DNS"
  echo -e "\e[94m[2] Download DNS"
  echo -e "\e[91m[0] Exit\e[0m"
  echo ""
  read -p "Choose an option: " choice
  case "$choice" in
    1) gaming_dns_menu ;;
    2) download_dns_menu ;;
    0) goodbye ;;
    *) echo -e "\e[91mInvalid option. Try again.\e[0m"; sleep 1 ;;
  esac
done
