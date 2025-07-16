#!/bin/bash

# Auto install required packages (non-interactive)
for pkg in curl jq ping figlet lolcat; do
  if ! command -v "$pkg" &>/dev/null; then
    echo "Installing $pkg..."
    if command -v pkg &>/dev/null; then
      pkg install -y "$pkg"
    else
      apt install -y "$pkg"
    fi
  fi
done

# DNS DATABASE - will auto update later if needed
update_dns_list() {
  # You can later fetch from a remote source like GitHub
  :
}

# Titles
show_title() {
  clear
  echo -e "\e[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
  echo -e "\e[93m        ⚡ Mahdi DNS Script - v\e[91m1.1.2\e[93m ⚡\e[0m"
  echo -e "\e[92m Telegram:\e[0m @Academi_vpn   \e[92mAdmin:\e[0m @MahdiAGM0"
  echo -e "\e[96m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
}

# Game List
games_mobile=(
"PUBG_Mobile"
"FreeFire_Mobile"
"CODM_Mobile"
"MobileLegends_Mobile"
"GenshinImpact_Mobile"
"eFootball_Mobile"
"Standoff2_Mobile"
"Roblox_Mobile"
"ClashRoyale_Mobile"
"BrawlStars_Mobile"
"Asphalt9_Mobile"
"SubwaySurfers_Mobile"
"DiabloImmortal_Mobile"
)

games_pc=(
"ApexLegends_PC"
"Valorant_PC"
"CSGO_PC"
"Dota2_PC"
"LOL_PC"
"Overwatch2_PC"
"Rust_PC"
"Warzone_PC"
"RocketLeague_PC"
"Battlefield_PC"
"Smite_PC"
"Rainbow6_PC"
"WorldOfTanks_PC"
)

games_console=(
"Fortnite_PS4"
"FIFA_PS4"
"Apex_PS5"
"COD_XBOX"
"NBA2K_PS5"
"GTAOnline_XBOX"
"CODM_PS4"
)

# Countries (Middle East + Region)
countries=("Iran" "Turkey" "Iraq" "UAE" "Qatar" "Kuwait" "Jordan" "Bahrain" "Lebanon" "SaudiArabia")

# Download countries
dl_countries=("Iran" "Turkey" "UAE" "SaudiArabia" "Qatar" "Kuwait" "Iraq" "Bahrain" "Egypt" "Oman")

# DNS Entries (mock real world)
dns_list() {
  local country="$1"
  case $country in
    Iran) echo "185.51.200.2 10.202.10.10 185.55.226.26 178.22.122.100 1.1.1.1 8.8.8.8 9.9.9.9" ;;
    Turkey) echo "1.1.1.1 8.8.4.4 193.192.98.5 94.140.14.14 185.228.168.9 185.95.218.42" ;;
    Iraq) echo "1.1.1.1 8.8.8.8 94.140.14.14 149.112.112.112 77.88.8.8" ;;
    UAE) echo "1.0.0.1 9.9.9.9 185.228.168.10 208.67.222.222 94.140.14.15" ;;
    Qatar) echo "8.8.8.8 1.1.1.1 185.228.169.168 94.140.14.14 208.67.220.220" ;;
    Kuwait) echo "8.8.4.4 1.1.1.1 185.51.200.2 77.88.8.8 149.112.112.112" ;;
    Jordan) echo "1.0.0.1 8.26.56.26 185.95.218.42 94.140.14.14 64.6.64.6" ;;
    Bahrain) echo "185.228.168.168 1.1.1.1 185.51.200.2 77.88.8.8 9.9.9.9" ;;
    Lebanon) echo "94.140.14.14 1.1.1.1 8.8.8.8 149.112.112.112 185.228.168.9" ;;
    SaudiArabia) echo "1.1.1.1 8.8.8.8 9.9.9.9 94.140.14.14 208.67.222.222" ;;
    Egypt) echo "41.128.225.1 1.1.1.1 8.8.8.8 208.67.220.220 149.112.112.112" ;;
    Oman) echo "1.0.0.1 94.140.14.14 9.9.9.9 77.88.8.8 185.228.168.10" ;;
  esac
}

# Ping Test
ping_dns() {
  local ip=$1
  ping -c 1 -W 1 "$ip" | grep time= | awk -F"time=" '{print $2}' | cut -d' ' -f1
}

# Show DNS List
show_dns_list() {
  local dns_entries=($1)
  local count=1
  for dns in "${dns_entries[@]}"; do
    ping_time=$(ping_dns "$dns")
    echo -e "\e[93mDNS $count:\e[0m $dns \e[92mPing:\e[96m ${ping_time:-Timeout}\e[0m"
    ((count++))
  done
}

# Gaming DNS Section
gaming_dns() {
  show_title
  echo -e "\n\e[95m--- Choose a Game ---\e[0m"
  index=0
  echo -e "\e[96m[Mobile Games]\e[0m"
  for g in "${games_mobile[@]}"; do echo "[$index] $g"; ((index++)); done
  echo -e "\e[96m[PC Games]\e[0m"
  for g in "${games_pc[@]}"; do echo "[$index] $g"; ((index++)); done
  echo -e "\e[96m[Console Games]\e[0m"
  for g in "${games_console[@]}"; do echo "[$index] $g"; ((index++)); done

  read -p $'\nSelect game number: ' game_index

  game_selected="${games_mobile[@]} ${games_pc[@]} ${games_console[@]}"
  game_name=$(echo $game_selected | cut -d' ' -f $((game_index+1)))

  echo -e "\n\e[95m--- Choose Country ---\e[0m"
  for i in "${!countries[@]}"; do echo "[$i] ${countries[$i]}"; done
  read -p $'\nSelect country number: ' c_index
  country="${countries[$c_index]}"

  dns_all=($(dns_list "$country"))
  random_dns=($(shuf -e "${dns_all[@]}" -n 15))

  echo -e "\n\e[94m🔹 DNS for $game_name in $country:\e[0m"
  show_dns_list "${random_dns[*]}"
  read -p $'\nPress Enter to return to main menu...'
  main_menu
}

# Download DNS Section
download_dns() {
  show_title
  echo -e "\n\e[95m--- Choose Country ---\e[0m"
  for i in "${!dl_countries[@]}"; do echo "[$i] ${dl_countries[$i]}"; done
  read -p $'\nSelect country number: ' c_index
  country="${dl_countries[$c_index]}"

  dns_all=($(dns_list "$country"))
  random_dns=($(shuf -e "${dns_all[@]}" -n 15))

  echo -e "\n\e[94m📦 Download DNS for $country:\e[0m"
  show_dns_list "${random_dns[*]}"
  read -p $'\nPress Enter to return to main menu...'
  main_menu
}

# Main Menu
main_menu() {
  show_title
  echo -e "\n\e[93m[1]\e[0m Gaming DNS 🎮"
  echo -e "\e[93m[2]\e[0m Download DNS 📥"
  echo -e "\e[91m[0]\e[0m Exit"

  read -p $'\nEnter your choice: ' choice

  case "$choice" in
    1) gaming_dns ;;
    2) download_dns ;;
    0) echo -e "\n\e[93mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\e[0m"; exit ;;
    *) echo -e "\e[91mInvalid option.\e[0m"; sleep 1; main_menu ;;
  esac
}

# Start
main_menu
