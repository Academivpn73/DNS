#!/bin/bash

# Version 1.2.3 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
gray="\e[1;30m"
reset="\e[0m"
bold="\e[1m"

# Typing animation
type_text() {
    text="$1"
    delay="${2:-0.0007}"
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
    type_text "╔══════════════════════════════════════╗" 0.0004
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0004
    type_text "╠══════════════════════════════════════╣" 0.0004
    type_text "║  Version: 1.2.3                      ║" 0.0004
    type_text "║  Telegram: @Academi_vpn             ║" 0.0004
    type_text "║  Admin: @MahdiAGM0                  ║" 0.0004
    type_text "╚══════════════════════════════════════╝" 0.0004
    echo -e "${reset}"
}

# Game list
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Rainbow Six Siege" "Apex Legends"
  "Rocket League" "Minecraft" "Genshin Impact" "Battlefield V" "Roblox"
  "FIFA 24" "Warzone" "Escape from Tarkov" "War Thunder" "Destiny 2"
  "Smite" "Halo Infinite" "Fall Guys" "Paladins" "World of Warcraft"
  "Elden Ring" "Cyberpunk 2077" "ARK" "Sea of Thieves" "Diablo IV"
  "Arena Breakout [NEW]" "The Finals [NEW]" "XDefiant [NEW]" "HellDivers 2 [NEW]"
  "Gray Zone Warfare [NEW]" "BattleBit Remastered [NEW]" "Starfield [NEW]"
  "Stalker 2 [NEW]" "Squad [NEW]" "Ready or Not [NEW]"
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

# Ping Test
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
    if [[ "${games[$i]}" == *"[NEW]"* ]]; then
      printf "${gray}[%2d]${reset} %s\n" $((i+1)) "${games[$i]}"
    else
      printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${games[$i]}"
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
  echo -e "${green}Select country or global DNS:${reset}"
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

# Ping DNS (user input)
ping_dns_menu() {
  clear
  echo -ne "${green}Enter your DNS IP: ${reset}"; read user_dns
  result=$(check_ping "$user_dns")
  echo -e "\n${cyan}DNS:${reset} $user_dns"
  echo -e "${blue}Ping:${reset} $result"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Best DNS with lowest ping
best_dns_menu() {
  clear
  echo -e "${green}Finding best DNS with lowest ping...${reset}\n"
  best_dns=""
  best_ping=10000
  for dns in "${dns_pool_game[@]}"; do
    for ip in $dns; do
      ping_val=$(ping -c 1 -W 1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
      if [[ ! -z "$ping_val" ]]; then
        ping_val_int=${ping_val%.*}
        if (( ping_val_int < best_ping )); then
          best_ping=$ping_val_int
          best_dns=$ip
        fi
      fi
    done
  done

  if [[ -n "$best_dns" ]]; then
    echo -e "${cyan}Best DNS:${reset} $best_dns"
    echo -e "${blue}Ping:${reset} ${best_ping} ms"
  else
    echo -e "${red}No DNS responded!${reset}"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Search Game
search_game_menu() {
  clear
  echo -ne "${green}Enter game name: ${reset}"; read gname
  found=false
  for g in "${games[@]}"; do
    clean_g=$(echo "$g" | sed 's/ \[NEW\]//g')
    if [[ "${clean_g,,}" == *"${gname,,}"* ]]; then
      pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
      dns1=$(echo "$pick" | awk '{print $1}')
      dns2=$(echo "$pick" | awk '{print $2}')
      echo -e "\n${cyan}Game:${reset} $clean_g"
      echo -e "${cyan}Primary DNS:${reset} $dns1"
      echo -e "${cyan}Secondary DNS:${reset} $dns2"
      echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
      echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
      found=true
      break
    fi
  done
  if ! $found; then
    echo -e "${red}Game not found.${reset}"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Main Menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Download DNS ⬇️"
    echo -e "${blue}[3]${reset} Ping DNS 📶"
    echo -e "${blue}[4]${reset} Search Game 🔍"
    echo -e "${blue}[5]${reset} Best DNS (Lowest Ping) 🏆"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt
    case $opt in
      1) gaming_dns_menu ;;
      2) download_dns_menu ;;
      3) ping_dns_menu ;;
      4) search_game_menu ;;
      5) best_dns_menu ;;
      0) echo -e "${green}Goodbye!${reset}"; exit ;;
      *) echo -e "${red}Invalid input!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
