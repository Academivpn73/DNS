#!/bin/bash

# Version 1.3.0 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
reset="\e[0m"
bold="\e[1m"

# Faster typing animation for title
type_text() {
    text="$1"
    delay="${2:-0.0001}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    type_text "╔══════════════════════════════════════╗" 0.0001
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0001
    type_text "╠══════════════════════════════════════╣" 0.0001
    type_text "║  Version: 1.3.0                      ║" 0.0001
    type_text "║  Telegram: @Academi_vpn             ║" 0.0001
    type_text "║  Admin: @MahdiAGM0                  ║" 0.0001
    type_text "╚══════════════════════════════════════╝" 0.0001
    echo -e "${reset}"
}

# Middle East countries list (with Iran focus)
countries=(
  "Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan" "Kuwait" "Lebanon" "Oman"
  "Bahrain" "Palestine" "Syria" "Yemen" "Egypt"
)

# Console games list (50 games, some marked NEW)
console_games=(
  "Call of Duty Warzone (New)"
  "GTA Online (New)"
  "FC25 (New)"
  "Arena Breakout (New)"
  "FIFA 24"
  "Halo Infinite"
  "Minecraft"
  "Fortnite"
  "Overwatch"
  "Elden Ring"
  "Cyberpunk 2077"
  "Sea of Thieves"
  "Rainbow Six Siege"
  "Destiny 2"
  "Fall Guys"
  "Roblox"
  "Rocket League"
  "Smite"
  "Paladins"
  "League of Legends"
  "Dota 2"
  "Assassin's Creed Valhalla"
  "Battlefield V"
  "God of War Ragnarok (New)"
  "Starfield (New)"
  "Stalker 2 (New)"
  "Modern Warfare III (New)"
  "XDefiant (New)"
  "Hyper Front (New)"
  "Naraka Bladepoint (New)"
  "The Finals (New)"
  "FIFA 23"
  "Forza Horizon 5"
  "Gears 5"
  "Deathloop"
  "Ghost of Tsushima"
  "Metro Exodus"
  "Control"
  "The Last of Us Part II"
  "Resident Evil Village"
  "Hitman 3"
  "Horizon Forbidden West (New)"
  "Gran Turismo 7"
  "Mortal Kombat 11"
  "Cyber Hunter"
  "Valorant"
  "Apex Legends"
  "Overcooked! 2"
  "Cuphead"
  "Rocket Arena"
)

# DNS lists per game (for simplicity each game has 3 pairs, you can add more)
declare -A dns_console_primary=()
declare -A dns_console_secondary=()

# Fill DNS for each game with 3 pairs (realistic DNS or popular public DNS)
for i in "${!console_games[@]}"; do
  # Example DNS sets (you should replace or expand for real use)
  dns_console_primary[$i,0]="1.1.1.1"
  dns_console_secondary[$i,0]="1.0.0.1"

  dns_console_primary[$i,1]="8.8.8.8"
  dns_console_secondary[$i,1]="8.8.4.4"

  dns_console_primary[$i,2]="94.140.14.14"
  dns_console_secondary[$i,2]="94.140.15.15"
done

# Download DNS (unblocker / proxy style DNS for bypassing restrictions)
download_dns_list=(
  "208.67.222.222 208.67.220.220"
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
  "94.140.14.14 94.140.15.15"
  "77.88.8.8 77.88.8.1"
  "176.103.130.130 176.103.130.131"
  "198.153.192.1 198.153.194.1"
  "185.228.168.168 185.228.169.169"
  "91.239.100.100 89.233.43.71"
  "84.200.69.80 84.200.70.40"
  "8.26.56.26 8.20.247.20"
  "156.154.70.1 156.154.71.1"
  "199.85.126.10 199.85.127.10"
  "64.6.64.6 64.6.65.6"
  "195.46.39.39 195.46.39.40"
  "1.2.4.8 1.3.3.8"
  "185.222.222.222 185.222.220.220"
  "176.103.130.132 176.103.130.134"
  "8.8.4.4 8.8.8.8"
  "9.9.9.9 149.112.112.112"
)

# Ping function (timeout 1 second)
check_ping() {
    ip="$1"
    result=$(ping -c 1 -W 1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [[ -z "$result" ]]; then
        echo "Timeout"
    else
        echo "${result} ms"
    fi
}

# Show list with colors for new games
show_games() {
  local -n games_array=$1
  for i in "${!games_array[@]}"; do
    game="${games_array[$i]}"
    if [[ "$game" == *"(New)"* ]]; then
      name_no_new="${game//(New)/}"
      printf "${red}[%2d]${reset} %s ${orange}(New)${reset}\n" $((i+1)) "$name_no_new"
    else
      printf "${blue}[%2d]${reset} %s\n" $((i+1)) "$game"
    fi
  done
}

# Show list of countries
show_countries() {
  for i in "${!countries[@]}"; do
    printf "${green}[%2d]${reset} %s\n" $((i+1)) "${countries[$i]}"
  done
  echo -e "${blue}[0]${reset} Back"
}

# Console DNS menu (select game, then country, then show random DNS pair)
console_dns_menu() {
  clear
  echo -e "${bold}${green}Select a Console Game:${reset}"
  show_games console_games
  echo -ne "\n${green}Choose a game (0 to back): ${reset}"; read gopt
  [[ "$gopt" == "0" ]] && return
  if ! [[ "$gopt" =~ ^[0-9]+$ ]] || (( gopt < 1 || gopt > ${#console_games[@]} )); then
    echo -e "${red}Invalid option!${reset}"
    sleep 1
    return
  fi
  game_index=$((gopt-1))

  clear
  echo -e "${bold}${green}Select a Country:${reset}"
  show_countries
  echo -ne "\n${green}Choose a country (0 to back): ${reset}"; read copt
  [[ "$copt" == "0" ]] && return
  if ! [[ "$copt" =~ ^[0-9]+$ ]] || (( copt < 1 || copt > ${#countries[@]} )); then
    echo -e "${red}Invalid option!${reset}"
    sleep 1
    return
  fi
  country_index=$((copt-1))

  # Pick a random DNS pair index (0..2)
  dns_rand_index=$(( RANDOM % 3 ))
  primary_dns=${dns_console_primary[$game_index,$dns_rand_index]}
  secondary_dns=${dns_console_secondary[$game_index,$dns_rand_index]}

  echo -e "\n${cyan}Game:${reset} ${console_games[$game_index]}"
  echo -e "${cyan}Country:${reset} ${countries[$country_index]}"
  echo -e "${cyan}Primary DNS:${reset} $primary_dns"
  echo -e "${cyan}Secondary DNS:${reset} $secondary_dns"
  echo -e "${blue}Ping Primary:${reset} $(check_ping $primary_dns)"
  echo -e "${blue}Ping Secondary:${reset} $(check_ping $secondary_dns)"
  echo -e "${orange}(New) Console DNS${reset}"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Download DNS menu with unblocker DNS
download_dns_menu() {
  clear
  echo -e "${bold}${green}Download & Unblocker DNS List:${reset}"
  for i in "${!download_dns_list[@]}"; do
    dns_pair=${download_dns_list[$i]}
    primary_dns=$(echo $dns_pair | awk '{print $1}')
    secondary_dns=$(echo $dns_pair | awk '{print $2}')
    echo -e "${blue}[$((i+1))]${reset} Primary: $primary_dns  Secondary: $secondary_dns"
    echo -e "     Ping Primary: $(check_ping $primary_dns)  Ping Secondary: $(check_ping $secondary_dns)"
  done
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Main menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Console DNS (New) 🕹️"
    echo -e "${blue}[2]${reset} Download DNS & Unblocker 🔓"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt
    case $opt in
      1) console_dns_menu ;;
      2) download_dns_menu ;;
      0) echo -e "${green}Goodbye 🙏🏻${reset}"; exit ;;
      *) echo -e "${red}Invalid input!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
