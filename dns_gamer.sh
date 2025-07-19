#!/bin/bash

# ------------ Config ------------ #
VERSION="1.2.3"
ADMIN="@MahdiAGM0"
TELEGRAM="@Academi_vpn"
DNS_FILE="dns_list.txt"
GAMES_FILE="games_list.txt"
COUNTRIES=("Iran" "Turkey" "UAE" "Qatar" "Saudi" "Other")
COLORS=(31 32 33 34 35 36)

# ------------ Functions ------------ #

function title() {
  COLOR=${COLORS[$RANDOM % ${#COLORS[@]}]}
  clear
  echo -e "\e[1;${COLOR}m+------------------------------------------+"
  echo -e "|           DNS Service Menu               |"
  echo -e "+------------------------------------------+"
  echo -e "| Admin:   $ADMIN"
  echo -e "| Telegram: $TELEGRAM"
  echo -e "| Version:  $VERSION"
  echo -e "+------------------------------------------+\e[0m"
  echo
}

function pause() {
  echo
  read -p "Press Enter to return to menu..."
  main_menu
}

function list_games() {
  echo "📱 Game List:"
  local count=1
  while IFS= read -r game; do
    echo "$count. $game"
    ((count++))
  done < "$GAMES_FILE"
}

function list_countries() {
  echo "🌍 Choose a region:"
  for i in "${!COUNTRIES[@]}"; do
    echo "$((i+1)). ${COUNTRIES[$i]}"
  done
}

function get_random_dns() {
  shuf -n 1 "$DNS_FILE"
}

function show_dns() {
  DNS=$(get_random_dns)
  IP1=$(echo "$DNS" | cut -d',' -f1)
  IP2=$(echo "$DNS" | cut -d',' -f2)
  echo -e "\nPrimary DNS: $IP1"
  echo "Secondary DNS: $IP2"
  ping -c 1 -W 1 "$IP1" &>/dev/null && PING=$(ping -c 1 "$IP1" | grep time= | awk -F'time=' '{print $2}' | cut -d' ' -f1) || PING="Timeout"
  echo "Ping: $PING ms"
}

# ------------ Options ------------ #

function dns_gaming() {
  title
  echo "🎮 Gaming DNS"
  echo
  list_games
  echo
  read -p "Enter game number: " game_choice
  GAME=$(sed "${game_choice}q;d" "$GAMES_FILE")
  echo
  list_countries
  echo
  read -p "Enter country number: " country_choice
  COUNTRY=${COUNTRIES[$((country_choice-1))]}
  echo -e "\nRecommended DNS for $GAME in $COUNTRY:"
  show_dns
  pause
}

function dns_download() {
  title
  echo "🚀 Download Optimized DNS"
  echo
  list_countries
  echo
  read -p "Enter country number: " country_choice
  COUNTRY=${COUNTRIES[$((country_choice-1))]}
  echo -e "\nBest Download DNS for $COUNTRY:"
  show_dns
  pause
}

function dns_premium() {
  title
  echo "⚡ Premium DNS"
  show_dns
  pause
}

function ping_dns() {
  title
  echo "📡 Ping a DNS"
  read -p "Enter DNS IP: " IP
  ping -c 1 "$IP"
  pause
}

function search_game() {
  title
  echo "🔍 Search Game"
  read -p "Enter game name: " name
  if grep -iq "$name" "$GAMES_FILE"; then
    echo -e "\n✅ Game Found!"
    list_countries
    read -p "Enter country number: " country_choice
    COUNTRY=${COUNTRIES[$((country_choice-1))]}
    echo -e "\nDNS for $name in $COUNTRY:"
    show_dns
  else
    echo -e "\e[33m❌ Game Not Found.\e[0m"
  fi
  pause
}

# ------------ Main Menu ------------ #

function main_menu() {
  title
  echo "Choose an option:"
  echo "1. 🎮 DNS for Gaming"
  echo "2. 🚀 DNS for Download"
  echo "3. ⚡ Premium DNS (New)"
  echo "4. 📡 Ping DNS (New)"
  echo "5. 🔍 Search Game (New)"
  echo "0. Exit"
  echo
  read -p "Enter your choice: " choice
  case $choice in
    1) dns_gaming ;;
    2) dns_download ;;
    3) dns_premium ;;
    4) ping_dns ;;
    5) search_game ;;
    0) exit ;;
    *) echo "Invalid option"; sleep 1; main_menu ;;
  esac
}

main_menu
