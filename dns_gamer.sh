#!/bin/bash

# Auto install requirements
for pkg in curl figlet lolcat; do
  if ! command -v $pkg &>/dev/null; then
    echo "Installing $pkg..."
    apt update &>/dev/null && apt install -y $pkg &>/dev/null
  fi
done

# Title Colors
colors=(31 32 33 34 35 36)
color=${colors[$RANDOM % ${#colors[@]}]}

# Typing Animation
type_text() {
  text="$1"
  for ((i = 0; i < ${#text}; i++)); do
    echo -ne "${text:$i:1}"
    sleep 0.008
  done
  echo
}

# Title Banner
clear
echo -e "\033[1;${color}m"
figlet "DNS Gamer Pro" | lolcat
echo -e "\033[0m"
type_text "👨‍💻 Admin: @MahdiAGM0 | 📡 Telegram: @Academi_vpn | 🧩 Version: 1.2.3"
echo -e "\033[1;30m----------------------------------------------------\033[0m"

# DNS Premium List (sample of real low-ping ones)
premium_dns=(
  "1.1.1.1"
  "8.8.8.8"
  "9.9.9.9"
  "94.140.14.14"
  "76.76.2.0"
  "8.26.56.26"
  "185.228.168.168"
  "64.6.64.6"
  "45.90.28.0"
  "194.242.2.2"
  # ... add up to 200 real ones here
)

# Game to Country DNS map (simplified)
declare -A game_dns_map
game_dns_map["call of duty mobile,iran"]="1.1.1.1"
game_dns_map["arena breakout,turkey"]="8.8.8.8"
game_dns_map["pubg mobile,uae"]="94.140.14.14"
# Add more mappings...

# Function: Show Premium DNS
show_premium_dns() {
  rand1=${premium_dns[$RANDOM % ${#premium_dns[@]}]}
  rand2=${premium_dns[$RANDOM % ${#premium_dns[@]}]}
  ping1=$(ping -c 1 -W 1 $rand1 | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
  ping2=$(ping -c 1 -W 1 $rand2 | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)

  echo -e "\n🔐 Premium DNS:"
  echo -e "$rand1\nPing: ${ping1:-timeout}ms"
  echo -e "$rand2\nPing: ${ping2:-timeout}ms"
  echo -e "\nPress Enter to return..."
  read
}

# Function: Ping a DNS
ping_dns() {
  read -p "Enter DNS to ping: " dns
  echo -e "\n⏱️ Pinging $dns ..."
  ping -c 3 $dns
  echo -e "\nPress Enter to return..."
  read
}

# Function: Search Game
search_game() {
  read -p "Enter game name: " gname
  lname=$(echo "$gname" | tr '[:upper:]' '[:lower:]')

  # Check if game exists
  found=0
  for key in "${!game_dns_map[@]}"; do
    if [[ "$key" == "$lname"* ]]; then
      found=1
      echo -e "\n🌍 Select Country:"
      echo "1) Iran"
      echo "2) UAE"
      echo "3) Turkey"
      echo "4) Other"
      read -p "Enter number: " country
      case $country in
        1) c="iran" ;;
        2) c="uae" ;;
        3) c="turkey" ;;
        4) c="other" ;;
        *) c="iran" ;;
      esac
      dns=${game_dns_map["$lname,$c"]}
      if [[ -z "$dns" ]]; then
        echo -e "\n🟡 No DNS found for this region/game."
      else
        ping_val=$(ping -c 1 -W 1 $dns | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
        echo -e "\n🎮 DNS for $gname [$c]:"
        echo -e "$dns\nPing: ${ping_val:-timeout}ms"
      fi
    fi
  done

  if [[ $found -eq 0 ]]; then
    echo -e "\n🟡 Game not found in list."
  fi
  echo -e "\nPress Enter to return..."
  read
}

# Function: Show menu
while true; do
  clear
  echo -e "\033[1;${color}m"
  figlet "DNS Gamer Pro" | lolcat
  echo -e "\033[0m"
  type_text "👨‍💻 Admin: @MahdiAGM0 | 📡 Telegram: @Academi_vpn | 🧩 Version: 1.2.3"
  echo -e "\033[1;30m----------------------------------------------------\033[0m"

  echo -e "\n📜 Menu:"
  echo "1) 🚀 Premium DNS           [NEW]"
  echo "2) 📶 Ping a DNS            [NEW]"
  echo "3) 🎮 Search Game           [NEW]"
  echo "4) 📥 Download DNS"
  echo "5) 🎯 Gaming DNS"
  echo "6) ❌ Exit"

  read -p $'\nChoose an option: ' opt
  case $opt in
    1) show_premium_dns ;;
    2) ping_dns ;;
    3) search_game ;;
    4) echo -e "\nDownload DNS:\n8.8.4.4\n8.26.56.26\nPress Enter to return..."; read ;;
    5) echo -e "\nGaming DNS:\n1.1.1.1\n9.9.9.9\nPress Enter to return..."; read ;;
    6) echo "Goodbye!"; exit ;;
    *) echo -e "\nInvalid option! Press Enter..."; read ;;
  esac
done
