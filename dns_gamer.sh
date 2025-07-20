#!/bin/bash

# Version 1.2.3 | Telegram: @Academi_vpn | Admin By: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
gray="\e[90m"
reset="\e[0m"
bold="\e[1m"

# Typing animation (faster)
type_text() {
    text="$1"
    delay="${2:-0.0003}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Title
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    type_text "╔══════════════════════════════════════╗" 0.0003
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0003
    type_text "╠══════════════════════════════════════╣" 0.0003
    type_text "║  Version: 1.2.3                      ║" 0.0003
    type_text "║  Telegram: @Academi_vpn             ║" 0.0003
    type_text "║  Admin By: @MahdiAGM0                  ║" 0.0003
    type_text "╚══════════════════════════════════════╝" 0.0003
    echo -e "${reset}"
}

# Game list with NEW tags
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Rainbow Six Siege" "Apex Legends"
  "Rocket League" "Minecraft" "Genshin Impact" "Battlefield V" "Roblox"
  "FIFA 24" "Warzone" "Escape from Tarkov" "War Thunder" "Destiny 2"
  "Arena Breakout [NEW]" "Smite [NEW]" "Halo Infinite [NEW]" "Fall Guys [NEW]" "Paladins [NEW]"
  "World of Warcraft [NEW]" "Elden Ring [NEW]" "Cyberpunk 2077 [NEW]" "ARK [NEW]" "Sea of Thieves [NEW]"
)

countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan")

# DNS Pools
dns_pool_game=(
  "10.202.10.10 10.202.10.11"
  "78.157.42.101 78.157.42.100"
  "185.51.200.2 178.22.122.100"
  "185.55.225.25 185.55.226.26"
  "9.9.9.9 149.112.112.112"
  "64.6.64.6 64.6.65.6"
  "156.154.70.2 156.154.71.2"
  "159.250.35.250 159.250.35.251"
  "208.67.222.222 208.67.220.220"
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
)

dns_pool_download=(
  "10.202.10.10 10.202.10.11"
  "185.55.225.25 185.55.226.26"
  "185.51.200.2 178.22.122.100"
  "78.157.42.101 78.157.42.100"
  "91.239.100.100 89.233.43.71"
  "64.6.64.6 64.6.65.6"
  "1.1.1.1 1.0.0.1"
  "208.67.222.222 208.67.220.220"
)

# Ping test
check_ping() {
    ip="$1"
    result=$(ping -c 1 -W 1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [ -z "$result" ]; then
        echo "Timeout"
    else
        echo "${result} ms"
    fi
}

# Gaming DNS Menu
gaming_dns_menu() {
  clear
  echo -e "${bold}${green}Select a Game:${reset}"
  for i in "${!games[@]}"; do
    game="${games[$i]}"
    if [[ "$game" == *"[NEW]"* ]]; then
      clean_name="${game%% \[*}"
      printf "${red}[%2d]${reset} %s ${orange}[NEW]${reset}\n" $((i+1)) "$clean_name"
    else
      printf "${blue}[%2d]${reset} %s\n" $((i+1)) "$game"
    fi
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose a game: ${reset}"; read gopt
  [[ "$gopt" == "0" ]] && return
  [[ -z "${games[$((gopt-1))]}" ]] && echo "Invalid!" && sleep 1 && return

  clear
  echo -e "${green}Select your country:${reset}"
  for i in "${!countries[@]}"; do
    printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${countries[$i]}"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose country: ${reset}"; read copt
  [[ "$copt" == "0" ]] && return

  pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Download DNS Menu
download_dns_menu() {
  clear
  echo -e "${green}Select your country or Global DNS:${reset}"
  for i in "${!countries[@]}"; do
    printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${countries[$i]}"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose option: ${reset}"; read copt
  [[ "$copt" == "0" ]] && return

  pick=${dns_pool_download[$RANDOM % ${#dns_pool_download[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Ping your own DNS
ping_custom_dns() {
  clear
  echo -ne "${green}Enter DNS IP (e.g. 1.1.1.1): ${reset}"; read userdns
  echo -e "${cyan}DNS:${reset} $userdns"
  echo -e "${blue}Ping:${reset} $(check_ping $userdns)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Search Game DNS
search_game_dns() {
  clear
  echo -ne "${green}Enter game name to search: ${reset}"; read query
  found=0
  for i in "${!games[@]}"; do
    if [[ "${games[$i],,}" == *"${query,,}"* ]]; then
      found=1
      echo -e "${green}Match found: ${reset}${games[$i]}"
      pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
      dns1=$(echo "$pick" | awk '{print $1}')
      dns2=$(echo "$pick" | awk '{print $2}')
      echo -e "\n${cyan}Primary DNS:${reset} $dns1"
      echo -e "${cyan}Secondary DNS:${reset} $dns2"
      echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
      echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
      break
    fi
  done
  if [[ "$found" == "0" ]]; then
    echo -e "${red}No matching game found.${reset}"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Find Best DNS (Lowest Ping)
best_dns_menu() {
  clear
  best_ping=9999
  best_dns=""
  for dns in "${dns_pool_game[@]}"; do
    dns1=$(echo "$dns" | awk '{print $1}')
    dns2=$(echo "$dns" | awk '{print $2}')
    ping1=$(check_ping $dns1 | grep -o '[0-9.]*')
    [[ -z "$ping1" ]] && continue
    ping_val=${ping1%.*}
    if (( ping_val < best_ping )); then
      best_ping=$ping_val
      best_dns="$dns1 $dns2"
    fi
  done
  if [[ -n "$best_dns" ]]; then
    echo -e "${green}Best DNS (Lowest Ping):${reset}"
    echo -e "${cyan}Primary:${reset} $(echo "$best_dns" | awk '{print $1}')"
    echo -e "${cyan}Secondary:${reset} $(echo "$best_dns" | awk '{print $2}')"
    echo -e "${blue}Ping:${reset} ${best_ping} ms"
  else
    echo -e "${red}No DNS responded.${reset}"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Main Menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Download DNS ⬇️"
    echo -e "${blue}[3]${reset} Best DNS (Lowest Ping) ⭐"
    echo -e "${blue}[4]${reset} Ping Your DNS 📡"
    echo -e "${blue}[5]${reset} Search Game DNS 🔍"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt
    case $opt in
      1) gaming_dns_menu ;;
      2) download_dns_menu ;;
      3) best_dns_menu ;;
      4) ping_custom_dns ;;
      5) search_game_dns ;;
      0) echo -e "${green}Goodbye 🙏🏻${reset}"; exit ;;
      *) echo -e "${red}Invalid input!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
