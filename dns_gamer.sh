#!/bin/bash

# Auto-install required packages
install_if_missing() {
  for pkg in curl ping lolcat figlet; do
    if ! command -v "$pkg" &>/dev/null; then
      echo "Installing $pkg..."
      pkg install "$pkg" -y &>/dev/null || apt install "$pkg" -y &>/dev/null
    fi
  done
}

install_if_missing

clear

# Title Section
echo -e "\e[1;36m"
figlet -f slant "Mahdi Dns 🔥" 2>/dev/null | lolcat
echo -e "\e[1;33mVersion: \e[1;31m1.1.0     \e[1;33mTelegram: @Academi_vpn     Admin: @MahdiAGM0"
echo -e "\e[0m"

# Function: Colorful echo (excluding purple and red)
cecho() {
  local colors=(32 33 36 35 34 96 92 93)
  local index=$((RANDOM % ${#colors[@]}))
  echo -e "\e[1;${colors[$index]}m$1\e[0m"
}

# Game list with device
declare -A game_list=(
  ["Call of Duty Mobile"]="Mobile"
  ["PUBG Mobile"]="Mobile"
  ["Free Fire"]="Mobile"
  ["Clash Royale"]="Mobile"
  ["Clash of Clans"]="Mobile"
  ["Mobile Legends"]="Mobile"
  ["Arena of Valor"]="Mobile"
  ["Brawl Stars"]="Mobile"
  ["FIFA Mobile"]="Mobile"
  ["Asphalt 9"]="Mobile"
  ["Valorant"]="PC"
  ["League of Legends"]="PC"
  ["Dota 2"]="PC"
  ["CS:GO"]="PC"
  ["GTA V Online"]="PC"
  ["Fortnite"]="PC"
  ["Minecraft"]="PC"
  ["Rust"]="PC"
  ["World of Warcraft"]="PC"
  ["Warframe"]="PC"
  ["FIFA 24"]="Console"
  ["Apex Legends"]="Console"
  ["Overwatch 2"]="Console"
  ["Rocket League"]="Console"
  ["Rainbow Six Siege"]="Console"
  ["Halo Infinite"]="Console"
  ["The Division 2"]="Console"
  ["Battlefield V"]="Console"
  ["Fall Guys"]="Console"
  ["ARK: Survival Evolved"]="Console"
  ["Escape from Tarkov"]="PC"
  ["Paladins"]="PC"
  ["Elder Scrolls Online"]="PC"
  ["Lost Ark"]="PC"
  ["Black Desert"]="PC"
  ["Sea of Thieves"]="Console"
  ["Star Wars Battlefront"]="Console"
  ["Dead by Daylight"]="Console"
  ["New World"]="PC"
  ["DayZ"]="PC"
)

# Country list
countries=(
  "Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar"
  "Kuwait" "Oman" "Iraq" "Egypt" "Jordan"
  "Lebanon" "Pakistan" "India" "Israel" "Syria"
  "Yemen" "Bahrain" "Afghanistan" "Georgia" "Armenia"
)

# DNS Map
declare -A dns_map
# Example DNS entries for Iran
dns_map["Iran_gaming"]=(
  "1.1.1.1"
  "8.8.8.8"
  "185.51.200.2"
  "10.202.10.10"
  "178.22.122.100"
  "94.182.110.200"
  "185.51.201.2"
  "89.32.154.10"
  "91.99.101.155"
  "80.75.7.1"
  "10.202.10.11"
  "178.22.122.102"
  "185.105.239.2"
  "217.218.127.127"
  "185.55.225.25"
)

# Example DNS entries for Iran - Download
dns_map["Iran_download"]=(
  "185.51.200.2"
  "178.22.122.100"
  "185.51.201.2"
  "91.99.101.155"
  "94.182.110.200"
  "80.75.7.1"
  "217.218.127.127"
  "10.202.10.10"
  "185.105.239.2"
  "185.55.225.25"
  "185.127.24.2"
  "178.22.122.102"
  "185.12.64.1"
  "185.4.28.2"
  "89.165.200.2"
)

# Assign same DNS list to other countries for demo (you can expand them)
for country in "${countries[@]}"; do
  if [[ "$country" != "Iran" ]]; then
    dns_map["${country}_gaming"]=("${dns_map["Iran_gaming"][@]}")
    dns_map["${country}_download"]="${dns_map["Iran_download"][@]}"
  fi
done

# Function to test ping
test_ping() {
  ping -c 1 -W 1 "$1" | grep -oP 'time=\K[\d.]+' | head -n 1
}

# Main menu
show_menu() {
  clear
  figlet -f slant "Mahdi Dns 🔥" 2>/dev/null | lolcat
  echo -e "\e[1;33mVersion: \e[1;31m1.1.0     \e[1;33mTelegram: @Academi_vpn     Admin: @MahdiAGM0"
  echo ""
  cecho "[1] Gaming DNS"
  cecho "[2] Download DNS"
  cecho "[0] Exit"
  echo ""
  read -p "Select an option: " opt

  case $opt in
    1) select_game ;;
    2) select_country "download" ;;
    0) exit_script ;;
    *) echo "Invalid option."; sleep 1; show_menu ;;
  esac
}

select_game() {
  clear
  cecho "🎮 Select a Game:"
  local i=1
  declare -A game_keys
  for g in "${!game_list[@]}"; do
    cecho "[$i] $g (${game_list[$g]})"
    game_keys[$i]="$g"
    ((i++))
  done
  echo ""
  read -p "Enter choice: " game_choice
  selected_game="${game_keys[$game_choice]}"
  [[ -z "$selected_game" ]] && echo "Invalid game." && sleep 1 && show_menu
  select_country "gaming"
}
select_country() {
  local mode=$1
  clear
  cecho "🌍 Select a Country:"
  local i=1
  declare -A country_keys
  for country in "${countries[@]}"; do
    color=$(shuf -n 1 -e 31 32 33 34 36 37)
    echo -e "\e[1;${color}m[$i] $country\e[0m"
    country_keys[$i]="$country"
    ((i++))
  done
  echo ""
  read -p "Enter choice: " country_choice
  selected_country="${country_keys[$country_choice]}"
  [[ -z "$selected_country" ]] && echo "Invalid country." && sleep 1 && show_menu
  show_dns_list "$selected_country" "$mode"
}

show_dns_list() {
  clear
  local country="$1"
  local mode="$2"
  local key="${country}_${mode}"
  local -a dns_list=("${dns_map[$key]}")
  echo -e "\e[1;36mSelected: \e[1;33m$country ($mode)\e[0m"
  echo ""
  if [[ ${#dns_list[@]} -eq 0 ]]; then
    echo -e "\e[1;31mNo DNS found for $country.\e[0m"
    read -p "Press Enter to return..." && show_menu
  fi

  # Shuffle and select 15 random DNS
  mapfile -t random_dns < <(printf "%s\n" "${dns_list[@]}" | shuf -n 15)
  local i=1
  for dns in "${random_dns[@]}"; do
    ping_result=$(test_ping "$dns")
    color=$(shuf -n 1 -e 31 32 33 34 36 37)
    echo -e "\e[1;${color}mDNS $i: $dns   (Ping: ${ping_result:-N/A} ms)\e[0m"
    ((i++))
  done
  echo ""
  read -p "Press Enter to return to main menu..." && show_menu
}
exit_script() {
  clear
  echo -e "\e[1;33m"
  echo "─────────────────────────────────────────────"
  echo "  Goodbye. Follow our channel on Telegram"
  echo "  to see more updates and scripts."
  echo "        @Academi_vpn"
  echo "─────────────────────────────────────────────"
  echo -e "\e[0m"
  exit 0
}

# Ensure all required packages are installed
install_required_packages() {
  for pkg in curl ping grep awk sed; do
    if ! command -v "$pkg" &>/dev/null; then
      echo -e "\e[1;36mInstalling $pkg...\e[0m"
      if command -v apt &>/dev/null; then
        apt update -y &>/dev/null && apt install "$pkg" -y &>/dev/null
      elif command -v pkg &>/dev/null; then
        pkg update -y &>/dev/null && pkg install "$pkg" -y &>/dev/null
      fi
    fi
  done
}

# DNS ping test function
test_ping() {
  local ip="$1"
  local result
  result=$(ping -c 1 -W 1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
  echo "$result"
}

# Start of the script
start_dns_script() {
  install_required_packages
  init_dns_data
  show_menu
}

start_dns_script
# Sample DNS database (you can expand this to 100s as needed)
declare -A dns_map

# 🎮 Gaming DNSs (per game-country combination)
dns_map["PUBG Mobile_IR"]="8.8.8.8 1.1.1.1 8.26.56.26"
dns_map["PUBG Mobile_US"]="4.2.2.2 8.8.4.4 1.0.0.1"
dns_map["Call of Duty Mobile_IR"]="94.232.174.194 185.51.200.2 185.51.200.1"
dns_map["Call of Duty Mobile_US"]="1.1.1.1 8.8.8.8 149.112.112.112"
dns_map["Free Fire_IR"]="78.157.42.100 178.22.122.100 185.51.200.2"
dns_map["Free Fire_US"]="9.9.9.9 1.0.0.1 208.67.222.222"

# More examples
dns_map["FIFA 23_IR"]="178.22.122.100 185.51.200.2 94.232.174.194"
dns_map["FIFA 23_US"]="8.26.56.26 1.1.1.1 8.8.8.8"
dns_map["Fortnite_IR"]="185.51.200.2 185.55.226.26 178.22.122.100"
dns_map["Fortnite_US"]="1.0.0.1 9.9.9.9 8.8.4.4"

# 📥 Download DNSs
dns_map["Download_IR"]="178.22.122.100 185.51.200.2 94.232.174.194"
dns_map["Download_US"]="1.1.1.1 8.8.8.8 9.9.9.9"
dns_map["Download_FR"]="80.67.169.12 80.67.169.40 194.150.168.168"
dns_map["Download_DE"]="194.25.2.129 217.237.150.205 8.8.4.4"
dns_map["Download_AE"]="91.74.211.212 212.4.94.130 213.42.20.20"
dns_map["Download_SA"]="212.26.18.41 212.26.18.42 195.229.241.222"
dns_map["Download_IN"]="8.8.8.8 1.1.1.1 114.114.114.114"
dns_map["Download_TR"]="212.156.4.22 195.175.39.39 193.140.100.100"
dns_map["Download_RU"]="77.88.8.8 77.88.8.1 94.140.14.14"
dns_map["Download_KZ"]="195.49.147.134 212.154.100.18 85.29.129.35"

# ✅ More countries and DNS entries can be added below following this pattern
