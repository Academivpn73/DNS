#!/bin/bash

# --- Basic Info ---
VERSION="1.2.3"
TELEGRAM="@Academi_vpn"
ADMIN="@MahdiAGM0"

# --- DNS Lists ---
gaming_dns=("1.1.1.1 1.0.0.1" "8.8.8.8 8.8.4.4" "9.9.9.9 149.112.112.112" "185.51.200.2 185.51.200.3" "94.140.14.14 94.140.15.15")
download_dns=("8.8.4.4 1.1.1.1" "76.76.2.0 76.76.10.0" "185.51.200.3 185.51.200.2")
premium_dns=("1.1.1.2 1.0.0.2" "9.9.9.10 149.112.112.10" "94.140.14.15 94.140.15.16" "45.90.28.0 45.90.30.0" "156.154.70.1 156.154.71.1")

# --- Game List ---
games=(
"Call of Duty Mobile" "PUBG Mobile" "Free Fire" "Clash of Clans"
"Clash Royale" "Brawl Stars" "Arena Breakout (New)" "Mobile Legends"
"Fortnite Mobile" "League of Legends: Wild Rift" "Apex Legends Mobile"
"Genshin Impact" "Diablo Immortal" "Honkai Impact 3rd" "Among Us"
"Roblox" "Subway Surfers" "Asphalt 9" "Real Racing 3" "eFootball 2024"
"FIFA Mobile" "NBA Live Mobile" "Dead Trigger 2" "Shadowgun Legends"
"Critical Ops" "Standoff 2" "Modern Combat 5" "Into the Dead 2" "Minecraft PE"
"Pokemon GO" "Dragon Ball Legends" "Yu-Gi-Oh! Duel Links" "AFK Arena"
"Summoners War" "Lords Mobile" "Rise of Kingdoms" "Boom Beach" "War Robots"
"Vainglory" "Infinity Ops" "Badlanders" "Zooba" "Sniper 3D" "Hitman Sniper"
"Last Day on Earth" "Dragon Raja" "Torchlight Infinite (New)" "Farlight 84 (New)" "T3 Arena (New)"
)

# --- Countries ---
countries=("Iran" "UAE" "Turkey" "Iraq" "Qatar" "Saudi Arabia" "Other")

# --- Functions ---
show_header() {
  clear
  echo "+------------------------------------------+"
  echo "| Telegram: $TELEGRAM                      |"
  echo "| Admin:    $ADMIN                         |"
  echo "| Version:  $VERSION                       |"
  echo "+------------------------------------------+"
}

show_dns() {
  dns_pair=$1
  primary=$(echo $dns_pair | awk '{print $1}')
  secondary=$(echo $dns_pair | awk '{print $2}')
  echo -e "\nPrimary DNS: $primary"
  echo "Secondary DNS: $secondary"
  ping_result=$(ping -c 1 -W 1 "$primary" | grep 'time=' | sed 's/.*time=//;s/ ms//')
  [[ -n "$ping_result" ]] && echo "Ping: ${ping_result}ms" || echo "Ping: Unreachable"
  read -p "Press Enter to return to menu..."
}

ping_dns() {
  read -p "Enter DNS to ping: " dns
  result=$(ping -c 1 -W 1 "$dns" | grep 'time=' | sed 's/.*time=//;s/ ms//')
  [[ -n "$result" ]] && echo -e "Ping: ${result}ms" || echo "Ping: Unreachable"
  read -p "Press Enter to return..."
}

search_game() {
  read -p "Enter Game Name: " search
  found=false
  for game in "${games[@]}"; do
    if [[ "$game" == *"$search"* ]]; then
      found=true
      echo -e "\nGame found: $game"
      echo "Select Country:"
      select country in "${countries[@]}" "Back"; do
        [[ "$REPLY" -gt 0 && "$REPLY" -le "${#countries[@]}" ]] && break
        [[ "$REPLY" -eq $((${#countries[@]} + 1)) ]] && return
      done
      rand=$((RANDOM % ${#gaming_dns[@]}))
      show_dns "${gaming_dns[$rand]}"
      return
    fi
  done
  if ! $found; then
    echo -e "\n\033[1;33mGame not found.\033[0m"
    read -p "Press Enter to return..."
  fi
}

# --- Main Menu ---
while true; do
  show_header
  echo -e "\nMain Menu:"
  echo "1. Gaming DNS"
  echo "2. Download DNS"
  echo "3. Premium DNS (New)"
  echo "4. Ping DNS (New)"
  echo "5. Search Game (New)"
  echo "6. Exit"
  read -p "Choose an option [1-6]: " option

  case $option in
    1)
      echo -e "\nChoose Country:"
      select country in "${countries[@]}" "Back"; do
        [[ "$REPLY" -gt 0 && "$REPLY" -le "${#countries[@]}" ]] && break
        [[ "$REPLY" -eq $((${#countries[@]} + 1)) ]] && continue 2
      done
      rand=$((RANDOM % ${#gaming_dns[@]}))
      show_dns "${gaming_dns[$rand]}"
      ;;
    2)
      echo -e "\nChoose Country:"
      select country in "${countries[@]}" "Back"; do
        [[ "$REPLY" -gt 0 && "$REPLY" -le "${#countries[@]}" ]] && break
        [[ "$REPLY" -eq $((${#countries[@]} + 1)) ]] && continue 2
      done
      rand=$((RANDOM % ${#download_dns[@]}))
      show_dns "${download_dns[$rand]}"
      ;;
    3)
      rand=$((RANDOM % ${#premium_dns[@]}))
      show_dns "${premium_dns[$rand]}"
      ;;
    4)
      ping_dns
      ;;
    5)
      search_game
      ;;
    6)
      echo "Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid option."
      sleep 1
      ;;
  esac
done
