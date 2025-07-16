#!/bin/bash

# ========================
# Mahdi Dns Script v1.0.9
# ========================

# Auto-install required packages silently
for pkg in curl lolcat figlet; do
  if ! command -v $pkg >/dev/null 2>&1; then
    echo "Installing missing package: $pkg..."
    pkgman=$(command -v apt-get || command -v pkg)
    sudo $pkgman install $pkg -y >/dev/null 2>&1
  fi
done

clear

# Color functions
cecho() {
  local color=$1; shift
  echo -e "\e[${color}m$*\e[0m"
}

rainbow_echo() {
  echo "$1" | lolcat
}

# Title section
rainbow_echo "=============================="
rainbow_echo "Mahdi Dns 🔥"
rainbow_echo "Telegram: @Academi_vpn"
rainbow_echo "Admin: @MahdiAGM0"
cecho 91 "Version: 1.0.9"
rainbow_echo "=============================="

# List of games
GAMES=(
  "Call of Duty Mobile (Mobile)"
  "PUBG Mobile (Mobile)"
  "Free Fire (Mobile)"
  "Mobile Legends (Mobile)"
  "Clash Royale (Mobile)"
  "Brawl Stars (Mobile)"
  "Apex Legends Mobile (Mobile)"
  "Fortnite (Mobile)"
  "League of Legends: Wild Rift (Mobile)"
  "Valorant (PC)"
  "Fortnite (PC)"
  "CS: GO (PC)"
  "Dota 2 (PC)"
  "Overwatch (PC)"
  "Rainbow Six Siege (PC)"
  "World of Warcraft (PC)"
  "FIFA 24 (PC)"
  "Rocket League (PC)"
  "Genshin Impact (PC)"
  "League of Legends (PC)"
  "Call of Duty: Warzone (PC)"
  "Minecraft (PC)"
  "Cyberpunk 2077 (PC)"
  "Hogwarts Legacy (PC)"
  "FIFA 24 (Console)"
  "Apex Legends (Console)"
  "Call of Duty MW3 (Console)"
  "Fortnite (Console)"
  "GTA Online (Console)"
  "NBA 2K24 (Console)"
)

# List of Middle East countries
COUNTRIES=("Iran" "UAE" "Saudi Arabia" "Turkey" "Qatar" "Oman" "Iraq" "Jordan" "Egypt" "Israel" "Kuwait" "Bahrain" "Lebanon")

# Sample DNS dataset
DNS_DATA_IRAN=("178.22.122.100" "185.51.200.2" "10.202.10.10" "10.202.10.11" "79.175.133.130")
DNS_DATA_TURKEY=("195.175.39.39" "195.175.39.40" "85.95.250.95")
DNS_DATA_UAE=("213.42.20.20" "213.42.20.21")

# Function to show ping
ping_dns() {
  local dns=$1
  ping -c1 -W1 $dns >/dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    local result=$(ping -c1 -W1 $dns | grep time= | sed -n 's/.*time=\([^ ]*\).*/\1/p')
    echo "$result ms"
  else
    echo "N/A"
  fi
}

# Main Menu
while true; do
  echo
  rainbow_echo "[1] Gaming DNS"
  rainbow_echo "[2] Download DNS"
  rainbow_echo "[0] Exit"
  echo
  read -p "Select an option: " opt

  case $opt in
    1)
      clear
      rainbow_echo "Select a game:"
      select game in "${GAMES[@]}"; do
        [[ -n "$game" ]] && break
      done

      clear
      rainbow_echo "Select a country:"
      select country in "${COUNTRIES[@]}"; do
        [[ -n "$country" ]] && break
      done

      clear
      rainbow_echo "DNS results for $game - $country"

      dns_var="DNS_DATA_${country^^}"
      dns_list=(${!dns_var})

      if [[ ${#dns_list[@]} -eq 0 ]]; then
        cecho 91 "No DNS found for $country"
      else
        for i in {1..15}; do
          dns=${dns_list[$((RANDOM % ${#dns_list[@]}))]}
          ping_val=$(ping_dns $dns)
          cecho 92 "DNS $i: $dns (Ping: $ping_val)"
        done
      fi
      read -p "Press Enter to return..." _
      ;;
    2)
      clear
      rainbow_echo "Select a country for download DNS:"
      select country in "${COUNTRIES[@]}"; do
        [[ -n "$country" ]] && break
      done

      clear
      rainbow_echo "Download DNS for $country"
      dns_var="DNS_DATA_${country^^}"
      dns_list=(${!dns_var})

      if [[ ${#dns_list[@]} -eq 0 ]]; then
        cecho 91 "No DNS found for $country"
      else
        for i in {1..15}; do
          dns=${dns_list[$((RANDOM % ${#dns_list[@]}))]}
          ping_val=$(ping_dns $dns)
          cecho 96 "DNS $i: $dns (Ping: $ping_val)"
        done
      fi
      read -p "Press Enter to return..." _
      ;;
    0)
      cecho 93 "Goodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn"
      exit 0
      ;;
    *)
      cecho 91 "Invalid option. Try again."
      ;;
  esac
done
