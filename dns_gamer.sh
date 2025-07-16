#!/bin/bash

# Version 1.2.1 | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
reset="\e[0m"
bold="\e[1m"

# Typing animation
type_text() {
    text="$1"
    delay="${2:-0.0015}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Random colored title
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    type_text "╔══════════════════════════════════════╗" 0.0008
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0008
    type_text "╠══════════════════════════════════════╣" 0.0008
    type_text "║  Version: 1.2.1                      ║" 0.0008
    type_text "║  Admin: @MahdiAGM0                  ║" 0.0008
    type_text "╚══════════════════════════════════════╝" 0.0008
    echo -e "${reset}"
}

# List of games (30 total)
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Rainbow Six Siege" "Apex Legends"
  "Rocket League" "Minecraft" "Genshin Impact" "Battlefield V" "Roblox"
  "FIFA 24" "Warzone" "Escape from Tarkov" "War Thunder" "Destiny 2"
  "Smite" "Halo Infinite" "Fall Guys" "Paladins" "World of Warcraft"
  "Elden Ring" "Cyberpunk 2077" "ARK" "Sea of Thieves" "Diablo IV"
)

# Middle East countries
countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan")

# Game DNS pool
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

# Download DNS pool
dns_pool_download=(
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
  "64.6.64.6 64.6.65.6"
  "156.154.70.2 156.154.71.2"
  "159.250.35.250 159.250.35.251"
  "208.67.222.222 208.67.220.220"
  "185.51.200.2 178.22.122.100"
  "9.9.9.9 149.112.112.112"
  "78.157.42.101 78.157.42.100"
  "185.55.225.25 185.55.226.26"
  "37.220.84.124 208.67.222.222"
  "74.82.42.42 0.0.0.0"
  "91.239.100.100 89.223.43.71"
  "208.67.220.200 208.67.222.222"
  "10.202.10.10 10.202.10.11"
)

# Game DNS menu
gaming_dns_menu() {
  clear
  echo -e "${bold}${green}Select a Game:${reset}"
  for i in "${!games[@]}"; do
    printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${games[$i]}"
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

  # Random DNS
  pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
  echo -e "\n${cyan}Primary DNS:${reset} $(echo $pick | awk '{print $1}')"
  echo -e "${cyan}Secondary DNS:${reset} $(echo $pick | awk '{print $2}')"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Download DNS menu
download_dns_menu() {
  clear
  echo -e "${green}Select country or global DNS:${reset}"
  for i in "${!countries[@]}"; do
    printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${countries[$i]}"
  done
  for i in {1..13}; do
    printf "${blue}[%2d]${reset} Country-$((i+8))\n" $((i+7))
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose option: ${reset}"; read copt
  [[ "$copt" == "0" ]] && return

  pick=${dns_pool_download[$RANDOM % ${#dns_pool_download[@]}]}
  echo -e "\n${cyan}Primary DNS:${reset} $(echo $pick | awk '{print $1}')"
  echo -e "${cyan}Secondary DNS:${reset} $(echo $pick | awk '{print $2}')"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Main menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Download DNS ⬇️"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt
    case $opt in
      1) gaming_dns_menu ;;
      2) download_dns_menu ;;
      0) echo -e "${green}Goodbye 🙏🏻${reset}"; exit ;;
      *) echo -e "${red}Invalid input!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
