#!/bin/bash

# رنگ‌ها
colors=(
  '\033[38;5;80m'   # Cyan-Neon
  '\033[38;5;39m'   # Deep Sky Blue
  '\033[38;5;121m'  # Light Green (Mint)
)
RESET='\033[0m'

rand_color() {
  echo -ne "${colors[$RANDOM % ${#colors[@]}]}"
}

# تایپ سریع
type_fast() {
  local text="$1"
  for ((i = 0; i < ${#text}; i++)); do
    echo -ne "$(rand_color)${text:$i:1}${RESET}"
    sleep 0.0005
  done
  echo
}

# پینگ
get_ping() {
  ping -c 1 -W 1 "$1" | grep 'time=' | sed -E 's/.*time=([0-9.]+).*/\1 ms/' || echo "N/A"
}

# تایتل اصلی
show_title() {
  clear
  echo -e "$(rand_color)╔═════════════════════════════════════════════════════╗${RESET}"
  type_fast "║       🚀 Advanced DNS Manager | Version 1.2.1       ║"
  echo -e "$(rand_color)╠═════════════════════════════════════════════════════╣${RESET}"
  type_fast "║ Telegram : @Academi_vpn                            ║"
  type_fast "║ Admin    : @MahdiAGM0                              ║"
  echo -e "$(rand_color)╚═════════════════════════════════════════════════════╝${RESET}"
  echo
}

# بازی‌ها
games=("Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends" "Dota 2" "CS:GO" "Overwatch" "Minecraft" "Apex Legends" "Genshin Impact" "Roblox" "FIFA" "Rocket League" "Warzone" "Rainbow Six Siege" "World of Tanks" "Battlefield" "Mobile Legends" "Free Fire" "Brawl Stars" "Arena of Valor" "Clash Royale" "Clash of Clans" "Diablo IV" "Elden Ring" "Fall Guys" "Halo" "Paladins" "Lost Ark")

# کشورها
countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Jordan" "Iraq" "Israel" "Oman" "Egypt" "India" "Germany" "France" "UK" "USA" "Canada" "Russia" "China" "Japan" "South Korea")

declare -A dns_map

# DNS پیش‌فرض جهانی
default_dns=("1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" "9.9.9.9" "149.112.112.112" "208.67.222.222" "208.67.220.220" "94.140.14.14" "94.140.15.15" "185.228.168.9" "185.228.169.9" "76.76.2.0" "76.76.10.0" "64.6.64.6")

# نمایش لیست با انیمیشن بالا به پایین
show_list_with_animation() {
  for i in "${!1[@]}"; do
    echo -ne "$(rand_color)[$((i+1))] ${1[i]}${RESET}\n"
    sleep 0.05
  done
}

# بخش DNS گیمینگ
gaming_dns_menu() {
  clear
  type_fast "🎮 Select a Game:"
  show_list_with_animation games
  echo -ne "$(rand_color)👉 Enter Game Number: ${RESET}"
  read game_index
  game="${games[$((game_index-1))]}"

  clear
  type_fast "🌍 Select a Region:"
  show_list_with_animation countries
  echo -ne "$(rand_color)👉 Enter Country Number: ${RESET}"
  read country_index
  country="${countries[$((country_index-1))]}"

  key="$game,$country"
  IFS=' ' read -r -a dns_list <<< "${dns_map[$key]}"

  if [ -z "${dns_list[*]}" ]; then
    dns_list=("${default_dns[@]}")
  fi

  clear
  type_fast "🌐 Best DNS for $game in $country:"
  for i in "${!dns_list[@]}"; do
    dns="${dns_list[$i]}"
    ping=$(get_ping "$dns")
    echo -e "$(rand_color)[$((i+1))] $dns  —  Ping: $ping${RESET}"
    sleep 0.05
  done

  echo
  read -p "🔁 Press Enter to return..." 
  main_menu
}

# بخش DNS دانلود
download_dns_menu() {
  clear
  type_fast "⬇️  Select Country for Download Optimization:"
  show_list_with_animation countries
  echo -ne "$(rand_color)👉 Enter Country Number: ${RESET}"
  read country_index
  country="${countries[$((country_index-1))]}"

  clear
  type_fast "🌐 15 Best Download DNS for $country:"
  for i in "${!default_dns[@]}"; do
    dns="${default_dns[$i]}"
    ping=$(get_ping "$dns")
    echo -e "$(rand_color)[$((i+1))] $dns  —  Ping: $ping${RESET}"
    sleep 0.05
  done

  echo
  read -p "🔁 Press Enter to return..."
  main_menu
}

# منوی اصلی
main_menu() {
  show_title
  type_fast "[1] 🎮 Gaming DNS"
  type_fast "[2] ⬇️  Download DNS"
  type_fast "[0] ❌ Exit"
  echo -ne "$(rand_color)👉 Select an Option: ${RESET}"
  read choice
  case $choice in
    1) gaming_dns_menu ;;
    2) download_dns_menu ;;
    0) echo "👋 Exiting..."; exit ;;
    *) echo -e "$(rand_color)❌ Invalid Option${RESET}"; sleep 1; main_menu ;;
  esac
}

# شروع برنامه
main_menu
