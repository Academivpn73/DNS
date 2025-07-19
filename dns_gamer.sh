#!/bin/bash

# Title box function
show_title() {
  colors=(31 32 33 34 35 36)
  color=${colors[$RANDOM % ${#colors[@]}]}
  clear
  echo -e "\e[1;${color}m"
  echo "╔═══════════════════════════════════════════════╗"
  echo "║         DNS Management Script v1.2.3         ║"
  echo "║         Admin: @MahdiAGM0                    ║"
  echo "║         Telegram: @Academi_vpn               ║"
  echo "╚═══════════════════════════════════════════════╝"
  echo -e "\e[0m"
}

# Show main menu
show_menu() {
  show_title
  echo "📌 Choose an option:"
  echo "1️⃣  Premium DNS (New)"
  echo "2️⃣  Ping a DNS"
  echo "3️⃣  Search Game DNS (New)"
  echo "4️⃣  Gaming DNS"
  echo "5️⃣  Download DNS"
  echo "0️⃣  Exit"
  echo -n "👉 Enter your choice: "
  read choice
  case $choice in
    1) premium_dns ;;
    2) ping_dns ;;
    3) search_game ;;
    4) show_dns "dns_gaming.txt" ;;
    5) show_dns "dns_download.txt" ;;
    0) exit 0 ;;
    *) echo "❌ Invalid choice."; sleep 1; show_menu ;;
  esac
}

# Read and show 2 random DNS from file
show_dns() {
  show_title
  file=$1
  if [[ ! -f "$file" ]]; then
    echo "❌ DNS list file '$file' not found!"
    read -p "Press Enter to return..." ; show_menu
    return
  fi
  echo "📡 DNS Suggestions:"
  shuf -n 2 "$file" | while read dns; do
    ping_time=$(ping -c 1 -W 1 "$dns" | grep time= | awk -F"time=" '{print $2}' | cut -d' ' -f1)
    echo -e "🔹 $dns  (Ping: ${ping_time:-Fail})"
  done
  echo ""
  read -p "Press Enter to return..." ; show_menu
}

# Premium DNS (from both files)
premium_dns() {
  show_title
  echo "✨ Premium DNS:"
  (cat dns_gaming.txt; cat dns_download.txt) 2>/dev/null | shuf -n 2 | while read dns; do
    ping_time=$(ping -c 1 -W 1 "$dns" | grep time= | awk -F"time=" '{print $2}' | cut -d' ' -f1)
    echo -e "⭐ $dns  (Ping: ${ping_time:-Fail})"
  done
  echo ""
  read -p "Press Enter to return..." ; show_menu
}

# Ping a custom DNS
ping_dns() {
  show_title
  read -p "🌐 Enter DNS to ping: " user_dns
  echo ""
  echo "⏱️ Pinging $user_dns..."
  ping -c 3 -W 1 "$user_dns"
  echo ""
  read -p "Press Enter to return..." ; show_menu
}

# Search game and show DNS
search_game() {
  show_title
  if [[ ! -f "games_list.txt" ]]; then
    echo "❌ 'games_list.txt' not found."
    read -p "Press Enter to return..." ; show_menu
    return
  fi
  read -p "🎮 Enter game name to search: " game
  found=$(grep -i "$game" games_list.txt)
  if [[ -z "$found" ]]; then
    echo -e "\e[1;33m⚠️ Game not found.\e[0m"
  else
    echo -e "\n📍 Game Found: $found"
    echo "🌍 Choose Region:"
    select region in Iran UAE Turkey Other; do
      case $region in
        Iran|UAE|Turkey|Other)
          echo -e "\n🌐 DNS for $found ($region):"
          shuf -n 2 dns_gaming.txt | while read dns; do
            ping_time=$(ping -c 1 -W 1 "$dns" | grep time= | awk -F"time=" '{print $2}' | cut -d' ' -f1)
            echo -e "🔹 $dns  (Ping: ${ping_time:-Fail})"
          done
          break ;;
        *) echo "❌ Invalid option." ;;
      esac
    done
  fi
  echo ""
  read -p "Press Enter to return..." ; show_menu
}

# Start script
show_menu
