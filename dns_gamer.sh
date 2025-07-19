#!/bin/bash

# Set DNS list URL
DNS_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_list.txt"
DNS_FILE="/tmp/dns_list.txt"

# Download latest DNS list
curl -s "$DNS_URL" -o "$DNS_FILE"

# Title with info
title_box() {
  clear
  echo -e "\033[1;36m+------------------------------------------+"
  echo -e "|   DNS Optimizer - Gaming & Speed Tools   |"
  echo -e "|   Telegram: @Academi_vpn                 |"
  echo -e "|   Admin:    @MahdiAGM0                   |"
  echo -e "|   Version:  1.2.3                        |"
  echo -e "+------------------------------------------+\033[0m"
  echo ""
}

# Show random premium DNS
show_random_dns() {
  title_box
  echo -e "\033[1;32m[+] Premium DNS:\033[0m"
  dns=$(shuf -n 1 "$DNS_FILE")
  primary=$(echo "$dns" | cut -d',' -f1)
  secondary=$(echo "$dns" | cut -d',' -f2)
  echo "Primary: $primary"
  echo "Secondary: $secondary"
  ping=$(ping -c 1 "$primary" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
  echo "Ping: ${ping:-Unavailable} ms"
  echo ""
  read -p "Press Enter to return..."
}

# Ping any DNS
ping_dns() {
  title_box
  read -p "Enter DNS to ping (e.g. 1.1.1.1): " dns
  if [[ -z "$dns" ]]; then
    echo "Invalid DNS."
  else
    ping -c 3 "$dns"
  fi
  echo ""
  read -p "Press Enter to return..."
}

# Search game DNS (mockup for now)
search_game() {
  title_box
  read -p "Enter game name: " game
  game_lower=$(echo "$game" | tr '[:upper:]' '[:lower:]')

  case "$game_lower" in
    "call of duty"|"codm"|"arena breakout"|"pubg"|"free fire")
      echo "Available regions for $game:"
      echo "1) Iran"
      echo "2) UAE"
      echo "3) Turkey"
      read -p "Choose region (1-3): " region
      echo ""
      echo -e "\033[1;32mRecommended DNS for $game:\033[0m"
      dns=$(shuf -n 1 "$DNS_FILE")
      primary=$(echo "$dns" | cut -d',' -f1)
      secondary=$(echo "$dns" | cut -d',' -f2)
      echo "Primary: $primary"
      echo "Secondary: $secondary"
      ping=$(ping -c 1 "$primary" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
      echo "Ping: ${ping:-Unavailable} ms"
      ;;
    *)
      echo -e "\033[1;33mGame not found in our list.\033[0m"
      ;;
  esac
  echo ""
  read -p "Press Enter to return..."
}

# Main menu
while true; do
  title_box
  echo -e "\033[1;36mChoose an option:\033[0m"
  echo "1) 🎯 DNS مخصوص دانلود"
  echo "2) 🎮 DNS گیمینگ"
  echo "3) 💎 Premium DNS (جدید)"
  echo "4) 📶 Ping DNS (جدید)"
  echo "5) 🔍 Search Game DNS (جدید)"
  echo "0) ❌ Exit"
  echo ""

  read -p "Select: " opt
  case $opt in
    1) show_random_dns ;;  # در عمل باید فیلتر دانلود باشه
    2) show_random_dns ;;  # در عمل باید فیلتر گیم باشه
    3) show_random_dns ;;
    4) ping_dns ;;
    5) search_game ;;
    0) exit ;;
    *) echo "Invalid option"; sleep 1 ;;
  esac
done
