#!/bin/bash

VERSION="1.2.3"

COLORS=(31 32 33 34 35 36 91 92 93 94 95 96 97)

# انیمیشن تایپ
type_animation() {
  text=$1
  delay=0.008
  for ((i=0; i<${#text}; i++)); do
    echo -ne "${text:$i:1}"
    sleep $delay
  done
  echo
}

random_color() {
  echo "${COLORS[$RANDOM % ${#COLORS[@]}]}"
}

show_title() {
  clear
  color=$(random_color)
  echo -e "\e[1;${color}m"
  type_animation "╔════════════════════════════════════════╗"
  type_animation "║         Gaming DNS Manager v$VERSION         ║"
  type_animation "╠════════════════════════════════════════╣"
  type_animation "║ Telegram: @Academi_vpn                 ║"
  type_animation "║ Admin:    @MahdiAGM0                   ║"
  type_animation "╚════════════════════════════════════════╝"
  echo -e "\e[0m"
}

# تست پینگ
ping_dns() {
  read -p "Enter DNS to test: " dns
  echo -e "\nTesting ping to $dns..."
  ping -c 4 "$dns"
  echo -e "\nPress Enter to return to main menu..."
  read
}

get_premium_dns() {
  dns_list=(
    "94.140.14.14,94.140.15.15"
    "91.239.100.100,89.233.43.71"
    "185.228.168.9,185.228.169.9"
    "45.90.28.0,45.90.30.0"
  )
  dns_pair=${dns_list[$RANDOM % ${#dns_list[@]}]}
  dns1=$(echo "$dns_pair" | cut -d',' -f1)
  dns2=$(echo "$dns_pair" | cut -d',' -f2)
  echo -e "\nYour Premium DNS:"
  echo "Primary:   $dns1"
  echo "Secondary: $dns2"
  echo -e "\nPress Enter to return..."
  read
}

download_dns_by_country() {
  countries=("Iran" "Germany" "France" "Singapore" "USA" "Netherlands")
  echo -e "\nChoose Country:"
  for i in "${!countries[@]}"; do
    echo "  [$((i+1))] ${countries[$i]}"
  done
  read -p "Enter country number: " country_num
  case $country_num in
    1) dns1="10.202.10.11"; dns2="10.202.10.10" ;;
    2) dns1="64.6.64.6"; dns2="64.6.65.6" ;;
    3) dns1="156.154.70.2"; dns2="156.154.71.2" ;;
    4) dns1="159.250.35.250"; dns2="159.250.35.251" ;;
    5) dns1="8.8.8.8"; dns2="8.8.4.4" ;;
    6) dns1="1.1.1.1"; dns2="1.0.0.1" ;;
    *) echo "Invalid."; return ;;
  esac
  echo -e "\nDownload DNS:"
  echo "Primary:   $dns1"
  echo "Secondary: $dns2"
  echo -e "\nPress Enter to return..."
  read
}

games=(
  "Call of Duty"
  "PUBG"
  "Fortnite"
  "Apex Legends"
  "Valorant"
  "League of Legends"
  "Dota 2"
  "CS:GO"
  "Overwatch"
  "Minecraft"
  "Warzone"
  "Rocket League"
  "Free Fire"
  "GTA Online"
  "Rainbow Six Siege"
  "Mobile Legends"
  "Clash of Clans"
  "Clash Royale"
  "Brawl Stars"
  "FIFA"
  "PES"
  "Battlefield"
  "Roblox"
  "World of Tanks"
  "World of Warcraft"
  "Destiny 2"
  "Arena Breakout (New)"
  "Rust"
  "Paladins"
  "Smite"
  "Escape from Tarkov"
)

countries=("Iran" "Turkey" "UAE" "Qatar" "Iraq" "Jordan")

random_dns() {
  echo "Primary:   185.55.$((RANDOM%100+100)).$((RANDOM%100+1))"
  echo "Secondary: 185.55.$((RANDOM%100+100)).$((RANDOM%100+1))"
}

gaming_dns_menu() {
  echo -e "\nChoose Game:"
  for i in "${!games[@]}"; do
    num=$((i+1))
    if [[ "${games[$i]}" == *"Arena Breakout"* ]]; then
      echo -e "  [$num] \e[1;34m${games[$i]}\e[0m"
    else
      echo "  [$num] ${games[$i]}"
    fi
  done
  read -p "Enter game number: " game_index
  [[ $game_index -lt 1 || $game_index -gt ${#games[@]} ]] && echo "Invalid game." && return
  game="${games[$((game_index-1))]}"
  echo -e "\nSelect Country:"
  for i in "${!countries[@]}"; do
    echo "  [$((i+1))] ${countries[$i]}"
  done
  read -p "Enter country number: " country_index
  country="${countries[$((country_index-1))]}"
  echo -e "\nDNS for $game - $country:"
  random_dns
  echo -e "\nPress Enter to return..."
  read
}

search_game() {
  read -p "Search Game: " query
  found_index=-1
  for i in "${!games[@]}"; do
    if [[ "${games[$i],,}" == *"${query,,}"* ]]; then
      found_index=$i
      break
    fi
  done

  if [[ $found_index -eq -1 ]]; then
    echo -e "\e[1;32m\n❌ Game not found!\e[0m"
    echo -e "\nPress Enter to return..."
    read
    return
  fi

  game="${games[$found_index]}"
  echo -e "\nFound: $game"
  echo -e "Select Country:"
  for i in "${!countries[@]}"; do
    echo "  [$((i+1))] ${countries[$i]}"
  done
  read -p "Enter country number: " country_index
  country="${countries[$((country_index-1))]}"
  echo -e "\nDNS for $game - $country:"
  random_dns
  echo -e "\nPress Enter to return..."
  read
}

main_menu() {
  while true; do
    show_title
    type_animation "Version: $VERSION"
    echo
    echo "  [1] Gaming DNS 🎮"
    echo "  [2] Download DNS ⬇️"
    echo "  [3] Premium DNS 💎"
    echo "  [4] Ping a DNS 📡"
    echo "  [5] Search Game 🔍"
    echo "  [0] Exit ❌"
    echo
    read -p "Choose an option: " opt
    case $opt in
      1) gaming_dns_menu ;;
      2) download_dns_by_country ;;
      3) get_premium_dns ;;
      4) ping_dns ;;
      5) search_game ;;
      0) echo -e "\nGoodbye 👋"; exit ;;
      *) echo "Invalid option." ;;
    esac
  done
}

main_menu
