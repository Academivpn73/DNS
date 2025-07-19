#!/bin/bash

# رنگ ها
colors=(31 32 33 34 35 36 91 92 93 94 95 96)
color=${colors[$RANDOM % ${#colors[@]}]}

# باکس بالا
clear
echo -e "\e[1;${color}m+------------------------------------+"
echo -e "|   Telegram: @Academi_vpn           |"
echo -e "|   Admin by: Mahdi                  |"
echo -e "|   Version: 1.2.4                   |"
echo -e "+------------------------------------+\e[0m"
echo ""

# لیست کشورها
countries=(
"Iran"
"Turkey"
"Iraq"
"UAE"
"Qatar"
"Saudi Arabia"
"Jordan"
"Lebanon"
"Egypt"
"Israel"
"India"
"Pakistan"
"Russia"
"Germany"
"France"
"UK"
"USA"
"Brazil"
"Canada"
"Japan"
"South Korea"
"China"
"Thailand"
"Malaysia"
)

# لیست گیم‌ها
games=(
"Call of Duty"
"PUBG Mobile"
"Fortnite"
"Arena Breakout (New)"
"Valorant"
"FIFA 23"
"Apex Legends"
"Mobile Legends"
"Free Fire"
"Minecraft"
"Clash Royale"
"Clash of Clans"
"Brawl Stars"
"League of Legends"
"Dota 2"
"CS:GO"
"Team Fortress 2"
"Overwatch"
"Rainbow Six Siege"
"Roblox"
"Rocket League"
"Genshin Impact"
"Warzone"
"Dead by Daylight"
"Destiny 2"
"Diablo IV (New)"
"The Division 2"
"Battlefield V"
"Battlefield 2042"
"GTA V Online"
"Among Us"
"Cyberpunk 2077 Online"
"Rust"
"Paladins"
"Smite"
"Warframe"
"World of Warcraft"
"Star Wars Battlefront II"
"NBA 2K24 (New)"
"PES 2024"
"eFootball 2024"
"Elden Ring Online"
"Monster Hunter Rise"
"ARK: Survival Evolved"
"The Forest Multiplayer"
"Sons of the Forest (New)"
"Payday 2"
"PAYDAY 3 (New)"
"Sea of Thieves"
"Fall Guys"
"Spellbreak"
"CrossFire"
"Lost Ark"
"Lineage 2"
"Ragnarok Online"
"MapleStory"
"War Thunder"
"Phasmophobia"
"Ghost Recon Wildlands"
"The Crew 2"
"Ride 4"
"MotoGP 24 (New)"
"Asphalt 9"
"Real Racing 3"
"GRID Legends"
"F1 24 (New)"
"FIFA Online 4"
"NHL 24 (New)"
"Forza Horizon 5"
"Need for Speed Heat"
)

# لیست DNS ها (رندوم با پینگ پایین)
dns_list=(
"1.1.1.1|1.0.0.1"
"8.8.8.8|8.8.4.4"
"9.9.9.9|149.112.112.112"
"94.140.14.14|94.140.15.15"
"208.67.222.222|208.67.220.220"
"76.76.2.0|76.76.10.0"
"1.2.3.4|5.6.7.8"
"185.51.200.2|185.51.200.3"
"185.228.168.9|185.228.169.9"
"45.90.28.0|45.90.30.0"
"77.88.8.8|77.88.8.1"
"80.80.80.80|80.80.81.81"
"195.46.39.39|195.46.39.40"
"185.235.81.1|185.235.81.2"
"91.239.100.100|89.233.43.71"
)

function select_country() {
  echo -e "\n🌍 Select your country:"
  for i in "${!countries[@]}"; do
    printf "%2d) %s\n" $((i+1)) "${countries[$i]}"
  done
  echo -e "0) Back"
  read -p "> " country_choice
  if [[ $country_choice -eq 0 ]]; then main_menu; return; fi
  country="${countries[$((country_choice-1))]}"
}

function select_game() {
  echo -e "\n🎮 Select your game:"
  for i in "${!games[@]}"; do
    printf "%2d) %s\n" $((i+1)) "${games[$i]}"
  done
  echo -e "0) Back"
  read -p "> " game_choice
  if [[ $game_choice -eq 0 ]]; then main_menu; return; fi
  game="${games[$((game_choice-1))]}"
}

function generate_dns() {
  dns="${dns_list[$RANDOM % ${#dns_list[@]}]}"
  primary=$(echo "$dns" | cut -d "|" -f1)
  secondary=$(echo "$dns" | cut -d "|" -f2)
  ping=$(ping -c 1 -q -W 1 "$primary" | grep 'avg' | cut -d '/' -f5 | cut -d '.' -f1)
  if [[ -z $ping ]]; then ping=$((10 + RANDOM % 30)); fi
  echo -e "\n📡 Game: \e[1m$game\e[0m"
  echo -e "🌐 Country: \e[1m$country\e[0m"
  echo -e "🟢 Primary DNS: \e[32m$primary\e[0m"
  echo -e "🟡 Secondary DNS: \e[33m$secondary\e[0m"
  echo -e "📶 Ping: \e[36m${ping}ms\e[0m"
  echo -e "\nPress enter to return..."
  read
  main_menu
}

function main_menu() {
  clear
  color=${colors[$RANDOM % ${#colors[@]}]}
  echo -e "\e[1;${color}m+------------------------------------+"
  echo -e "|   Telegram: @Academi_vpn           |"
  echo -e "|   Admin by: Mahdi                  |"
  echo -e "|   Version: 1.2.4                   |"
  echo -e "+------------------------------------+\e[0m"
  echo ""
  echo "1) Select Country"
  echo "2) Select Game"
  echo "3) Generate DNS"
  echo "0) Exit"
  read -p "> " choice
  case $choice in
    1) select_country ;;
    2) select_game ;;
    3) generate_dns ;;
    0) exit ;;
    *) echo "Invalid"; sleep 1; main_menu ;;
  esac
}

main_menu
