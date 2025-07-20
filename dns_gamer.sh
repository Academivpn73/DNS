#!/bin/bash

# Version 1.2.3 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
reset="\e[0m"
bold="\e[1m"

# Typing animation
type_text() {
    text="$1"
    delay="${2:-0.0003}"
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
    type_text "╔══════════════════════════════════════╗" 0.0003
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0003
    type_text "╠══════════════════════════════════════╣" 0.0003
    type_text "║  Version: 1.2.3                      ║" 0.0003
    type_text "║  Telegram: @Academi_vpn             ║" 0.0003
    type_text "║  Admin: @MahdiAGM0                  ║" 0.0003
    type_text "╚══════════════════════════════════════╝" 0.0003
    echo -e "${reset}"
}

# Games
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Rainbow Six Siege" "Apex Legends"
  "Rocket League" "Minecraft" "Genshin Impact" "Battlefield V" "Roblox"
  "FIFA 24" "Warzone" "Escape from Tarkov" "War Thunder" "Destiny 2"
  "Smite" "Halo Infinite" "Fall Guys" "Paladins" "World of Warcraft"
  "Elden Ring" "Cyberpunk 2077" "ARK" "Sea of Thieves" "Diablo IV"
  "Arena Breakout (New)" "GTA IV (New)" "The Finals (New)" "Stalker 2 (New)"
  "Modern Warfare III (New)" "XDefiant (New)" "Hyper Front (New)"
  "Naraka Bladepoint (New)" "Starfield (New)" "Blue Protocol (New)"
)

# Expanded DNS pool
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
  "94.140.14.14 94.140.15.15"
  "77.88.8.8 77.88.8.1"
  "1.2.3.4 5.6.7.8"
  "45.90.28.0 45.90.30.0"
  "76.76.2.0 76.76.10.0"
  "38.132.106.139 38.132.106.139"
  "76.223.122.150 139.178.84.217"
  "194.195.242.194 194.195.240.194"
)

# Ping Test Function
check_ping() {
    ip="$1"
    result=$(ping -c 1 -W 1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [[ -z "$result" ]]; then
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
    game_name="${games[$i]}"
    if [[ "$game_name" == *"(New)"* ]]; then
      name_no_new="${game_name%% (*}"
      printf "${red}[%2d]${reset} %s ${orange}(New)${reset}\n" $((i+1)) "$name_no_new"
    else
      printf "${blue}[%2d]${reset} %s\n" $((i+1)) "$game_name"
    fi
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose a game: ${reset}"; read gopt
  [[ "$gopt" == "0" ]] && return
  [[ -z "${games[$((gopt-1))]}" ]] && echo "Invalid!" && sleep 1 && return

  pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Main Menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Download DNS ⬇️"
    echo -e "${blue}[3]${reset} Best DNS ${orange}(New)${reset}"
    echo -e "${blue}[4]${reset} Ping Custom DNS ${orange}(New)${reset}"
    echo -e "${blue}[5]${reset} Search Game DNS ${orange}(New)${reset}"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt
    case $opt in
      1) gaming_dns_menu ;;
      2) echo "Download DNS feature coming soon..." && read ;;
      3) echo "Best DNS feature coming soon..." && read ;;
      4) echo "Ping Custom DNS feature coming soon..." && read ;;
      5) echo "Search Game DNS feature coming soon..." && read ;;
      0) echo -e "${green}Goodbye!${reset}"; exit ;;
      *) echo -e "${red}Invalid input!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
