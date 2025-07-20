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

# Games (PC & Mobile Gaming)
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Rainbow Six Siege" "Apex Legends"
  "Rocket League" "Minecraft" "Genshin Impact" "Battlefield V" "Roblox"
  "FIFA 24" "Warzone" "Escape from Tarkov" "War Thunder" "Destiny 2"
  "Smite" "Halo Infinite" "Fall Guys" "Paladins" "World of Warcraft"
  "Elden Ring" "Cyberpunk 2077" "ARK" "Sea of Thieves" "Diablo IV"
  "Arena Breakout" "GTA IV" "The Finals" "Stalker 2"
  "Modern Warfare III" "XDefiant" "Hyper Front"
  "Naraka Bladepoint" "Starfield" "Blue Protocol"
)

# Countries list (common for gaming & download DNS)
countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan")

# DNS Pools (Primary and Secondary) for Gaming
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

# Console Games List (added requested games)
console_games=(
  "God of War" "The Last of Us" "Halo Infinite" "Spider-Man" "FIFA 24"
  "Call of Duty: Modern Warfare" "Gran Turismo" "Assassin's Creed" "Forza Horizon"
  "GTA V" "Minecraft Console" "Resident Evil Village" "Final Fantasy VII Remake"
  "Cyberpunk 2077" "Battlefield 2042" "Apex Legends Console" "Destiny 2 Console"
  "Rocket League Console" "Fortnite Console" "NBA 2K24" "Mortal Kombat 11"
  "Overwatch Console" "Fall Guys Console" "Street Fighter V" "Dead Space Remake"
  "Ratchet & Clank" "Ghost of Tsushima" "Monster Hunter Rise" "Doom Eternal"
  "Splatoon 3" "Super Smash Bros Ultimate" "Animal Crossing" "The Legend of Zelda"
  "Bayonetta 3" "Metroid Dread" "Pokemon Scarlet" "Halo 5 Guardians"
  "Gears 5" "Sea of Thieves Console" "Dark Souls III" "Nier Automata"
  "Watch Dogs Legion" "Control" "Death Stranding" "Bloodborne"
  "Persona 5 Royal" "Little Nightmares II" "Tetris Effect" "No Man's Sky"
  "Hades" "Celeste" "Cuphead" "It Takes Two"
  "Call of Duty Warzone" "GTA Online" "FC25"
)

# Countries for Console DNS
console_countries=("USA" "Japan" "South Korea" "Germany" "UK" "Canada" "Australia" "France" "Brazil" "Russia")

# DNS Pools for Console (Primary and Secondary)
dns_pool_console=(
  "45.90.28.0 45.90.28.1"
  "84.200.69.80 84.200.70.40"
  "208.67.220.220 208.67.222.222"
  "8.8.8.8 8.8.4.4"
  "9.9.9.9 149.112.112.112"
  "77.88.8.8 77.88.8.1"
  "64.6.64.6 64.6.65.6"
  "156.154.70.1 156.154.71.1"
  "45.11.45.11 45.11.45.12"
  "185.222.222.222 185.222.222.223"
)

# Ping test function
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
      printf "${red}[%2d]${reset} %s ${orange}(جدید)${reset}\n" $((i+1)) "$name_no_new"
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
  echo -e "${blue}Ping Primary:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping Secondary:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Console DNS Menu with country select
console_dns_menu() {
  clear
  echo -e "${bold}${green}Select a Console Game:${reset}"
  for i in "${!console_games[@]}"; do
    printf "${red}[%2d]${reset} %s\n" $((i+1)) "${console_games[$i]}"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose a console game: ${reset}"; read opt
  [[ "$opt" == "0" ]] && return
  [[ -z "${console_games[$((opt-1))]}" ]] && echo "Invalid!" && sleep 1 && return

  # Select Country
  clear
  echo -e "${bold}${green}Select Your Country:${reset}"
  for i in "${!console_countries[@]}"; do
    printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${console_countries[$i]}"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose a country: ${reset}"; read copt
  [[ "$copt" == "0" ]] && return
  [[ -z "${console_countries[$((copt-1))]}" ]] && echo "Invalid!" && sleep 1 && return

  pick=${dns_pool_console[$RANDOM % ${#dns_pool_console[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')
  selected_game="${console_games[$((opt-1))]}"
  selected_country="${console_countries[$((copt-1))]}"

  echo -e "\n${cyan}Selected Game:${reset} $selected_game"
  echo -e "${cyan}Selected Country:${reset} $selected_country"
  echo -e "${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping Primary:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping Secondary:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Placeholder menus for other features
download_dns_menu() {
  echo -e "${green}Download DNS feature coming soon...${reset}"
  sleep 1
}

best_dns_menu() {
  echo -e "${green}Best DNS feature coming soon...${reset}"
  sleep 1
}

ping_custom_dns() {
  echo -ne "${green}Enter DNS to ping: ${reset}"; read dns
  echo -e "${blue}Ping Result:${reset} $(check_ping $dns)"
  echo -e "${green}Press Enter to return...${reset}"; read
}

search_game_dns() {
  echo -ne "${green}Enter game name to search DNS: ${reset}"; read search
  echo -e "${green}Searching DNS for game: $search ...${reset}"
  # Just dummy message for now
  echo -e "${blue}No DNS found for \"$search\" yet.${reset}"
  echo -e "${green}Press Enter to return...${reset}"; read
}

# Main Menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Download DNS ⬇️"
    echo -e "${blue}[3]${reset} Best DNS (جدید)"
    echo -e "${blue}[4]${reset} Ping Custom DNS (جدید)"
    echo -e "${blue}[5]${reset} Search Game DNS (جدید)"
    echo -e "${blue}[6]${reset} DNS کنسول 🎮"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt
    case $opt in
      1) gaming_dns_menu ;;
      2) download_dns_menu ;;
      3) best_dns_menu ;;
      4) ping_custom_dns ;;
      5) search_game_dns ;;
      6) console_dns_menu ;;
      0) echo -e "${green}Goodbye 🙏🏻${reset}"; exit ;;
      *) echo -e "${red}Invalid input!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
