#!/bin/bash

# -------------------- Auto Install --------------------
install_if_missing() {
  local pkg="$1"
  if ! command -v "$pkg" >/dev/null 2>&1; then
    echo "Installing $pkg..."
    apt install "$pkg" -y >/dev/null 2>&1 || pkg install "$pkg" -y >/dev/null 2>&1
  fi
}

install_if_missing curl
install_if_missing figlet
install_if_missing lolcat

# -------------------- Check Fallbacks --------------------
has_figlet=$(command -v figlet >/dev/null 2>&1 && echo true)
has_lolcat=$(command -v lolcat >/dev/null 2>&1 && echo true)

# -------------------- Show Title --------------------
show_title() {
  clear
  if $has_figlet; then figlet "Mahdi Dns 🔥"; else echo "=== Mahdi Dns 🔥 ==="; fi | ( $has_lolcat && lolcat || cat )
  echo -e "\e[36mTelegram:\e[0m @Academi_vpn" | ( $has_lolcat && lolcat || cat )
  echo -e "\e[36mAdmin:\e[0m @MahdiAGM0" | ( $has_lolcat && lolcat || cat )
  echo -e "\e[91mVersion:\e[0m 1.0.9" | ( $has_lolcat && lolcat || cat )
  echo ""
}

# -------------------- Data --------------------

games_list=(
  "PUBG Mobile (Mobile)" "Free Fire (Mobile)" "COD Mobile (Mobile)" "Clash Royale (Mobile)"
  "Mobile Legends (Mobile)" "Brawl Stars (Mobile)" "Genshin Impact (Mobile)" "Wild Rift (Mobile)"
  "Valorant (PC)" "CS:GO (PC)" "League of Legends (PC)" "Dota 2 (PC)"
  "Apex Legends (PC)" "Fortnite (PC)" "Overwatch (PC)" "War Thunder (PC)"
  "GTA Online (Console)" "Warzone (Console)" "FIFA 24 (Console)" "Rocket League (Console)"
  "Minecraft (PC)" "Roblox (Mobile)" "Honkai Star Rail (Mobile)" "Naruto Slugfest (Mobile)"
  "Battlefield 2042 (PC)" "The Finals (PC)" "Fall Guys (Console)" "Destiny 2 (PC)"
  "Sea of Thieves (PC)" "Diablo IV (PC)" "NBA 2K24 (Console)" "Gran Turismo (Console)"
  "Paladins (PC)" "World of Tanks (PC)" "ARK Survival (PC)" "Forza Horizon (Console)"
  "Monster Hunter Rise (PC)" "Tekken 7 (Console)" "Mortal Kombat (Console)" "Street Fighter 6 (PC)"
)

countries_list=( "Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Oman" "Jordan" "Kuwait" "Bahrain" "Iraq" )

declare -A dns_database
dns_database["Iran"]="178.22.122.100 185.51.200.2 10.202.10.10 193.151.128.100 217.218.155.155"
dns_database["Turkey"]="185.15.171.204 95.70.23.26 213.74.72.11 212.156.4.20 195.175.39.49"
dns_database["UAE"]="91.74.71.129 94.200.200.200 213.42.20.20 86.96.100.100 194.170.1.5"
# ... ادامه برای بقیه کشورها (به‌دلخواه اضافه کن)

get_dns_list() {
  country="$1"
  list=(${dns_database[$country]})
  for ((i = 1; i <= 15; i++)); do
    dns="${list[$RANDOM % ${#list[@]}]}"
    ping_result=$(ping -c1 -W1 "$dns" | grep time= | cut -d= -f4 | cut -d' ' -f1)
    [ -z "$ping_result" ] && ping_result="N/A"
    echo -e "\e[93mDNS $i:\e[0m $dns    \e[94m(Ping: $ping_result ms)\e[0m"
  done
}

# -------------------- Menus --------------------

gaming_menu() {
  show_title
  echo -e "\e[92mSelect a Game:\e[0m"
  for i in "${!games_list[@]}"; do
    printf "[%2d] %s\n" "$i" "${games_list[$i]}"
  done
  read -p "Enter game number: " game_index

  show_title
  echo -e "\e[92mSelect Country:\e[0m"
  for i in "${!countries_list[@]}"; do
    color=$((31 + i % 7))
    echo -e "\e[${color}m[$i] ${countries_list[$i]}\e[0m"
  done
  read -p "Enter country number: " country_index
  selected_country="${countries_list[$country_index]}"

  show_title
  echo -e "\e[96mGame:\e[0m ${games_list[$game_index]}"
  echo -e "\e[96mCountry:\e[0m $selected_country"
  echo -e "\n\e[92mShowing Gaming DNS...\e[0m"
  get_dns_list "$selected_country"
  read -p "Press Enter to return..."
}

download_menu() {
  show_title
  echo -e "\e[92mSelect Country:\e[0m"
  for i in "${!countries_list[@]}"; do
    color=$((31 + i % 7))
    echo -e "\e[${color}m[$i] ${countries_list[$i]}\e[0m"
  done
  read -p "Enter country number: " country_index
  selected_country="${countries_list[$country_index]}"

  show_title
  echo -e "\e[96mCountry:\e[0m $selected_country"
  echo -e "\n\e[92mShowing Download DNS...\e[0m"
  get_dns_list "$selected_country"
  read -p "Press Enter to return..."
}

exit_script() {
  clear
  echo -e "\e[93mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\e[0m"
  exit 0
}

# -------------------- Main Loop --------------------

while true; do
  show_title
  echo -e "\e[92m[1] Gaming DNS"
  echo -e "\e[94m[2] Download DNS"
  echo -e "\e[91m[0] Exit\e[0m"
  read -p "Choose an option: " opt
  case $opt in
    1) gaming_menu ;;
    2) download_menu ;;
    0) exit_script ;;
    *) echo "Invalid option"; sleep 1 ;;
  esac
done
