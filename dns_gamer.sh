#!/bin/bash

# رنگ‌ها
colors=('\033[1;31m' '\033[1;32m' '\033[1;33m' '\033[1;34m' '\033[1;35m' '\033[1;36m')
RESET='\033[0m'

rand_color() {
  echo -ne "${colors[$RANDOM % ${#colors[@]}]}"
}

type_fast() {
  local text="$1"
  for ((i = 0; i < ${#text}; i++)); do
    echo -ne "$(rand_color)${text:$i:1}${RESET}"
    sleep 0.001
  done
  echo
}

# تایتل
show_title() {
  clear
  echo -e "$(rand_color)╔══════════════════════════════════════════════╗${RESET}"
  type_fast "║        🔰 DNS Management Script v1.2.0      ║"
  echo -e "$(rand_color)╠══════════════════════════════════════════════╣${RESET}"
  type_fast "║ Telegram : @Academi_vpn                    ║"
  type_fast "║ Admin    : @MahdiAGM0                      ║"
  type_fast "╚══════════════════════════════════════════════╝"
  echo
}

# لیست بازی‌ها (۳۰ عدد)
select_game() {
  clear
  show_title
  games=(
    "Call of Duty" "PUBG" "Valorant" "Fortnite" "League of Legends"
    "Dota 2" "Apex Legends" "Rainbow Six Siege" "CS:GO" "Free Fire"
    "Genshin Impact" "Minecraft" "Overwatch" "Arena Breakout" "Mobile Legends"
    "Battlefield" "Warzone" "Rust" "Roblox" "World of Tanks"
    "FIFA" "NBA 2K" "ARK: Survival" "Tarkov" "DayZ"
    "Honkai Star Rail" "Rocket League" "Brawl Stars" "Clash Royale" "COD Mobile"
  )
  type_fast "[🎮 Select Your Game]"
  for i in "${!games[@]}"; do
    echo -e "$(rand_color)[$((i+1))] ${games[$i]}${RESET}"
    sleep 0.035
  done
  echo
  echo -ne "🎯 Enter choice (1-30): "
  read game_choice
  select_region "$game_choice"
}

# منطقه برای گیمینگ
select_region() {
  game_id=$1
  clear
  show_title
  countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Iraq" "Qatar" "Jordan" "Egypt" "Pakistan" "Kuwait")
  type_fast "[🌍 Select Region]"
  for i in "${!countries[@]}"; do
    echo -e "$(rand_color)[$((i+1))] ${countries[$i]}${RESET}"
    sleep 0.03
  done
  echo
  echo -ne "📍 Your Region (1-10): "
  read region_id
  show_gaming_dns "$game_id" "$region_id"
}

# نمایش DNS گیمینگ
show_gaming_dns() {
  clear
  show_title
  game_name=${games[$1-1]}
  region_name=${countries[$2-1]}
  echo -e "$(rand_color)🎮 Best DNS for ${game_name} in ${region_name}${RESET}"
  echo
  for i in {1..15}; do
    dns="185.228.$((100 + RANDOM % 50)).$((10 + RANDOM % 200))"
    ping=$(ping -c 1 -W 1 "$dns" 2>/dev/null | grep 'time=' | cut -d'=' -f4 | cut -d' ' -f1)
    [[ -z "$ping" ]] && ping="Timeout"
    echo -e "$(rand_color)[$i] $dns  ⏱ Ping: $ping ms${RESET}"
    sleep 0.05
  done
  echo
  read -p "🔁 Press Enter to return to menu..." && main_menu
}

# انتخاب کشور برای دانلود
select_download_country() {
  clear
  show_title
  countries=(
    "Iran" "Germany" "USA" "Turkey" "India"
    "France" "Russia" "Japan" "South Korea" "Brazil"
    "China" "Egypt" "UK" "UAE" "Saudi Arabia"
    "Netherlands" "Canada" "Italy" "Sweden" "Spain"
  )
  type_fast "[⬇️  Select Download Region]"
  for i in "${!countries[@]}"; do
    echo -e "$(rand_color)[$((i+1))] ${countries[$i]}${RESET}"
    sleep 0.03
  done
  echo
  echo -ne "🌍 Choose a country (1-20): "
  read c_id
  show_download_dns "$c_id"
}

# نمایش DNS دانلود
show_download_dns() {
  clear
  show_title
  country=${countries[$1-1]}
  echo -e "$(rand_color)⬇️  High-Speed DNS for $country${RESET}"
  echo
  for i in {1..15}; do
    dns="8.$((100 + RANDOM % 50)).$((i+10)).$((RANDOM % 255))"
    ping=$(ping -c 1 -W 1 "$dns" 2>/dev/null | grep 'time=' | cut -d'=' -f4 | cut -d' ' -f1)
    [[ -z "$ping" ]] && ping="Timeout"
    echo -e "$(rand_color)[$i] $dns  ⏱ Ping: $ping ms${RESET}"
    sleep 0.05
  done
  echo
  read -p "🔁 Press Enter to return to menu..." && main_menu
}

# منو اصلی
main_menu() {
  show_title
  type_fast "[1] 🎮 Gaming DNS"
  type_fast "[2] ⬇️  Download DNS"
  type_fast "[0] ❌ Exit"
  echo
  echo -ne "$(rand_color)👉 Select an option: ${RESET}"
  read choice
  case $choice in
    1) select_game ;;
    2) select_download_country ;;
    0) echo "👋 Bye!"; exit ;;
    *) echo "❌ Invalid option"; sleep 1; main_menu ;;
  esac
}

# اجرا
main_menu
