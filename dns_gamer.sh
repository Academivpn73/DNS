#!/bin/bash

# Auto-install dependencies
for pkg in curl ping figlet lolcat; do
  if ! command -v $pkg &>/dev/null; then
    echo "Installing $pkg..."
    apt update -y &>/dev/null
    apt install -y $pkg &>/dev/null
  fi
done

# Color cycling
colors=(31 32 33 34 35 36)

# Typing animation
function typer() {
  text="$1"
  for ((i = 0; i < ${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.0008
  done
  echo
}

# Header with color and animation
function print_header() {
  clear
  color=${colors[$RANDOM % ${#colors[@]}]}
  echo -e "\033[1;${color}m"
  figlet -f slant "DNS Gamer Pro" | lolcat
  echo -e "\033[0m"
  echo -e "\033[1;${color}m+------------------------------------------+\033[0m"
  echo -e "\033[1;${color}m| Telegram: @Academi_vpn                   |\033[0m"
  echo -e "\033[1;${color}m| Admin:    @MahdiAGM0                     |\033[0m"
  echo -e "\033[1;${color}m| Version:  1.2.3                          |\033[0m"
  echo -e "\033[1;${color}m+------------------------------------------+\033[0m"
  echo
}

# DNS Lists
gaming_dns=("1.1.1.1" "9.9.9.9" "94.140.14.14" "76.76.2.0" "8.26.56.26")
download_dns=("178.22.122.100" "185.51.200.2" "10.202.10.202" "1.0.0.1")
premium_dns=("45.90.28.0" "1.1.1.1" "94.140.14.14" "9.9.9.11" "8.8.4.4" "8.26.56.26" "208.67.222.222")

games=("Call of Duty Mobile" "Arena Breakout (New)" "PUBG Mobile" "Free Fire" "Mobile Legends" "Brawl Stars" "Clash Royale" "Clash of Clans" "Fortnite Mobile" "War Robots" "League of Legends Wild Rift" "Apex Legends Mobile" "Among Us" "FIFA Mobile" "eFootball 2024" "Honkai Impact" "Genshin Impact" "Marvel Future Fight" "Modern Combat 5" "Shadowgun Legends" "World of Tanks Blitz" "Asphalt 9" "Roblox" "Zooba" "Critical Ops" "Cyber Hunter" "Dead by Daylight Mobile" "Dragon Ball Legends" "Garena AOV" "Hero Hunters" "Last Day on Earth" "Mobile Suit Gundam" "Minecraft PE" "Omega Legends" "Pixel Gun 3D" "Rogue Company Mobile" "Sky Children of the Light" "Standoff 2" "Tacticool" "Teamfight Tactics" "Tower of Fantasy" "Vainglory" "Warface Mobile" "Wild Rift" "ZombsRoyale" "World War Heroes" "Modern Strike" "Battle Prime" "Creative Destruction")

countries=("Iran" "UAE" "Turkey" "Saudi Arabia" "Iraq")

# DNS Show Function
function show_dns() {
  dns="$1"
  ping_result=$(ping -c 1 -W 1 $dns 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
  if [[ -z "$ping_result" ]]; then
    ping_result="Ping failed"
  else
    ping_result="${ping_result}ms"
  fi
  echo -e "\n\033[1;37m$dns\033[0m"
  echo -e "Ping: \033[1;32m$ping_result\033[0m"
}

# Menu
while true; do
  print_header
  typer "📌 Choose an option:"
  typer "1️⃣  Gaming DNS"
  typer "2️⃣  Download DNS (Anti-Filter)"
  typer "3️⃣  Search Game DNS  🔍 New"
  typer "4️⃣  Premium DNS  💎 New"
  typer "5️⃣  Ping a DNS     📶 New"
  typer "6️⃣  Exit ❌"
  read -p $'\nEnter your choice: ' opt

  case $opt in
    1)
      print_header
      typer "🎮 Gaming DNS Selected:"
      show_dns "${gaming_dns[$RANDOM % ${#gaming_dns[@]}]}"
      read -p $'\nPress Enter to return...'
      ;;
    2)
      print_header
      typer "📥 Download DNS Selected:"
      show_dns "${download_dns[$RANDOM % ${#download_dns[@]}]}"
      read -p $'\nPress Enter to return...'
      ;;
    3)
      print_header
      typer "🔍 Search your game:"
      read -p "Enter game name: " search
      found=false
      for game in "${games[@]}"; do
        if [[ "${game,,}" == *"${search,,}"* ]]; then
          found=true
          echo -e "\nGame found: $game"
          echo "Select Region:"
          select region in "${countries[@]}"; do
            echo -e "\nRecommended DNS for $game in $region:"
            show_dns "${gaming_dns[$RANDOM % ${#gaming_dns[@]}]}"
            break
          done
        fi
      done
      if [ "$found" = false ]; then
        echo -e "\n\033[1;33mGame not found.\033[0m"
      fi
      read -p $'\nPress Enter to return...'
      ;;
    4)
      print_header
      typer "💎 Premium Ultra Fast DNS:"
      show_dns "${premium_dns[$RANDOM % ${#premium_dns[@]}]}"
      read -p $'\nPress Enter to return...'
      ;;
    5)
      print_header
      read -p "Enter DNS to ping: " user_dns
      show_dns "$user_dns"
      read -p $'\nPress Enter to return...'
      ;;
    6)
      typer "Exiting..."
      exit 0
      ;;
    *)
      echo -e "\nInvalid choice!"
      sleep 1
      ;;
  esac
done
