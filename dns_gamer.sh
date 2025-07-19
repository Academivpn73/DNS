#!/bin/bash

# ---------------------------------------------
# INFO BOX
# ---------------------------------------------
show_info() {
  colors=(31 32 33 34 35 36)
  color=${colors[$RANDOM % ${#colors[@]}]}
  clear
  echo -e "\e[1;${color}m╔═══════════════════════════════════════╗"
  echo -e "║  Telegram: @Academi_vpn               ║"
  echo -e "║  Admin by: Mahdi                      ║"
  echo -e "║  Version: 1.2.4                       ║"
  echo -e "╚═══════════════════════════════════════╝\e[0m"
}

# ---------------------------------------------
# GAME & COUNTRY LISTS
# ---------------------------------------------
games=(
"Call of Duty" "PUBG Mobile" "Fortnite" "Free Fire" "Valorant" "Apex Legends" "Clash of Clans"
"Clash Royale" "League of Legends" "Dota 2" "CS:GO" "Overwatch" "Mobile Legends" "Brawl Stars"
"Roblox" "Minecraft" "Genshin Impact" "Rocket League" "Warzone" "FIFA 23" "eFootball" "World of Tanks"
"World of Warships" "Destiny 2" "Paladins" "Smite" "Dead by Daylight" "Team Fortress 2"
"Battlefield 5" "Battlefield 2042" "Diablo IV" "Honkai Impact" "Naruto Blazing" "Bleach Brave Souls"
"Cyber Hunter" "Arena of Valor" "Zula" "Rust" "Escape from Tarkov" "Crossfire" "Rainbow Six Siege"
"Tanki Online" "Arena Breakout (New)" "Black Desert" "Lost Ark" "New World" "Fall Guys" "Among Us"
"Standoff 2" "War Robots" "Albion Online" "Lineage 2" "Knight Online" "Heroes of the Storm" "Spellbreak"
"Dark Souls III" "Blade and Soul" "Realm Royale" "PUBG: New State" "Tower of Fantasy" "H1Z1"
"BattleBit Remastered" "Warframe" "TrackMania" "Modern Combat 5" "Asphalt 9" "WOT Blitz" "Gods of Boom"
"Farlight 84"
)

countries=("Iran" "USA" "Germany" "UK" "Russia" "India" "Turkey" "Brazil" "Japan" "South Korea")

# ---------------------------------------------
# FUNCTIONS
# ---------------------------------------------

print_list() {
  local -n list=$1
  local title=$2
  echo -e "\n📋 Select your $title:"
  for i in "${!list[@]}"; do
    if [[ ${list[$i]} == *"(New)"* ]]; then
      echo -e "$((i+1))) \e[34m${list[$i]}\e[0m"
    else
      echo "$((i+1))) ${list[$i]}"
    fi
  done
}

generate_dns() {
  echo "$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
}

get_ping() {
  local ip=$1
  ping -c 1 -W 1 "$ip" | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}'
}

show_dns() {
  local game=$1
  local country=$2
  echo -e "\n🎮 Game: $game - $country"
  dns1=$(generate_dns)
  dns2=$(generate_dns)
  ping_time=$(get_ping "$dns1")
  echo -e "📡 DNS اولیه:    $dns1"
  echo -e "📡 DNS ثانویه:   $dns2"
  echo -e "📶 Ping:         ${ping_time:-N/A}ms"
  echo ""
  read -p "Press Enter to return to menu..."
}

search_game() {
  read -p "🔍 Enter game name to search: " query
  found=false
  for i in "${!games[@]}"; do
    if [[ "${games[$i],,}" == *"${query,,}"* ]]; then
      echo "✔ Found: $((i+1))) ${games[$i]}"
      found=true
    fi
  done
  $found || echo "❌ Not found."
  read -p "Press Enter to continue..."
}

ping_dns_custom() {
  read -p "Enter DNS to ping: " ip
  result=$(get_ping "$ip")
  echo -e "📶 Ping: ${result:-Unreachable}"
  read -p "Press Enter to continue..."
}

premium_dns() {
  dns1="9.9.9.9"
  dns2="1.1.1.1"
  ping_time=$(get_ping "$dns1")
  echo -e "\n💎 Premium DNS:"
  echo -e "📡 DNS اولیه:    $dns1"
  echo -e "📡 DNS ثانویه:   $dns2"
  echo -e "📶 Ping:         ${ping_time:-N/A}ms"
  echo ""
  read -p "Press Enter to return to menu..."
}

# ---------------------------------------------
# MAIN MENU
# ---------------------------------------------
while true; do
  show_info
  echo -e "\n📂 MAIN MENU"
  echo "1) Get Game DNS"
  echo "2) Premium DNS"
  echo "3) Search Game"
  echo "4) Ping a DNS"
  echo "5) Exit"
  read -p "#? " choice

  case $choice in
    1)
      print_list games "game"
      read -p "Choose game number: " gnum
      print_list countries "country"
      read -p "Choose country number: " cnum
      game="${games[gnum-1]}"
      country="${countries[cnum-1]}"
      show_dns "$game" "$country"
      ;;
    2) premium_dns ;;
    3) search_game ;;
    4) ping_dns_custom ;;
    5) echo "👋 Exiting..."; exit ;;
    *) echo "❌ Invalid option"; sleep 1 ;;
  esac
done
