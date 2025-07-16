#!/bin/bash

version="1.2.1"
admin="@MahdiAGM0"
channel="@Academi_vpn"

# لیست کشورها و بازی‌ها
countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Iraq" "Qatar" "Jordan" "Oman" "Kuwait" "Lebanon")

games=(
"Call of Duty Mobile" "PUBG Mobile" "Free Fire" "Clash Royale" "Mobile Legends" "Fortnite"
"Valorant" "League of Legends" "CS:GO" "Dota 2" "Apex Legends" "Rainbow Six Siege" "GTA Online"
"Overwatch 2" "FIFA 24" "Rocket League" "Roblox" "Minecraft" "Warzone" "Genshin Impact"
"eFootball 2024" "Dead by Daylight" "Battlefield V" "Halo Infinite" "World of Tanks"
"Paladins" "Naruto Blazing" "Pokemon Unite" "Brawl Stars" "Diablo Immortal" "Black Desert"
"Elden Ring" "Cyberpunk 2077" "ARK Survival" "NBA 2K24" "Counter Strike 2" "Splatoon 3"
"Rogue Company" "Warframe"
)

# DNSها برای هر کشور
declare -A dns_map
dns_map["Iran"]="178.22.122.100 185.51.200.2 10.202.10.10 10.202.10.11 78.157.42.100 185.55.226.26 185.55.225.25 185.124.116.12 185.124.115.11 10.202.10.202 89.165.37.12 10.202.10.5 178.216.248.10 10.202.10.2 195.146.56.1"
dns_map["Turkey"]="193.140.100.100 195.175.39.39 212.156.4.20 213.74.1.2 213.74.1.1 195.175.39.40 193.140.100.101 193.255.230.10 193.255.230.11 213.74.72.4 213.74.72.5 81.213.132.2 81.213.132.3 193.140.98.2 195.175.170.2"
dns_map["UAE"]="194.170.1.6 194.170.1.7 217.165.128.6 217.165.129.7 213.42.20.30 213.42.20.20 86.96.100.100 86.96.100.101 86.96.1.1 217.165.129.2 194.170.1.5 194.170.2.2 217.165.131.3 213.42.1.1 217.165.130.130"
# می‌تونی برای بقیه کشورها هم ادامه بدی...

# توابع رنگی
colors=(31 32 33 34 35 36)

rand_color() {
  echo -e "\e[1;${colors[$RANDOM % ${#colors[@]}]}m$1\e[0m"
}

# انیمیشن تایپ
type_line() {
  text="$1"
  delay="${2:-0.005}"
  for ((i=0; i<${#text}; i++)); do
    echo -ne "${text:$i:1}"
    sleep $delay
  done
  echo
}

# نمایش عنوان
show_title() {
  clear
  echo -e "\n\e[1;36m═══════════════════════════════════════════════"
  type_line "$(rand_color "🚀 Mahdi DNS Panel 🚀")" 0.01
  echo -e "\e[1;36m═══════════════════════════════════════════════"
  type_line "$(rand_color "Telegram: $channel")" 0.01
  type_line "$(rand_color "Admin: $admin")" 0.01
  type_line "$(rand_color "Version: $version")" 0.01
  echo -e "\e[1;36m═══════════════════════════════════════════════"
}

# نمایش لیست با رنگ و شماره و انیمیشن
show_list() {
  local -n items=$1
  for i in "${!items[@]}"; do
    num=$((i+1))
    sleep 0.02
    type_line "$(rand_color "[$num] ${items[$i]}")" 0.001
  done
}

# نمایش DNS
show_dns() {
  country="$1"
  echo -e "\n$(rand_color "DNS List for $country:")"
  IFS=' ' read -ra all_dns <<< "${dns_map[$country]}"
  i=1
  for dns in "${all_dns[@]}"; do
    ping_time=$(ping -c 1 -W 1 $dns 2>/dev/null | grep 'time=' | cut -d'=' -f4 | cut -d' ' -f1)
    [ -z "$ping_time" ] && ping_time="N/A"
    echo -e "$(rand_color "[$i]") \e[1;37m$dns\e[0m $(rand_color "(Ping: $ping_time ms)")"
    i=$((i+1))
  done
}

# منو
while true; do
  show_title
  echo -e "\n$(rand_color "[1] 🔫 Gaming DNS")"
  echo -e "$(rand_color "[2] 🚀 Download DNS")"
  echo -e "$(rand_color "[0] ❌ Exit")"
  echo
  read -p "$(rand_color 'Choose an option:')" opt
  case $opt in
    1)
      echo -e "\n$(rand_color "Select Game:")"
      show_list games
      read -p "$(rand_color 'Game number:')" gnum
      selected_game="${games[$((gnum-1))]}"
      echo -e "\n$(rand_color "Select Country:")"
      show_list countries
      read -p "$(rand_color 'Country number:')" cnum
      selected_country="${countries[$((cnum-1))]}"
      echo -e "\n$(rand_color "Selected:") $selected_game - $selected_country"
      show_dns "$selected_country"
      read -p $'\nPress Enter to return...'
      ;;
    2)
      echo -e "\n$(rand_color "Select Country for Download DNS:")"
      show_list countries
      read -p "$(rand_color 'Country number:')" dnum
      selected_country="${countries[$((dnum-1))]}"
      show_dns "$selected_country"
      read -p $'\nPress Enter to return...'
      ;;
    0)
      echo -e "\n$(rand_color 'Goodbye 🌐')"
      break
      ;;
    *)
      echo -e "$(rand_color 'Invalid choice. Try again.')"
      sleep 1
      ;;
  esac
done
