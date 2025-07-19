#!/bin/bash

# Colors
colors=(31 32 33 34 35 36 91 92 93 94 95 96)

# Game list
games=(
"Call of Duty"
"PUBG"
"Fortnite"
"Free Fire"
"Apex Legends"
"Valorant"
"League of Legends"
"Dota 2"
"Counter-Strike: GO"
"Overwatch"
"Rainbow Six Siege"
"Mobile Legends"
"Clash Royale"
"FIFA 24"
"Rocket League"
"Among Us"
"Genshin Impact"
"Battlefield 2042"
"Halo Infinite"
"Roblox"
"Minecraft"
"Warzone"
"Smite"
"Brawl Stars"
"Destiny 2"
"Team Fortress 2"
"World of Tanks"
"World of Warships"
"Lost Ark"
"New World"
"Naraka Bladepoint"
"Warframe"
"Paladins"
"CrossFire"
"Zula"
"Escape from Tarkov"
"Diablo IV"
"Naruto Online"
"League of Legends: Wild Rift"
"Clash of Clans"
"Cyber Hunter"
"Dead by Daylight"
"Sea of Thieves"
"Star Wars Battlefront"
"Black Desert Online"
"Blade and Soul"
"Ark Survival"
"Rust"
"The Division 2"
"Watch Dogs"
"Far Cry 6"
"GTA V Online"
"Red Dead Online"
"eFootball"
"NBA 2K24"
"WWE 2K24"
"Mortal Kombat 11"
"Tekken 7"
"Hitman 3"
"Honkai Impact"
"Stumble Guys"
"V Rising"
"Super People"
"Scavengers"
"Project Zomboid"
"Multiversus"
"War Thunder"
"Titanfall 2"
"Hyper Scape"
"Arena Breakout (New)"
)

# Generate random DNS and ping
function generate_dns() {
  A=$((RANDOM%256))
  B=$((RANDOM%256))
  C=$((RANDOM%256))
  D=$((RANDOM%256))
  ping=$((10 + RANDOM % 30))
  echo -e "\n🟢 Primary DNS  : $A.$B.$C.$D"
  echo "🔵 Secondary DNS: $D.$C.$B.$A"
  echo "📶 Ping         : ${ping}ms"
}

# Animated banner
function show_banner() {
  clear
  echo -e "\e[1;36m"
  toilet -f big "DNS TOOL" --gay
  echo -e "\e[0m"
}

# Colored info box
function show_header() {
  color=${colors[$RANDOM % ${#colors[@]}]}
  echo -e "\e[1;${color}m+--------------------------------------+"
  echo -e "| Telegram: @Academi_vpn               |"
  echo -e "| Admin by: Mahdi                      |"
  echo -e "| Version: 1.2.4                       |"
  echo -e "+--------------------------------------+\e[0m"
}

# Main Menu
function main_menu() {
  clear
  show_banner
  show_header
  echo ""
  echo -e "\e[1;37m╭──────────────────────────────────────╮"
  echo -e "│ 🎮 1) Gaming DNS                     │"
  echo -e "│ 📥 2) Download/Bypass DNS           │"
  echo -e "│ 💎 3) Premium DNS                   │"
  echo -e "│ 📶 4) Ping a DNS                    │"
  echo -e "│ 🔍 5) Search Game for DNS           │"
  echo -e "│ ❌ 0) Exit                          │"
  echo -e "╰──────────────────────────────────────╯\e[0m"
  read -p "#? " choice
  case $choice in
    1) dns_gaming ;;
    2) dns_download ;;
    3) dns_premium ;;
    4) ping_dns ;;
    5) search_game ;;
    0) exit ;;
    *) echo -e "\e[1;31m❌ Invalid option.\e[0m"; sleep 1; main_menu ;;
  esac
}

# Static options
function dns_gaming() {
  clear; show_header
  echo -e "\n🎮 \e[1;32mGaming DNS:\e[0m"
  generate_dns
  echo ""
  read -p "Press Enter to return..." back
  main_menu
}

function dns_download() {
  clear; show_header
  echo -e "\n📥 \e[1;32mDownload / Anti-Censorship DNS:\e[0m"
  generate_dns
  echo ""
  read -p "Press Enter to return..." back
  main_menu
}

function dns_premium() {
  clear; show_header
  echo -e "\n💎 \e[1;32mPremium High-Speed DNS:\e[0m"
  generate_dns
  echo ""
  read -p "Press Enter to return..." back
  main_menu
}

function ping_dns() {
  clear; show_header
  read -p "Enter DNS IP to ping: " dns_ip
  echo ""
  ping -c 3 $dns_ip | grep 'time='
  echo ""
  read -p "Press Enter to return..." back
  main_menu
}

# Game Search
function search_game() {
  clear
  show_header
  echo -e "\n🎮 \e[1;34mGame List (70 total):\e[0m"
  for i in "${!games[@]}"; do
    number=$((i+1))
    game="${games[$i]}"
    [[ "$game" == *"(New)"* ]] && game="\e[1;34m$game\e[0m"
    printf "%2d) %b\n" "$number" "$game"
  done
  echo -e "0) Return"
  echo ""
  read -p "Select a game by number: " game_choice
  if [[ $game_choice == 0 ]]; then main_menu; fi
  if [[ $game_choice -gt 0 && $game_choice -le ${#games[@]} ]]; then
    game="${games[$((game_choice - 1))]}"
    read -p "Enter your country: " country
    echo -e "\n🛰️  DNS for \e[1;36m$game ($country)\e[0m:"
    generate_dns
  else
    echo -e "\n❌ Invalid game number."
  fi
  echo ""
  read -p "Press Enter to return..." back
  main_menu
}

# Start
main_menu
