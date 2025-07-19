#!/bin/bash

# Colors
colors=(31 32 33 34 35 36)
random_color=${colors[$RANDOM % ${#colors[@]}]}
reset="\e[0m"
bold="\e[1m"
title_color="\e[1;${random_color}m"

# GitHub DNS file
DNS_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_list.txt"

# Title
show_title() {
  clear
  echo -e "${title_color}"
  echo "╔═══════════════════════════════════════════════╗"
  echo "║         Academi VPN DNS Tool v1.2.3          ║"
  echo "║      Admin: @MahdiAGM0 | TG: @Academi_vpn     ║"
  echo "╚═══════════════════════════════════════════════╝"
  echo -e "${reset}"
}

# List of top 50 games (partial for example)
declare -a games=(
"PUBG Mobile"
"Call of Duty Mobile"
"Free Fire"
"Clash of Clans"
"Mobile Legends"
"Fortnite"
"Apex Legends Mobile"
"Brawl Stars"
"Valorant"
"Warzone Mobile"
"Roblox"
"Among Us"
"FIFA Mobile"
"Asphalt 9"
"Rocket League Sideswipe"
"Diablo Immortal"
"Genshin Impact"
"League of Legends: Wild Rift"
"Pokemon Unite"
"New State Mobile"
"Honor of Kings"
"Marvel Snap"
"Subway Surfers"
"Temple Run"
"8 Ball Pool"
"Real Racing 3"
"Clash Royale"
"Cyber Hunter"
"World of Tanks Blitz"
"Zula Mobile"
"Critical Ops"
"Modern Combat 5"
"Garena AOV"
"Summoners War"
"Dragon Ball Legends"
"Minion Rush"
"Dream League Soccer"
"eFootball PES"
"Shadowgun Legends"
"Call of Dragons"
"Rebel Inc"
"Dead Trigger 2"
"Shadow Fight 4"
"Magic Rampage"
"Sky: Children of the Light"
"Tower of Fantasy"
"Albion Online"
"N.O.V.A. Legacy"
"Legends of Runeterra"
)

# List of countries
countries=("Iran" "UAE" "Turkey" "Qatar" "Saudi Arabia" "Iraq" "Jordan" "Global")

# Search & show DNS
search_dns() {
  show_title
  echo -e "${bold}🔍 Enter game name to search:${reset}"
  read -p "Game: " game_input

  match_found=false
  for game in "${games[@]}"; do
    if [[ "${game,,}" == *"${game_input,,}"* ]]; then
      match_found=true
      echo -e "\n✅ Game Found: ${bold}$game${reset}"
      echo -e "\n🌍 Select Country:"
      for i in "${!countries[@]}"; do
        echo "$((i+1)). ${countries[$i]}"
      done

      read -p "Enter number: " region_index
      selected_country="${countries[$((region_index-1))]}"

      dns_line=$(curl -s "$DNS_URL" | grep -i "$game" | grep -i "$selected_country" | shuf -n 1)
      if [[ -z "$dns_line" ]]; then
        echo -e "${bold}⚠️ No DNS found for this game and country.${reset}"
      else
        dns1=$(echo "$dns_line" | cut -d',' -f3)
        dns2=$(echo "$dns_line" | cut -d',' -f4)
        echo -e "\n🎯 ${bold}DNS for $game in $selected_country:${reset}"
        echo "Primary:   $dns1"
        echo "Secondary: $dns2"

        ping=$(ping -c 1 -W 1 "$dns1" | grep time= | awk -F'time=' '{print $2}' | awk '{print $1}')
        [[ -z "$ping" ]] && ping="Unavailable"
        echo -e "Ping: ${bold}$ping ms${reset}"
      fi
      break
    fi
  done

  if [ "$match_found" = false ]; then
    echo -e "${bold}\n⚠️ Game not found.${reset}"
  fi
  echo -e "\nPress Enter to return..."
  read
}

# Menu
main_menu() {
  while true; do
    show_title
    echo -e "${bold}Choose an option:${reset}"
    echo "1) 🌐 Premium DNS"
    echo "2) 📶 Ping DNS"
    echo "3) 🔍 Search Game DNS"
    echo "0) ❌ Exit"
    read -p "Your choice: " choice

    case $choice in
      1)
        dns_line=$(curl -s "$DNS_URL" | shuf -n 1)
        dns1=$(echo "$dns_line" | cut -d',' -f3)
        dns2=$(echo "$dns_line" | cut -d',' -f4)
        echo -e "\n💎 Premium DNS:"
        echo "Primary:   $dns1"
        echo "Secondary: $dns2"
        ;;
      2)
        read -p "Enter DNS to ping: " dns
        ping=$(ping -c 1 -W 1 "$dns" | grep time= | awk -F'time=' '{print $2}' | awk '{print $1}')
        [[ -z "$ping" ]] && ping="Unavailable"
        echo -e "Ping: ${bold}$ping ms${reset}"
        ;;
      3)
        search_dns
        ;;
      0)
        echo "Bye!"
        exit
        ;;
      *)
        echo "❌ Invalid choice."
        ;;
    esac
    echo -e "\nPress Enter to return..."
    read
  done
}

main_menu
