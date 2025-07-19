#!/bin/bash

# DNS data
declare -A DNS_GAMING
declare -A DNS_DOWNLOAD
declare -A DNS_PREMIUM

# Game list
GAMES=(
  "Call of Duty"
  "PUBG"
  "Fortnite"
  "Free Fire"
  "Clash Royale"
  "Clash of Clans"
  "Apex Legends"
  "Valorant"
  "Dota 2"
  "League of Legends"
  "CS:GO"
  "Mobile Legends"
  "Arena Breakout (New)"
  "Minecraft"
  "Among Us"
  "Overwatch"
  "Battlefield"
  "FIFA 24"
  "NBA 2K24"
  "Genshin Impact"
  "Brawl Stars"
  "Warzone"
  "Escape From Tarkov"
  "Rust"
  "Paladins"
  "Roblox"
  "Team Fortress 2"
  "Smite"
  "World of Tanks"
  "World of Warcraft"
  "Diablo IV"
  "Elden Ring"
  "Halo Infinite"
  "Rocket League"
  "Cyberpunk 2077"
  "The Division 2"
  "R6 Siege"
  "Lost Ark"
  "Destiny 2"
  "ARK"
  "Terraria"
  "Far Cry 6"
  "Hitman 3"
  "DOOM Eternal"
  "Dead by Daylight"
  "The Finals"
  "Warframe"
  "Star Wars Battlefront"
  "Sea of Thieves"
  "Monster Hunter"
  "Titanfall 2"
  "For Honor"
  "Metro Exodus"
  "Mortal Kombat 11"
  "Tekken 8"
  "Honkai Star Rail"
  "Lineage W"
  "Naraka Bladepoint"
  "Crossfire"
  "Valor Legends"
  "New World"
  "Black Desert"
  "Lost Light"
  "Point Blank"
  "Zula"
  "KartRider"
  "T3 Arena"
  "Super People"
)

# Country list
COUNTRIES=(
  "Iran"
  "Turkey"
  "Iraq"
  "Saudi Arabia"
  "UAE"
  "Qatar"
  "Egypt"
  "Jordan"
  "India"
  "Pakistan"
  "Russia"
  "Ukraine"
  "Germany"
  "France"
  "UK"
  "USA"
  "Canada"
  "Brazil"
  "Argentina"
  "Japan"
  "South Korea"
  "China"
  "Thailand"
  "Indonesia"
  "Malaysia"
  "Philippines"
  "Italy"
  "Spain"
  "Sweden"
  "Israel"
)

# Fill DNS samples
DNS_GAMING["Call of Duty,Iran"]="1.1.1.1|1.0.0.1|24ms"
DNS_GAMING["PUBG,Turkey"]="8.8.8.8|8.8.4.4|19ms"
DNS_GAMING["Arena Breakout,USA"]="9.9.9.9|149.112.112.112|18ms"

DNS_DOWNLOAD["default"]="94.140.14.14|94.140.15.15|23ms"
DNS_PREMIUM["premium"]="1.1.1.1|9.9.9.9|15ms"

print_list() {
  local -n list=$1
  echo
  for i in "${!list[@]}"; do
    printf "%2d) %s\n" $((i+1)) "${list[$i]}"
  done
}

select_game() {
  echo "🎮 Select a Game:"
  print_list GAMES
  read -p "Enter number: " game_index
  GAME="${GAMES[$((game_index-1))]}"
}

select_country() {
  echo "🌍 Select a Country:"
  print_list COUNTRIES
  read -p "Enter number: " country_index
  COUNTRY="${COUNTRIES[$((country_index-1))]}"
}

get_dns() {
  KEY="${GAME%% *},${COUNTRY}"
  ENTRY="${DNS_GAMING[$KEY]}"
  if [[ -z "$ENTRY" ]]; then
    echo "❌ No DNS found for $GAME in $COUNTRY."
  else
    IFS='|' read -r PRIMARY SECONDARY PING <<< "$ENTRY"
    echo -e "\n🌐 DNS for $GAME - $COUNTRY:"
    echo "🔹 Primary:   $PRIMARY"
    echo "🔹 Secondary: $SECONDARY"
    echo "📶 Ping:      $PING"
  fi
}

premium_dns() {
  IFS='|' read -r PRIMARY SECONDARY PING <<< "${DNS_PREMIUM["premium"]}"
  echo -e "\n💎 Premium DNS:"
  echo "🔹 Primary:   $PRIMARY"
  echo "🔹 Secondary: $SECONDARY"
  echo "📶 Ping:      $PING"
}

download_dns() {
  IFS='|' read -r PRIMARY SECONDARY PING <<< "${DNS_DOWNLOAD["default"]}"
  echo -e "\n📥 Download DNS:"
  echo "🔹 Primary:   $PRIMARY"
  echo "🔹 Secondary: $SECONDARY"
  echo "📶 Ping:      $PING"
}

search_game() {
  read -p "🔍 Enter game name: " query
  echo -e "\n📋 Search Results:"
  for i in "${!GAMES[@]}"; do
    if [[ "${GAMES[$i],,}" == *"${query,,}"* ]]; then
      echo "$((i+1))) ${GAMES[$i]}"
    fi
  done
}

ping_dns() {
  read -p "📥 Enter DNS to Ping (e.g. 1.1.1.1): " ip
  ping -c 1 -W 1 "$ip" | grep "time=" || echo "❌ Ping failed."
}

main_menu() {
  clear
  echo "====== DNS TOOL MENU ======"
  echo "1) Gaming DNS"
  echo "2) Download DNS"
  echo "3) Premium DNS"
  echo "4) Search Game"
  echo "5) Ping a DNS"
  echo "0) Exit"
  echo "============================"
  read -p "Choose option: " opt

  case "$opt" in
    1) select_game; select_country; get_dns ;;
    2) download_dns ;;
    3) premium_dns ;;
    4) search_game ;;
    5) ping_dns ;;
    0) echo "Bye!"; exit ;;
    *) echo "❌ Invalid option."; sleep 1 ;;
  esac
}

# Run
while true; do
  main_menu
  echo -e "\nPress Enter to return to menu..."
  read
done
