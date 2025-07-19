#!/bin/bash

# Define colors
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
RED='\033[1;31m'
NC='\033[0m'

# Typing animation
typer() {
  text="$1"
  for ((i = 0; i < ${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.008
  done
  echo ""
}

# Header with animated color
print_header() {
  clear
  rand=$((RANDOM % 6))
  case $rand in
    0) color=$RED ;;
    1) color=$GREEN ;;
    2) color=$YELLOW ;;
    3) color=$BLUE ;;
    4) color=$CYAN ;;
    5) color=$NC ;;
  esac
  echo -e "${color}"
  figlet "DNS Script" 2>/dev/null | lolcat
  echo -e "${NC}"
  echo -e "+------------------------------------------+"
  echo -e "| Telegram: @Academi_vpn                   |"
  echo -e "| Admin:    @MahdiAGM0                     |"
  echo -e "| Version:  1.2.3                          |"
  echo -e "+------------------------------------------+"
}

# Sample DNS lists
gaming_dns=("1.1.1.1" "8.8.8.8" "9.9.9.9" "1.0.0.1" "185.51.200.2" "185.51.200.3")
download_dns=("176.103.130.130" "94.140.14.14" "94.140.15.15" "208.67.222.222")
premium_dns=("8.26.56.26" "8.20.247.20" "185.228.168.9" "185.228.169.9")

# 50 mobile games
games=(
  "PUBG Mobile" "Call of Duty Mobile" "Free Fire" "Clash of Clans"
  "Clash Royale" "Arena Breakout (NEW)" "Brawl Stars (NEW)" "Mobile Legends"
  "League of Legends: Wild Rift" "Fortnite" "Apex Legends Mobile"
  "Genshin Impact" "Among Us" "Minecraft PE" "Roblox" "Pokemon GO"
  "Subway Surfers" "Asphalt 9" "Dead by Daylight Mobile" "Honkai Impact 3"
  "Dragon Ball Legends" "Identity V" "Valorant Mobile (NEW)" "Standoff 2"
  "World of Tanks Blitz" "Shadowgun Legends" "Modern Combat 5"
  "Critical Ops" "Garena AOV" "Lost Light (NEW)" "T3 Arena"
  "Cyber Hunter" "Warface: Global Ops" "Diablo Immortal"
  "Rise of Kingdoms" "AFK Arena" "State of Survival"
  "King of Avalon" "Summoners War" "Infinity Kingdom"
  "Hero Wars" "War Robots" "Doom & Destiny" "N.O.V.A. Legacy"
  "Grimvalor" "Eternium" "Bullet Echo" "Sky: Children of Light"
  "Rebel Racing" "Crossfire: Legends"
)

countries=("Iran" "UAE" "Turkey" "Qatar" "Other")

# Show two DNS with ping
show_dns_pair() {
  dns1="$1"
  dns2="$2"

  ping1=$(ping -c 1 -W 1 "$dns1" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
  ping2=$(ping -c 1 -W 1 "$dns2" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)

  echo -e "\nPrimary DNS:\n$dns1\nPing: ${GREEN}${ping1:-Failed}${NC}"
  echo -e "\nSecondary DNS:\n$dns2\nPing: ${GREEN}${ping2:-Failed}${NC}"
}

while true; do
  print_header
  typer "Select an option:"
  echo -e "${CYAN}
1) 🎮 Gaming DNS (NEW)
2) 📥 Download DNS (NEW)
3) 🔍 Search Game (NEW)
4) 💎 Premium DNS (NEW)
5) 📡 Ping DNS (NEW)
6) ❌ Exit
${NC}"
  read -p "Enter choice: " choice
  case $choice in

    1)
      print_header
      typer "🎮 Gaming DNS"
      echo -e "\nChoose a game:"
      select g in "${games[@]}"; do
        echo -e "\n🌍 Select Region:"
        select reg in "${countries[@]}"; do
          dns1="${gaming_dns[$RANDOM % ${#gaming_dns[@]}]}"
          dns2="${gaming_dns[$RANDOM % ${#gaming_dns[@]}]}"
          echo -e "\n🎯 DNS for $g in $reg:"
          show_dns_pair "$dns1" "$dns2"
          break
        done
        break
      done
      read -p $'\nPress Enter to return...'
      ;;

    2)
      print_header
      typer "📥 Download DNS"
      echo -e "\n🌍 Select Region:"
      select reg in "${countries[@]}"; do
        dns1="${download_dns[$RANDOM % ${#download_dns[@]}]}"
        dns2="${download_dns[$RANDOM % ${#download_dns[@]}]}"
        echo -e "\n📦 DNS for $reg:"
        show_dns_pair "$dns1" "$dns2"
        break
      done
      read -p $'\nPress Enter to return...'
      ;;

    3)
      print_header
      typer "🔍 Game Search"
      read -p "Enter game name: " query
      found=false
      for game in "${games[@]}"; do
        if [[ "$game" == *"$query"* ]]; then
          found=true
          echo -e "\nFound: $game"
          echo -e "\n🌍 Select Region:"
          select reg in "${countries[@]}"; do
            dns1="${gaming_dns[$RANDOM % ${#gaming_dns[@]}]}"
            dns2="${gaming_dns[$RANDOM % ${#gaming_dns[@]}]}"
            echo -e "\n🎯 DNS for $game in $reg:"
            show_dns_pair "$dns1" "$dns2"
            break
          done
          break
        fi
      done
      if ! $found; then
        echo -e "${YELLOW}Game not found.${NC}"
      fi
      read -p $'\nPress Enter to return...'
      ;;

    4)
      print_header
      typer "💎 Premium DNS"
      dns1="${premium_dns[$RANDOM % ${#premium_dns[@]}]}"
      dns2="${premium_dns[$RANDOM % ${#premium_dns[@]}]}"
      show_dns_pair "$dns1" "$dns2"
      read -p $'\nPress Enter to return...'
      ;;

    5)
      print_header
      read -p "Enter DNS to ping: " userdns
      show_dns_pair "$userdns" "$userdns"
      read -p $'\nPress Enter to return...'
      ;;

    6)
      echo -e "${GREEN}Goodbye!${NC}"
      exit 0
      ;;

    *)
      echo -e "${RED}Invalid option${NC}"
      ;;
  esac
done
