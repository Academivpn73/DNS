#!/bin/bash
# DNS Gamer Script with all features enabled

# Online file URLs (replace with actual URLs if hosted)
GAMES_LIST_URL="https://raw.githubusercontent.com/yourusername/DNS/main/games_list.txt"
COUNTRIES_LIST_URL="https://raw.githubusercontent.com/yourusername/DNS/main/countries_list.txt"
DNS_GAMING_URL="https://raw.githubusercontent.com/yourusername/DNS/main/dns_gaming.txt"

# Title animation
function show_title() {
  colors=(31 32 33 34 35 36)
  for color in "${colors[@]}"; do
    clear
    echo -e "\e[1;${color}m+------------------------------------------+"
    echo "| Telegram: @Academi_vpn                   |"
    echo "| Admin:    @MahdiAGM0                     |"
    echo "| Version:  1.2.3                          |"
    echo "+------------------------------------------+"
    echo -e "\e[0m"
    sleep 0.2
  done
}

# Download required lists if not already present
curl -fsSL $GAMES_LIST_URL -o games_list.txt
curl -fsSL $COUNTRIES_LIST_URL -o countries_list.txt
curl -fsSL $DNS_GAMING_URL -o dns_gaming.txt

# Main menu
function main_menu() {
  show_title
  echo "1) Premium DNS 🔐 (New)"
  echo "2) Ping a DNS 📶 (New)"
  echo "3) Game Search 🎮 (New)"
  echo "4) Gaming DNS 🎯"
  echo "5) Download DNS 🚀"
  echo "0) Exit ❌"
  read -p "Choose an option: " choice
  case $choice in
    1) show_premium_dns ;;
    2) ping_dns ;;
    3) game_search ;;
    4) select_game ;;
    5) select_download_country ;;
    0) exit ;;
    *) echo "❌ Invalid Option!" ; sleep 1 ; main_menu ;;
  esac
}

function show_premium_dns() {
  echo -e "\n🔥 Premium DNS:"
  shuf -n 1 dns_gaming.txt | awk -F',' '{ print $1"\n"$2 }'
  sleep 3
  main_menu
}

function ping_dns() {
  read -p "Enter DNS to Ping: " dns_ip
  ping -c 1 "$dns_ip" | grep 'time=' || echo "⚠️ Ping failed."
  sleep 2
  main_menu
}

function game_search() {
  read -p "Enter Game Name to Search: " search_term
  result=$(grep -i "$search_term" games_list.txt)
  if [ -z "$result" ]; then
    echo -e "\e[33m⚠️ Game Not Found!\e[0m"
  else
    echo -e "\n🎮 Found Game(s):\n$result"
  fi
  sleep 2
  main_menu
}

function select_game() {
  echo -e "\n📱 Game List:"
  cat games_list.txt
  read -p "Choose Game Number: " gnum
  game=$(sed -n "${gnum}p" games_list.txt | cut -d')' -f2)
  echo -e "\n🌍 Select Country:"
  cat countries_list.txt
  read -p "Choose Country Number: " cnum
  country=$(sed -n "${cnum}p" countries_list.txt | cut -d')' -f2)
  dns=$(grep "$game - $country" dns_gaming.txt | shuf -n 1)
  if [ -z "$dns" ]; then
    echo "⚠️ DNS not found for this game/country"
  else
    echo -e "\n🎮 $game - $country"
    echo "$dns" | awk -F',' '{print $1"\n"$2}'
    ping -c 1 "$(echo $dns | cut -d',' -f1)" | grep 'time='
  fi
  read -p "Press Enter to return..." _
  main_menu
}

function select_download_country() {
  echo -e "\n🌍 Select Country for Download DNS:"
  cat countries_list.txt
  read -p "Choose Country Number: " cnum
  country=$(sed -n "${cnum}p" countries_list.txt | cut -d')' -f2)
  dns=$(grep "Download - $country" dns_gaming.txt | shuf -n 1)
  if [ -z "$dns" ]; then
    echo "⚠️ DNS not found for download in this country"
  else
    echo -e "\n🚀 Download DNS - $country"
    echo "$dns" | awk -F',' '{print $1"\n"$2}'
    ping -c 1 "$(echo $dns | cut -d',' -f1)" | grep 'time='
  fi
  read -p "Press Enter to return..." _
  main_menu
}

main_menu
