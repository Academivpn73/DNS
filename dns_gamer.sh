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

# Typing animation (faster)
type_text() {
    text="$1"
    delay="${2:-0.0001}"
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
    type_text "╔══════════════════════════════════════╗" 0.0001
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0001
    type_text "╠══════════════════════════════════════╣" 0.0001
    type_text "║  Version: 1.2.3                      ║" 0.0001
    type_text "║  Telegram: @Academi_vpn             ║" 0.0001
    type_text "║  Admin: @MahdiAGM0                  ║" 0.0001
    type_text "╚══════════════════════════════════════╝" 0.0001
    echo -e "${reset}"
}

# Middle East countries list (used for all DNS menus)
countries=(
  "Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan" "Lebanon" "Kuwait" "Bahrain" "Oman" "Syria" "Palestine" "Yemen"
)

# Games list (with new games marked)
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Rainbow Six Siege" "Apex Legends"
  "Rocket League" "Minecraft" "Genshin Impact" "Battlefield V" "Roblox"
  "FIFA 24" "Warzone" "Escape from Tarkov" "War Thunder" "Destiny 2"
  "Smite" "Halo Infinite" "Fall Guys" "Paladins" "World of Warcraft"
  "Elden Ring" "Cyberpunk 2077" "ARK" "Sea of Thieves" "Diablo IV"
  "${red}Arena Breakout${reset} ${orange}(New)${reset}"
  "${red}GTA IV${reset} ${orange}(New)${reset}"
  "${red}The Finals${reset} ${orange}(New)${reset}"
  "${red}Stalker 2${reset} ${orange}(New)${reset}"
  "${red}Modern Warfare III${reset} ${orange}(New)${reset}"
  "${red}XDefiant${reset} ${orange}(New)${reset}"
  "${red}Hyper Front${reset} ${orange}(New)${reset}"
  "${red}Naraka Bladepoint${reset} ${orange}(New)${reset}"
  "${red}Starfield${reset} ${orange}(New)${reset}"
  "${red}Blue Protocol${reset} ${orange}(New)${reset}"
)

# Console Games list (50 games, some new marked)
console_games=(
  "Call of Duty: Warzone"
  "GTA Online"
  "Far Cry 5"
  "FIFA 24"
  "Halo Infinite"
  "The Last of Us Part II"
  "Spider-Man: Miles Morales"
  "Assassin's Creed Valhalla"
  "Cyberpunk 2077"
  "Forza Horizon 5"
  "Red Dead Redemption 2"
  "Minecraft"
  "Fortnite"
  "Overwatch"
  "Apex Legends"
  "Destiny 2"
  "Rainbow Six Siege"
  "Call of Duty: Black Ops Cold War"
  "Battlefield V"
  "Monster Hunter: World"
  "God of War"
  "The Witcher 3"
  "Dark Souls III"
  "Sekiro: Shadows Die Twice"
  "Ghost of Tsushima"
  "Dead Space"
  "Gears 5"
  "Control"
  "Watch Dogs Legion"
  "DOOM Eternal"
  "Metro Exodus"
  "Resident Evil Village"
  "Persona 5"
  "NieR: Automata"
  "Cuphead"
  "Celeste"
  "Hades"
  "Rocket League"
  "Sea of Thieves"
  "Splatoon 2"
  "Animal Crossing: New Horizons"
  "Mario Kart 8 Deluxe"
  "Super Smash Bros. Ultimate"
  "Luigi's Mansion 3"
  "Fire Emblem: Three Houses"
  "Dragon Ball FighterZ"
  "Mortal Kombat 11"
  "Street Fighter V"
  "Tekken 7"
  "${red}Arena Breakout (Console)${reset} ${orange}(New)${reset}"
  "${red}Halo Infinite (Console)${reset} ${orange}(New)${reset}"
)

# DNS pools for games (should be actual DNS servers for real use)
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

# DNS pools for console games (more DNS servers)
dns_pool_console=(
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
  "9.9.9.9 149.112.112.112"
  "64.6.64.6 64.6.65.6"
  "156.154.70.2 156.154.71.2"
  "208.67.222.222 208.67.220.220"
  "77.88.8.8 77.88.8.1"
  "185.228.168.168 185.228.169.169"
  "94.140.14.14 94.140.15.15"
  "84.200.69.80 84.200.70.40"
  "1.0.0.1 1.1.1.1"
  "8.26.56.26 8.20.247.20"
  "209.244.0.3 209.244.0.4"
  "8.8.4.4 8.8.8.8"
  "84.200.70.40 84.200.69.80"
  "64.6.65.6 64.6.64.6"
  "4.2.2.1 4.2.2.2"
  "198.101.242.72 23.253.163.53"
  "185.121.177.177 185.121.177.178"
  "198.101.242.72 23.253.163.53"
)

# DNS pools for download (proxy & unblocker DNS for youtube, blocked sites)
dns_pool_download=(
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
  "9.9.9.9 149.112.112.112"
  "64.6.64.6 64.6.65.6"
  "156.154.70.2 156.154.71.2"
  "208.67.222.222 208.67.220.220"
  "77.88.8.8 77.88.8.1"
  "185.228.168.168 185.228.169.169"
  "94.140.14.14 94.140.15.15"
  "84.200.69.80 84.200.70.40"
  "198.101.242.72 23.253.163.53"
  "185.121.177.177 185.121.177.178"
  "4.2.2.1 4.2.2.2"
  "209.244.0.3 209.244.0.4"
  "8.26.56.26 8.20.247.20"
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

# Gaming DNS menu
gaming_dns_menu() {
  clear
  echo -e "${bold}${green}Select a Game:${reset}"
  for i in "${!games[@]}"; do
    game_name="${games[$i]}"
    if [[ "$game_name" == *"(New)"* ]]; then
      # Extract name without color codes for display but keep colors
      name_no_new=$(echo "$game_name" | sed -E 's/\x1B\[[0-9;]*[mK]//g' | sed 's/ (New)//')
      printf "${red}[%2d]${reset} %s ${orange}(New)${reset}\n" $((i+1)) "$name_no_new"
    else
      printf "${blue}[%2d]${reset} %s\n" $((i+1)) "$game_name"
    fi
  done
  echo
  echo -e "${bold}${green}Select a Country:${reset}"
  for i in "${!countries[@]}"; do
    printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${countries[$i]}"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose a game number: ${reset}"; read gopt
  if [[ "$gopt" == "0" ]]; then return; fi
  if [[ -z "${games[$((gopt-1))]}" ]]; then echo -e "${red}Invalid input!${reset}"; sleep 1; return; fi
  echo -ne "${green}Choose a country number: ${reset}"; read copt
  if [[ "$copt" == "0" ]]; then return; fi
  if [[ -z "${countries[$((copt-1))]}" ]]; then echo -e "${red}Invalid input!${reset}"; sleep 1; return; fi

  # Pick random DNS from dns_pool_game
  pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Game:${reset} ${games[$((gopt-1))]}"
  echo -e "${cyan}Country:${reset} ${countries[$((copt-1))]}"
  echo -e "${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Console DNS menu
console_dns_menu() {
  clear
  echo -e "${bold}${green}Select a Console Game:${reset}"
  for i in "${!console_games[@]}"; do
    game_name="${console_games[$i]}"
    if [[ "$game_name" == *"(New)"* ]]; then
      name_no_new=$(echo "$game_name" | sed -E 's/\x1B\[[0-9;]*[mK]//g' | sed 's/ (New)//')
      printf "${red}[%2d]${reset} %s ${orange}(New)${reset}\n" $((i+1)) "$name_no_new"
    else
      printf "${blue}[%2d]${reset} %s\n" $((i+1)) "$game_name"
    fi
  done
  echo
  echo -e "${bold}${green}Select a Country:${reset}"
  for i in "${!countries[@]}"; do
    printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${countries[$i]}"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose a console game number: ${reset}"; read gopt
  if [[ "$gopt" == "0" ]]; then return; fi
  if [[ -z "${console_games[$((gopt-1))]}" ]]; then echo -e "${red}Invalid input!${reset}"; sleep 1; return; fi
  echo -ne "${green}Choose a country number: ${reset}"; read copt
  if [[ "$copt" == "0" ]]; then return; fi
  if [[ -z "${countries[$((copt-1))]}" ]]; then echo -e "${red}Invalid input!${reset}"; sleep 1; return; fi

  pick=${dns_pool_console[$RANDOM % ${#dns_pool_console[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Console Game:${reset} ${console_games[$((gopt-1))]}"
  echo -e "${cyan}Country:${reset} ${countries[$((copt-1))]}"
  echo -e "${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Download DNS menu (with unblocker DNS)
download_dns_menu() {
  clear
  echo -e "${bold}${green}Download & Unblock DNS List:${reset}"
  for i in "${!dns_pool_download[@]}"; do
    pick=${dns_pool_download[$i]}
    dns1=$(echo "$pick" | awk '{print $1}')
    dns2=$(echo "$pick" | awk '{print $2}')
    echo -e "${blue}[$((i+1))]${reset} Primary: $dns1  Secondary: $dns2"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose DNS number to ping or 0 to back: ${reset}"; read opt
  if [[ "$opt" == "0" ]]; then return; fi
  if [[ -z "${dns_pool_download[$((opt-1))]}" ]]; then
    echo -e "${red}Invalid input!${reset}"; sleep 1; return
  fi
  pick=${dns_pool_download[$((opt-1))]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')
  echo -e "${blue}Ping Primary DNS:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping Secondary DNS:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Best DNS finder
best_dns() {
  clear
  echo -e "${bold}${green}Finding Best DNS by Ping...${reset}"
  best_dns_ip=""
  best_ping=9999
  for pick in "${dns_pool_game[@]}" "${dns_pool_console[@]}" "${dns_pool_download[@]}"; do
    dns1=$(echo "$pick" | awk '{print $1}')
    ping_val=$(ping -c 1 -W 1 "$dns1" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [[ ! -z "$ping_val" ]] && (( $(echo "$ping_val < $best_ping" | bc -l) )); then
      best_ping=$ping_val
      best_dns_ip=$dns1
    fi
  done
  if [[ -z "$best_dns_ip" ]]; then
    echo -e "${red}No DNS responded!${reset}"
  else
    echo -e "${cyan}Best DNS Found:${reset} $best_dns_ip with ping ${best_ping} ms"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Ping Custom DNS entered by user
ping_custom_dns() {
  clear
  echo -ne "${green}Enter DNS IP to ping: ${reset}"; read dnsip
  if [[ -z "$dnsip" ]]; then echo -e "${red}No IP entered!${reset}"; sleep 1; return; fi
  ping_result=$(ping -c 4 "$dnsip" 2>/dev/null)
  if [[ -z "$ping_result" ]]; then
    echo -e "${red}No response from $dnsip${reset}"
  else
    echo -e "${cyan}$ping_result${reset}"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Search Game DNS by name
search_game_dns() {
  clear
  echo -ne "${green}Enter Game Name to search DNS for: ${reset}"; read game_name
  found=0
  for i in "${!games[@]}"; do
    game="${games[$i]}"
    # Remove color codes for matching
    game_plain=$(echo "$game" | sed -E 's/\x1B\[[0-9;]*[mK]//g')
    if [[ "$game_plain" =~ $game_name ]]; then
      pick=${dns_pool_game[$i % ${#dns_pool_game[@]}]}
      dns1=$(echo "$pick" | awk '{print $1}')
      dns2=$(echo "$pick" | awk '{print $2}')
      echo -e "${cyan}Game:${reset} $game_plain"
      echo -e "${cyan}Primary DNS:${reset} $dns1"
      echo -e "${cyan}Secondary DNS:${reset} $dns2"
      echo
      found=1
    fi
  done
  if [[ $found -eq 0 ]]; then
    echo -e "${red}No DNS found for game: $game_name${reset}"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Main Menu
while true; do
  show_title
  echo -e "${bold}${orange}1) Gaming DNS${reset} ${orange}(New)${reset}"
  echo -e "${bold}${orange}2) Console DNS${reset} ${orange}(New)${reset}"
  echo -e "${bold}3) Download DNS (Unblocker & Proxy)${reset}"
  echo -e "${bold}4) Best DNS Finder${reset}"
  echo -e "${bold}5) Ping Custom DNS${reset}"
  echo -e "${bold}6) Search Game DNS${reset}"
  echo -e "${bold}0) Exit${reset}"
  echo -ne "\n${green}Choose an option: ${reset}"
  read opt
  case $opt in
    1) gaming_dns_menu ;;
    2) console_dns_menu ;;
    3) download_dns_menu ;;
    4) best_dns ;;
    5) ping_custom_dns ;;
    6) search_game_dns ;;
    0) clear; exit ;;
    *) echo -e "${red}Invalid option!${reset}"; sleep 1 ;;
  esac
done
