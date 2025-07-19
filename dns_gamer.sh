#!/bin/bash

# ------------ Header Box ------------
colors=(31 32 33 34 35 36 91 92 93 94 95 96)
random_color=${colors[$RANDOM % ${#colors[@]}]}

clear
echo -e "\e[${random_color}m+---------------------------------------+\e[0m"
echo -e "\e[${random_color}m|  Telegram: @Academi_vpn               |\e[0m"
echo -e "\e[${random_color}m|  Admin by: Mahdi                      |\e[0m"
echo -e "\e[${random_color}m|  Version: 1.2.4                       |\e[0m"
echo -e "\e[${random_color}m+---------------------------------------+\e[0m"
echo ""

# ------------ Static Game List ------------
games=(
"Call of Duty"
"Free Fire"
"PUBG"
"Clash of Clans"
"Fortnite"
"Arena Breakout (New)"
"Valorant"
"League of Legends"
"Mobile Legends"
"Apex Legends"
"Overwatch"
"Rocket League"
"CS:GO"
"Genshin Impact"
"Roblox"
"Minecraft"
"FIFA"
"eFootball"
"Brawl Stars"
"World of Tanks"
)

# ------------ Static Country List ------------
countries=(
"Iran"
"Turkey"
"Saudi Arabia"
"Iraq"
"Qatar"
"UAE"
"Egypt"
"Jordan"
"Germany"
"United States"
)

# ------------ Fake DNS Bank (per Game/Country) ------------
declare -A dns_database
for game in "${games[@]}"; do
  for country in "${countries[@]}"; do
    dns_list=()
    for i in {1..30}; do
      ip1=$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255))
      dns_list+=("$ip1")
    done
    dns_database["$game|$country"]="${dns_list[*]}"
  done
done

# ------------ Show Game List ------------
show_games() {
  echo -e "\n🎮 Select a Game:"
  index=1
  for game in "${games[@]}"; do
    if [[ "$game" == *"(New)"* ]]; then
      echo -e "$index) \e[34m$game\e[0m"
    else
      echo "$index) $game"
    fi
    ((index++))
  done
}

# ------------ Show Country List ------------
show_countries() {
  echo -e "\n📋 Select your country:"
  index=1
  for country in "${countries[@]}"; do
    echo "$index) $country"
    ((index++))
  done
}

# ------------ Get DNS ------------
get_dns() {
  show_games
  read -p "Game Number: " game_index
  show_countries
  read -p "Country Number: " country_index

  game="${games[$((game_index-1))]}"
  country="${countries[$((country_index-1))]}"

  dns_key="$game|$country"
  dns_string="${dns_database[$dns_key]}"
  IFS=' ' read -r -a dns_array <<< "$dns_string"

  if [ ${#dns_array[@]} -lt 2 ]; then
    echo "❌ No DNS found for $game in $country"
    return
  fi

  primary_dns=${dns_array[$RANDOM % ${#dns_array[@]}]}
  secondary_dns=${dns_array[$RANDOM % ${#dns_array[@]}]}
  ping_time=$((20 + RANDOM % 40))

  echo -e "\n🌐 DNS for \e[33m$game\e[0m - \e[32m$country\e[0m:"
  echo -e "🟢 Primary DNS: $primary_dns"
  echo -e "🔵 Secondary DNS: $secondary_dns"
  echo -e "📶 Ping: ${ping_time}ms"
}

# ------------ DNS Premium ------------
dns_premium() {
  dns1="9.9.9.9"
  dns2="1.1.1.2"
  echo -e "\n👑 Premium DNS:"
  echo "🟢 Primary: $dns1"
  echo "🔵 Secondary: $dns2"
  echo "📶 Ping: 23ms"
}

# ------------ Ping Custom DNS ------------
ping_dns() {
  read -p "Enter DNS IP to ping: " ip
  echo -e "\n📡 Pinging $ip..."
  ping -c 3 $ip | tail -2
}

# ------------ Search Game ------------
search_game() {
  read -p "Enter keyword to search: " keyword
  echo -e "\n🔍 Search Results:"
  index=1
  for game in "${games[@]}"; do
    if [[ "$game" == *"$keyword"* ]]; then
      echo "$index) $game"
    fi
    ((index++))
  done
}

# ------------ Main Menu ------------
while true; do
  echo -e "\n📘 Menu:"
  echo "1) Get Gaming DNS"
  echo "2) Premium DNS"
  echo "3) Ping a DNS"
  echo "4) Search Game"
  echo "0) Exit"
  read -p "Choose: " opt

  case $opt in
    1) get_dns ;;
    2) dns_premium ;;
    3) ping_dns ;;
    4) search_game ;;
    0) exit ;;
    *) echo "Invalid option!" ;;
  esac
done
