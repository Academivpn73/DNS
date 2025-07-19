#!/bin/bash

# Color codes
colors=(31 32 33 34 35 36)
rand_color() {
  echo ${colors[$RANDOM % ${#colors[@]}]}
}

# DNS database
declare -A dns_data
generate_dns_list() {
  for game in "${games[@]}"; do
    for country in "${countries[@]}"; do
      key="${game}_${country}"
      for i in {1..10}; do
        ip1="$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
        ip2="$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
        dns_data["$key"]+="$ip1,$ip2;"
      done
    done
  done
}

# Sample Data
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "Minecraft"
  "Apex Legends" "Free Fire" "Arena Breakout (New)" "Overwatch" "CS:GO"
  "League of Legends" "Dota 2" "FIFA 24" "eFootball" "Genshin Impact"
  "Rocket League" "Roblox" "Brawl Stars" "Clash Royale" "Mobile Legends"
  "Warzone" "Halo Infinite" "Paladins" "Smite" "Rainbow Six"
  "Among Us" "Battlefield" "Diablo IV" "Elden Ring" "Cyberpunk 2077"
  "Honkai Star Rail" "Ark Survival" "Lost Ark" "Rust" "Team Fortress 2"
  "Black Desert" "World of Tanks" "World of Warships" "Tarkov" "Naraka"
  "CrossFire" "Tera" "Destiny 2" "The Division" "Sea of Thieves"
  "GTA Online" "Red Dead Online" "Dead by Daylight" "Warframe" "Payday 3"
  "Assassin's Creed" "For Honor" "Fall Guys" "Spellbreak" "Overcooked"
  "Phasmophobia" "Back 4 Blood" "No Man's Sky" "Project Zomboid" "Scavengers"
  "Realm Royale" "Splitgate" "Quake Champions" "Killer Instinct" "Star Wars BF2"
  "Titanfall 2" "Monster Hunter" "Dark Souls III" "Naraka Bladepoint" "Trackmania"
)

countries=(
  "Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar"
  "Iraq" "Jordan" "Lebanon" "Israel" "Egypt"
  "Germany" "France" "UK" "USA" "Canada"
  "Russia" "India" "China" "Japan" "Brazil"
  "Australia" "Italy" "Spain" "Poland" "Netherlands"
  "Sweden" "Norway" "Mexico" "South Korea" "Pakistan"
)

# DNS Premium List
premium_dns_list=(
  "1.1.1.1,1.0.0.1" "9.9.9.9,149.112.112.112"
  "8.8.8.8,8.8.4.4" "94.140.14.14,94.140.15.15"
  "76.76.2.0,76.76.10.0"
)

# Download/Bypass DNS
bypass_dns_list=(
  "1.1.1.2,1.0.0.2" "8.26.56.26,8.20.247.20"
  "208.67.222.222,208.67.220.220"
)

# Utility
print_header() {
  color=$(rand_color)
  echo -e "\e[1;${color}m╭──────────────────────────────────────────────╮"
  echo -e "│  Telegram: @Academi_vpn                      │"
  echo -e "│  Admin by: Mahdi                             │"
  echo -e "│  Version: 1.2.4                              │"
  echo -e "╰──────────────────────────────────────────────╯\e[0m"
}

# Ping DNS
ping_dns() {
  clear; print_header
  read -p "🛰 Enter DNS to ping: " ip
  echo "📡 Pinging $ip..."
  ping -c 3 "$ip"
  echo ""
  read -p "Press Enter to return..."
}

# Search Game
search_game() {
  clear; print_header
  read -p "🔍 Enter game name to search: " query
  found=false
  for i in "${!games[@]}"; do
    if [[ "${games[$i],,}" == *"${query,,}"* ]]; then
      echo "🎮 [$((i+1))] ${games[$i]}"
      found=true
    fi
  done
  $found || echo "❌ Game not found."
  read -p "Press Enter to return..."
}

# Select Game
select_game() {
  echo "🎮 Select a game:"
  for i in "${!games[@]}"; do
    tag=""
    [[ "${games[$i]}" == *"(New)"* ]] && tag="\e[34m(New)\e[0m"
    printf "%2d) %s %b\n" "$((i+1))" "${games[$i]//(New)/}" "$tag"
  done
  read -p "#? " gindex
  game="${games[$((gindex-1))]}"
}

# Select Country
select_country() {
  echo -e "\n🌍 Select country:"
  for i in "${!countries[@]}"; do
    printf "%2d) %s\n" "$((i+1))" "${countries[$i]}"
  done
  read -p "#? " cindex
  country="${countries[$((cindex-1))]}"
}

# Show DNS for Game + Country
show_dns() {
  key="${game}_${country}"
  dns_pool="${dns_data[$key]}"
  if [[ -z "$dns_pool" ]]; then
    echo "❌ No DNS found for $game in $country"
  else
    IFS=';' read -ra entries <<< "$dns_pool"
    pick="${entries[$RANDOM % ${#entries[@]}]}"
    IFS=',' read -ra dns <<< "$pick"
    echo "🎯 Game: $game - $country"
    echo "🔹 Primary DNS  : ${dns[0]}"
    echo "🔹 Secondary DNS: ${dns[1]}"
    echo "📶 Ping DNS..."
    ping -c 1 -W 1 "${dns[0]}" | grep time || echo "⚠️ Ping failed"
  fi
  echo ""
  read -p "Press Enter to return..."
}

# Premium DNS
show_premium_dns() {
  clear; print_header
  pick="${premium_dns_list[$RANDOM % ${#premium_dns_list[@]}]}"
  IFS=',' read -ra dns <<< "$pick"
  echo "🌟 Premium DNS:"
  echo "🔹 Primary: ${dns[0]}"
  echo "🔹 Secondary: ${dns[1]}"
  ping -c 1 -W 1 "${dns[0]}" | grep time || echo "⚠️ Ping failed"
  echo ""
  read -p "Press Enter to return..."
}

# Bypass/Download DNS
show_bypass_dns() {
  clear; print_header
  pick="${bypass_dns_list[$RANDOM % ${#bypass_dns_list[@]}]}"
  IFS=',' read -ra dns <<< "$pick"
  echo "📦 Download / Bypass DNS:"
  echo "🔹 Primary: ${dns[0]}"
  echo "🔹 Secondary: ${dns[1]}"
  ping -c 1 -W 1 "${dns[0]}" | grep time || echo "⚠️ Ping failed"
  echo ""
  read -p "Press Enter to return..."
}

# Main Menu
main_menu() {
  while true; do
    clear; print_header
    echo "1) Gaming DNS"
    echo "2) Premium DNS"
    echo "3) Bypass/Download DNS"
    echo "4) Ping DNS"
    echo "5) Search Game"
    echo "0) Exit"
    read -p "Choose: " opt
    case "$opt" in
      1) clear; print_header; select_game; select_country; show_dns ;;
      2) show_premium_dns ;;
      3) show_bypass_dns ;;
      4) ping_dns ;;
      5) search_game ;;
      0) break ;;
      *) echo "❌ Invalid"; sleep 1 ;;
    esac
  done
}

# Run
generate_dns_list
main_menu
