#!/bin/bash

# Version 1.2.4 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
reset="\e[0m"
bold="\e[1m"

# Faster typing animation for titles
fast_type_text() {
    text="$1"
    delay="${2:-0.00003}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Show colored title
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    fast_type_text "╔══════════════════════════════════════╗" 0.00003
    fast_type_text " ║        DNS MANAGEMENT TOOL         ║" 0.00003
    fast_type_text "╠══════════════════════════════════════╣" 0.00003
    fast_type_text " ║  Version: 1.2.4                    ║" 0.00003
    fast_type_text " ║  Telegram: @Academi_vpn            ║" 0.00003
    fast_type_text " ║  Admin: @MahdiAGM0                 ║" 0.00003
    fast_type_text "╚══════════════════════════════════════╝" 0.00003
    echo -e "${reset}"
}

# Gaming DNS List (Mobile + PC)
gaming_games=(
  "Arena Breakout"
  "GTA IV"
  "The Finals"
  "Stalker 2"
  "Modern Warfare III"
  "XDefiant"
  "Hyper Front"
  "Naraka Bladepoint"
  "Starfield"
  "Blue Protocol"
  "Call of Duty Mobile"
  "PUBG Mobile"
  "Fortnite"
  "Apex Legends"
  "Valorant"
  "Minecraft"
  "League of Legends"
  "Dota 2"
  "Overwatch"
  "CS:GO"
  "Rainbow Six Siege"
  "Roblox"
  "Among Us"
  "Genshin Impact"
  "Lost Ark"
  "Cyberpunk 2077"
  "Battlefield 2042"
  "Elden Ring"
  "Sea of Thieves"
  "FIFA 23"
  "Rocket League"
  "Fall Guys"
  "Dead by Daylight"
  "Rust"
  "Terraria"
  "The Witcher 3"
  "Dark Souls III"
  "Path of Exile"
  "Valorant"
  "League of Legends"
  "Call of Duty Warzone"
  "Destiny 2"
  "Marvel's Spider-Man"
  "Monster Hunter Rise"
  "Final Fantasy XIV"
  "GTA Online"
  "FC25"
  "Among Trees"
  "Halo Infinite"
  "Diablo III"
  "Star Wars Jedi: Fallen Order"
)

# Gaming DNS per game (arrays of DNS sets)
declare -A gaming_dns
gaming_dns["Arena Breakout"]="1.1.1.1|1.0.0.1 8.8.8.8|8.8.4.4 9.9.9.9|149.112.112.112"
gaming_dns["GTA IV"]="185.51.200.2|178.22.122.100 78.157.42.101|78.157.42.100 64.6.64.6|64.6.65.6"
gaming_dns["The Finals"]="208.67.222.222|208.67.220.220 1.1.1.1|1.0.0.1 9.9.9.9|149.112.112.112"
gaming_dns["Stalker 2"]="185.55.225.25|185.55.226.26 64.6.64.6|64.6.65.6 8.8.8.8|8.8.4.4"
gaming_dns["Modern Warfare III"]="10.202.10.10|10.202.10.11 1.1.1.1|1.0.0.1 208.67.222.222|208.67.220.220"
gaming_dns["XDefiant"]="185.51.200.2|178.22.122.100 78.157.42.101|78.157.42.100"
gaming_dns["Hyper Front"]="64.6.64.6|64.6.65.6 9.9.9.9|149.112.112.112 8.8.8.8|8.8.4.4"
gaming_dns["Naraka Bladepoint"]="1.1.1.1|1.0.0.1 185.51.200.2|178.22.122.100"
gaming_dns["Starfield"]="208.67.222.222|208.67.220.220 64.6.64.6|64.6.65.6"
gaming_dns["Blue Protocol"]="9.9.9.9|149.112.112.112 10.202.10.10|10.202.10.11"

# (for brevity only a few are filled, but the script will be complete with all 50)

gaming_dns["Call of Duty Mobile"]="1.1.1.1|1.0.0.1 8.8.8.8|8.8.4.4"
gaming_dns["PUBG Mobile"]="185.51.200.2|178.22.122.100 64.6.64.6|64.6.65.6"
gaming_dns["Fortnite"]="208.67.222.222|208.67.220.220 9.9.9.9|149.112.112.112"
gaming_dns["Apex Legends"]="64.6.64.6|64.6.65.6 8.8.8.8|8.8.4.4"
gaming_dns["Valorant"]="1.1.1.1|1.0.0.1 185.51.200.2|178.22.122.100"
gaming_dns["Minecraft"]="208.67.222.222|208.67.220.220 64.6.64.6|64.6.65.6"
gaming_dns["League of Legends"]="9.9.9.9|149.112.112.112 8.8.8.8|8.8.4.4"
gaming_dns["Dota 2"]="1.1.1.1|1.0.0.1 208.67.222.222|208.67.220.220"
gaming_dns["Overwatch"]="185.51.200.2|178.22.122.100 64.6.64.6|64.6.65.6"
gaming_dns["CS:GO"]="64.6.64.6|64.6.65.6 1.1.1.1|1.0.0.1"
gaming_dns["Rainbow Six Siege"]="208.67.222.222|208.67.220.220 9.9.9.9|149.112.112.112"
gaming_dns["Roblox"]="185.51.200.2|178.22.122.100 8.8.8.8|8.8.4.4"
gaming_dns["Among Us"]="64.6.64.6|64.6.65.6 208.67.222.222|208.67.220.220"
gaming_dns["Genshin Impact"]="1.1.1.1|1.0.0.1 9.9.9.9|149.112.112.112"
gaming_dns["Lost Ark"]="185.51.200.2|178.22.122.100 64.6.64.6|64.6.65.6"
gaming_dns["Cyberpunk 2077"]="208.67.222.222|208.67.220.220 1.1.1.1|1.0.0.1"
gaming_dns["Battlefield 2042"]="9.9.9.9|149.112.112.112 185.51.200.2|178.22.122.100"
gaming_dns["Elden Ring"]="64.6.64.6|64.6.65.6 8.8.8.8|8.8.4.4"
gaming_dns["Sea of Thieves"]="1.1.1.1|1.0.0.1 208.67.222.222|208.67.220.220"
gaming_dns["FIFA 23"]="185.51.200.2|178.22.122.100 9.9.9.9|149.112.112.112"
gaming_dns["Rocket League"]="64.6.64.6|64.6.65.6 185.51.200.2|178.22.122.100"
gaming_dns["Fall Guys"]="1.1.1.1|1.0.0.1 8.8.8.8|8.8.4.4"
gaming_dns["Dead by Daylight"]="208.67.222.222|208.67.220.220 64.6.64.6|64.6.65.6"
gaming_dns["Rust"]="185.51.200.2|178.22.122.100 9.9.9.9|149.112.112.112"
gaming_dns["Terraria"]="64.6.64.6|64.6.65.6 1.1.1.1|1.0.0.1"
gaming_dns["The Witcher 3"]="208.67.222.222|208.67.220.220 185.51.200.2|178.22.122.100"
gaming_dns["Dark Souls III"]="1.1.1.1|1.0.0.1 9.9.9.9|149.112.112.112"
gaming_dns["Path of Exile"]="64.6.64.6|64.6.65.6 185.51.200.2|178.22.122.100"
gaming_dns["Call of Duty Warzone"]="208.67.222.222|208.67.220.220 64.6.64.6|64.6.65.6"
gaming_dns["Destiny 2"]="1.1.1.1|1.0.0.1 185.51.200.2|178.22.122.100"
gaming_dns["Marvel's Spider-Man"]="208.67.222.222|208.67.220.220 8.8.8.8|8.8.4.4"
gaming_dns["Monster Hunter Rise"]="1.1.1.1|1.0.0.1 64.6.64.6|64.6.65.6"
gaming_dns["Final Fantasy XIV"]="208.67.222.222|208.67.220.220 185.51.200.2|178.22.122.100"
gaming_dns["GTA Online"]="1.1.1.1|1.0.0.1 9.9.9.9|149.112.112.112"
gaming_dns["FC25"]="185.51.200.2|178.22.122.100 64.6.64.6|64.6.65.6"
gaming_dns["Among Trees"]="208.67.222.222|208.67.220.220 1.1.1.1|1.0.0.1"
gaming_dns["Halo Infinite"]="185.51.200.2|178.22.122.100 9.9.9.9|149.112.112.112"
gaming_dns["Diablo III"]="64.6.64.6|64.6.65.6 1.1.1.1|1.0.0.1"
gaming_dns["Star Wars Jedi: Fallen Order"]="185.51.200.2|178.22.122.100 208.67.222.222|208.67.220.220"

# Mark some new games
new_gaming_games=("Arena Breakout" "The Finals" "Stalker 2" "Modern Warfare III" "XDefiant" "Hyper Front" "Naraka Bladepoint" "Starfield" "Blue Protocol")

# Console DNS List with country-based DNS (Middle East focused)
console_games=(
  "PlayStation 5"
  "Xbox Series X"
  "Nintendo Switch"
  "PlayStation 4"
  "Xbox One"
  "PlayStation 3"
  "Xbox 360"
  "Nintendo Wii U"
  "Nintendo 3DS"
  "PlayStation Vita"
  "Sega Genesis"
  "Atari 2600"
  "Neo Geo"
  "Dreamcast"
  "GameCube"
  "Wii"
  "PlayStation Portable"
  "Xbox Original"
  "Game Boy Advance"
  "Nintendo DS"
  "PSP Go"
  "PlayStation 2"
  "Sega Saturn"
  "TurboGrafx-16"
  "Nintendo Switch OLED"
  "Xbox Series S"
  "Game Boy Color"
  "Nintendo GameCube"
  "PlayStation Classic"
  "Atari Jaguar"
  "Intellivision"
  "ColecoVision"
  "Vectrex"
  "Magnavox Odyssey"
  "Neo Geo Pocket"
  "WonderSwan"
  "PS5 Digital Edition"
  "Xbox Series X|S"
  "PlayStation 5 Pro"
  "Nintendo Switch Lite"
  "Xbox One S"
  "PlayStation 4 Pro"
  "Xbox One X"
  "Nintendo Switch Pro"
  "Xbox Series X Pro"
  "Nintendo Wii Mini"
  "PlayStation Portable Go"
  "Sega Dreamcast"
  "Sega Genesis Mini"
  "Xbox 360 Slim"
  "Nintendo DS Lite"
)

# DNS per console country (example for Middle East)
declare -A console_dns
console_dns["Iran"]="10.202.10.10|10.202.10.11 8.8.8.8|8.8.4.4 185.51.200.2|178.22.122.100"
console_dns["UAE"]="185.51.200.2|178.22.122.100 78.157.42.101|78.157.42.100 64.6.64.6|64.6.65.6"
console_dns["Turkey"]="78.157.42.101|78.157.42.100 64.6.64.6|64.6.65.6 208.67.222.222|208.67.220.220"
console_dns["Qatar"]="64.6.64.6|64.6.65.6 185.55.225.25|185.55.226.26 9.9.9.9|149.112.112.112"
console_dns["Saudi Arabia"]="185.55.225.25|185.55.226.26 8.8.8.8|8.8.4.4 1.1.1.1|1.0.0.1"

# New consoles marked
new_console_games=("PlayStation 5" "Xbox Series X" "Nintendo Switch" "PlayStation 5 Pro" "Xbox Series X|S")

# Download DNS list
download_dns_list=(
  "Country: Iran | Primary: 10.202.10.10 | Secondary: 10.202.10.11"
  "Country: UAE | Primary: 185.51.200.2 | Secondary: 178.22.122.100"
  "Country: Turkey | Primary: 78.157.42.101 | Secondary: 78.157.42.100"
  "Country: Qatar | Primary: 64.6.64.6 | Secondary: 64.6.65.6"
  "Country: Saudi Arabia | Primary: 185.55.225.25 | Secondary: 185.55.226.26"
)

# Functions

# Select a random DNS from a list separated by spaces, each DNS pair separated by space
pick_random_dns() {
  dns_string="$1"
  IFS=' ' read -r -a dns_pairs <<< "$dns_string"
  random_pair=${dns_pairs[$RANDOM % ${#dns_pairs[@]}]}
  IFS='|' read -r primary secondary <<< "$random_pair"
  echo "Primary DNS: $primary"
  echo "Secondary DNS: $secondary"
}

# Gaming DNS menu
gaming_dns_menu() {
  clear
  echo -e "${bold}${green}Gaming DNS (Mobile & PC)${reset}"
  for i in "${!gaming_games[@]}"; do
    game=${gaming_games[$i]}
    # Check if game is new
    is_new=""
    for ng in "${new_gaming_games[@]}"; do
      if [[ "$game" == "$ng" ]]; then
        is_new="${orange}[New]${reset}"
        break
      fi
    done
    echo -e "${blue}[$((i+1))]${reset} $game $is_new"
  done
  echo -ne "\n${green}Choose a game number: ${reset}"; read choice
  if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#gaming_games[@]} )); then
    echo -e "${red}Invalid choice!${reset}"; sleep 1; return
  fi
  selected_game=${gaming_games[$((choice-1))]}
  echo -e "${cyan}Selected: $selected_game${reset}"
  dns_options=${gaming_dns["$selected_game"]}
  pick_random_dns "$dns_options"
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Console DNS menu
console_dns_menu() {
  clear
  echo -e "${bold}${green}Console DNS (Middle East)${reset}"
  for i in "${!console_games[@]}"; do
    game=${console_games[$i]}
    # Check if console is new
    is_new=""
    for nc in "${new_console_games[@]}"; do
      if [[ "$game" == "$nc" ]]; then
        is_new="${orange}[New]${reset}"
        break
      fi
    done
    echo -e "${blue}[$((i+1))]${reset} $game $is_new"
  done
  echo -ne "\n${green}Choose a console number: ${reset}"; read choice
  if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#console_games[@]} )); then
    echo -e "${red}Invalid choice!${reset}"; sleep 1; return
  fi
  selected_console=${console_games[$((choice-1))]}
  echo -e "${cyan}Selected: $selected_console${reset}"
  
  # Determine country DNS based on console selection (for demo, randomly select country DNS)
  countries=(Iran UAE Turkey Qatar Saudi Arabia)
  selected_country=${countries[$RANDOM % ${#countries[@]}]}
  echo -e "${green}Country DNS: $selected_country${reset}"
  dns_options=${console_dns["$selected_country"]}
  pick_random_dns "$dns_options"
  
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Download DNS menu
download_dns_menu() {
  clear
  echo -e "${bold}${green}Download DNS (Unblocker)${reset}"
  for dns in "${download_dns_list[@]}"; do
    echo -e "${cyan}$dns${reset}"
  done
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Best DNS Finder (placeholder)
best_dns_menu() {
  clear
  echo -e "${bold}${green}Best DNS Finder (New)${reset}"
  echo -e "[Under development: Will automatically select the fastest DNS based on your location]"
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Ping Custom DNS (placeholder)
ping_custom_dns() {
  clear
  echo -e "${bold}${green}Ping Custom DNS (New)${reset}"
  echo -e "[Under development: You will enter a DNS and script will ping it and show latency]"
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Search Game DNS (placeholder)
search_game_dns() {
  clear
  echo -e "${bold}${green}Search Game DNS (New)${reset}"
  echo -e "[Under development: Search a game name and get DNS suggestions]"
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Main menu
main_menu() {
  while true; do
    show_title
    echo -e
