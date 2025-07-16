#!/bin/bash

# Dependencies
for pkg in curl lolcat figlet; do
  if ! command -v $pkg &>/dev/null; then
    pkgman=$(command -v pkg || command -v apt)
    $pkgman update -y &>/dev/null
    $pkgman install $pkg -y &>/dev/null
  fi
done

# Ping Function
get_ping() {
    ip="$1"
    if command -v ping >/dev/null 2>&1; then
        ping_output=$(ping -c 1 -W 1 "$ip" 2>/dev/null)
        latency=$(echo "$ping_output" | grep 'time=' | sed -E 's/.*time=([0-9.]+) ms.*/\1/')
        if [[ -n "$latency" ]]; then
            echo "$ip (Ping: ${latency} ms)"
        else
            echo "$ip (Ping: N/A)"
        fi
    else
        echo "$ip (Ping: N/A)"
    fi
}

# Title
clear
echo -e "\033[1;32mMahdi Dns 🔥\033[0m" | lolcat
echo -e "\033[1;31mVersion: 1.1.0\033[0m     \033[1;36mTelegram: @Academi_vpn     Admin: @MahdiAGM0\033[0m" | lolcat
echo ""

# Game List
declare -A game_list=(
    ["PUBG Mobile"]="Mobile"
    ["Call of Duty Mobile"]="Mobile"
    ["Free Fire"]="Mobile"
    ["Mobile Legends"]="Mobile"
    ["Clash Royale"]="Mobile"
    ["Apex Legends"]="PC"
    ["Valorant"]="PC"
    ["CS:GO"]="PC"
    ["League of Legends"]="PC"
    ["Dota 2"]="PC"
    ["Overwatch"]="PC"
    ["Fortnite"]="PC"
    ["FIFA 23"]="Console"
    ["Warzone"]="Console"
    ["GTA Online"]="Console"
    ["Rocket League"]="Console"
    ["Rainbow Six Siege"]="Console"
)

# Countries
countries=("Iran" "UAE" "Saudi Arabia" "Turkey" "Iraq" "Qatar" "Kuwait" "Jordan" "Oman" "Egypt")

# DNS Data (Example)
declare -A dns_map
dns_map["Iran"]="185.51.200.2 178.22.122.100 10.202.10.10"
dns_map["Turkey"]="193.140.100.100 85.95.255.100"
dns_map["UAE"]="195.229.241.222 213.42.20.20"
dns_map["Qatar"]="212.77.203.40 78.100.0.100"
dns_map["Saudi Arabia"]="212.26.18.41 212.26.18.42"

# Show Menu
show_menu() {
  echo ""
  echo -e "\033[1;33m[1]\033[0m Gaming DNS"
  echo -e "\033[1;33m[2]\033[0m Download DNS"
  echo -e "\033[1;31m[0]\033[0m Exit"
  echo ""
}

# Gaming DNS Section
gaming_dns() {
  clear
  echo -e "\033[1;36mSelect a Game:\033[0m"
  index=1
  game_keys=()
  for game in "${!game_list[@]}"; do
    device=${game_list[$game]}
    echo -e "\033[1;35m[$index]\033[0m $game - ($device)"
    game_keys+=("$game")
    ((index++))
  done
  echo ""
  read -p "Enter your choice: " game_choice
  selected_game="${game_keys[$((game_choice-1))]}"

  echo ""
  echo -e "\033[1;36mSelect Country:\033[0m"
  for i in "${!countries[@]}"; do
    color=$((31 + i % 6))
    echo -e "\033[1;${color}m[$((i+1))] ${countries[$i]}\033[0m"
  done
  echo ""
  read -p "Enter your choice: " country_choice
  selected_country="${countries[$((country_choice-1))]}"

  echo ""
  echo -e "\033[1;32mSelected Game:\033[0m $selected_game"
  echo -e "\033[1;32mSelected Country:\033[0m $selected_country"
  echo ""

  dns_list=${dns_map[$selected_country]}
  if [[ -z "$dns_list" ]]; then
    echo -e "\033[1;31mNo DNS found for $selected_country\033[0m"
  else
    i=1
    for dns in $dns_list; do
      ping_result=$(get_ping "$dns")
      echo -e "\033[1;36mDNS $i: $ping_result\033[0m"
      ((i++))
    done
  fi

  echo ""
  read -p "Press Enter to return to main menu..."
  main
}

# Download DNS Section (Simplified)
download_dns() {
  clear
  echo -e "\033[1;36mSelect Country:\033[0m"
  for i in "${!countries[@]}"; do
    color=$((36 + i % 6))
    echo -e "\033[1;${color}m[$((i+1))] ${countries[$i]}\033[0m"
  done
  echo ""
  read -p "Enter your choice: " country_choice
  selected_country="${countries[$((country_choice-1))]}"

  echo ""
  echo -e "\033[1;32mSelected Country:\033[0m $selected_country"
  echo ""

  dns_list=${dns_map[$selected_country]}
  if [[ -z "$dns_list" ]]; then
    echo -e "\033[1;31mNo DNS found for $selected_country\033[0m"
  else
    i=1
    for dns in $dns_list; do
      ping_result=$(get_ping "$dns")
      echo -e "\033[1;36mDNS $i: $ping_result\033[0m"
      ((i++))
    done
  fi

  echo ""
  read -p "Press Enter to return to main menu..."
  main
}

# Exit
exit_script() {
  echo -e "\033[1;33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\033[0m"
  exit 0
}

# Main
main() {
  clear
  echo -e "\033[1;32mMahdi Dns 🔥\033[0m" | lolcat
  echo -e "\033[1;31mVersion: 1.1.0\033[0m     \033[1;36mTelegram: @Academi_vpn     Admin: @MahdiAGM0\033[0m" | lolcat
  echo ""
  show_menu
  read -p "Select an option: " opt
  case $opt in
    1) gaming_dns ;;
    2) download_dns ;;
    0) exit_script ;;
    *) echo "Invalid"; sleep 1; main ;;
  esac
}

main
