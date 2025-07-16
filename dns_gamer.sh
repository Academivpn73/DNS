#!/bin/bash

version="1.2.0"
admin="@MahdiAGM0"
channel="@Academi_vpn"

# Title animation function
show_title() {
  clear
  for frame in "🔥 Mahdi DNS Panel 🔥" "💥 Mahdi DNS Panel 💥" "✨ Mahdi DNS Panel ✨" "🚀 Mahdi DNS Panel 🚀"; do
    clear
    echo -e "\e[1;36m═══════════════════════════════════════════════"
    echo -e "\e[1;$(shuf -i 31-36 -n 1)m             $frame             \e[0m"
    echo -e "\e[1;36m═══════════════════════════════════════════════"
    echo -e "\e[1;$(shuf -i 31-36 -n 1)mTelegram:\e[0m $channel"
    echo -e "\e[1;$(shuf -i 31-36 -n 1)mAdmin:\e[0m $admin"
    echo -e "\e[1;$(shuf -i 31-36 -n 1)mVersion:\e[0m $version"
    echo -e "\e[1;36m═══════════════════════════════════════════════"
    sleep 0.2
  done
}

# Countries (Middle East)
countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Iraq" "Qatar" "Jordan" "Oman" "Kuwait" "Lebanon")

# Games (40+)
games=(
"Call of Duty Mobile"
"PUBG Mobile"
"Free Fire"
"Clash Royale"
"Mobile Legends"
"Fortnite"
"Valorant"
"League of Legends"
"CS:GO"
"Dota 2"
"Apex Legends"
"Rainbow Six Siege"
"GTA Online"
"Overwatch 2"
"FIFA 24"
"Rocket League"
"Roblox"
"Minecraft"
"Warzone"
"Genshin Impact"
"eFootball 2024"
"Dead by Daylight"
"Battlefield V"
"Halo Infinite"
"World of Tanks"
"Paladins"
"Naruto Blazing"
"Pokemon Unite"
"Brawl Stars"
"Diablo Immortal"
"Black Desert"
"Elden Ring"
"Cyberpunk 2077"
"ARK Survival"
"NBA 2K24"
"Counter Strike 2"
"Splatoon 3"
"Rogue Company"
"Warframe"
"Smite"
)

# DNS Pool (15+ per country)
declare -A dns_map
dns_map["Iran"]="178.22.122.100 185.51.200.2 10.202.10.10 10.202.10.11 78.157.42.100 185.55.226.26 185.55.225.25 185.124.116.12 185.124.115.11 10.202.10.202 89.165.37.12 10.202.10.5 178.216.248.10 10.202.10.2 195.146.56.1"
dns_map["Turkey"]="193.140.100.100 195.175.39.39 212.156.4.20 213.74.1.2 213.74.1.1 195.175.39.40 193.140.100.101 193.255.230.10 193.255.230.11 213.74.72.4 213.74.72.5 81.213.132.2 81.213.132.3 193.140.98.2 195.175.170.2"
dns_map["UAE"]="194.170.1.6 194.170.1.7 217.165.128.6 217.165.129.7 213.42.20.30 213.42.20.20 86.96.100.100 86.96.100.101 86.96.1.1 217.165.129.2 194.170.1.5 194.170.2.2 217.165.131.3 213.42.1.1 217.165.130.130"
dns_map["Saudi Arabia"]="212.26.18.41 212.26.18.42 188.47.4.10 188.47.4.4 212.118.1.1 212.118.1.2 94.96.192.10 94.96.192.11 188.47.0.1 212.26.10.10 212.26.10.11 188.48.1.1 188.48.1.2 212.118.160.1 212.118.160.2"
dns_map["Iraq"]="185.125.170.12 185.125.170.11 185.125.171.13 185.125.171.14 185.125.172.15 185.125.172.16 185.125.173.17 185.125.173.18 185.125.174.19 185.125.174.20 185.125.175.21 185.125.175.22 185.125.176.23 185.125.176.24 185.125.177.25"
dns_map["Qatar"]="212.77.192.1 212.77.192.2 212.77.192.3 212.77.192.4 212.77.192.5 212.77.192.6 212.77.192.7 212.77.192.8 212.77.192.9 212.77.192.10 212.77.192.11 212.77.192.12 212.77.192.13 212.77.192.14 212.77.192.15"
# Repeat for other countries...

# Show 15 random DNS + ping
show_dns() {
  country="$1"
  echo -e "\n\e[1;36mDNS List for \e[1;33m$country\e[1;36m:\e[0m"
  IFS=' ' read -ra all_dns <<< "${dns_map[$country]}"
  for i in $(shuf -i 0-$((${#all_dns[@]} - 1)) -n 15); do
    dns="${all_dns[$i]}"
    ping_time=$(ping -c 1 -W 1 $dns 2>/dev/null | grep 'time=' | cut -d'=' -f4 | cut -d' ' -f1)
    [ -z "$ping_time" ] && ping_time="N/A"
    echo -e "\e[1;35m•\e[0m \e[1;37m$dns\e[0m \e[1;32m(Ping: $ping_time ms)\e[0m"
  done
}

# Menu
while true; do
  show_title
  echo -e "\n\e[1;33m[1]\e[0m 🔫 Gaming DNS"
  echo -e "\e[1;36m[2]\e[0m 🚀 Download DNS"
  echo -e "\e[1;31m[0]\e[0m ❌ Exit"
  echo
  read -p "Choose an option: " opt
  case $opt in
    1)
      echo -e "\n\e[1;34mSelect Game:\e[0m"
      for i in "${!games[@]}"; do
        echo -e "\e[1;32m[$((i+1))]\e[0m ${games[$i]}"
      done
      read -p "Game number: " gnum
      selected_game="${games[$((gnum-1))]}"
      echo -e "\n\e[1;34mSelect Country:\e[0m"
      for i in "${!countries[@]}"; do
        echo -e "\e[1;35m[$((i+1))]\e[0m ${countries[$i]}"
      done
      read -p "Country number: " cnum
      selected_country="${countries[$((cnum-1))]}"
      echo -e "\n\e[1;36mSelected:\e[0m $selected_game - $selected_country"
      show_dns "$selected_country"
      read -p $'\nPress Enter to return...'
      ;;
    2)
      echo -e "\n\e[1;34mSelect Country for Download DNS:\e[0m"
      for i in "${!countries[@]}"; do
        echo -e "\e[1;36m[$((i+1))]\e[0m ${countries[$i]}"
      done
      read -p "Country number: " dnum
      selected_country="${countries[$((dnum-1))]}"
      show_dns "$selected_country"
      read -p $'\nPress Enter to return...'
      ;;
    0)
      echo -e "\n\e[1;33mGoodbye. Follow our channel for updates:\n\e[1;32m$channel\e[0m"
      break
      ;;
    *)
      echo -e "\e[1;31mInvalid choice. Try again!\e[0m"
      sleep 1
      ;;
  esac
done
