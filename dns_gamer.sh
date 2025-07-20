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

# Random colored title
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    type_text "╔══════════════════════════════════════╗" 0.0001
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0001
    type_text "╠══════════════════════════════════════╣" 0.0001
    type_text "║  Version: 1.2.4                     ║" 0.0001
    type_text "║  Telegram: @Academi_vpn             ║" 0.0001
    type_text "║  Admin: @MahdiAGM0                  ║" 0.0001
    type_text "╚══════════════════════════════════════╝" 0.0001
    echo -e "${reset}"
}

# Games list (including 10 new with (New))
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Rainbow Six Siege" "Apex Legends"
  "Rocket League" "Minecraft" "Genshin Impact" "Battlefield V" "Roblox"
  "FIFA 24" "Warzone" "Escape from Tarkov" "War Thunder" "Destiny 2"
  "Smite" "Halo Infinite" "Fall Guys" "Paladins" "World of Warcraft"
  "Elden Ring" "Cyberpunk 2077" "ARK" "Sea of Thieves" "Diablo IV"
  # New games below:
  "Arena Breakout (New)" "GTA IV (New)" "The Finals (New)" "Stalker 2 (New)"
  "Modern Warfare III (New)" "XDefiant (New)" "Hyper Front (New)"
  "Naraka Bladepoint (New)" "Starfield (New)" "Blue Protocol (New)"
)

# Countries (Middle East + Iran)
countries=(
  "Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan" "Lebanon" "Bahrain" "Kuwait"
)

# DNS pools for gaming (sample DNS)
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

# Console Games and DNS (50 items with Primary & Secondary DNS)
console_games=(
  "Call of Duty Warzone"
  "GTA Online"
  "FC25"
  "FIFA 24"
  "Minecraft"
  "Fortnite"
  "NBA 2K23"
  "Forza Horizon 5"
  "Halo Infinite"
  "Apex Legends"
  "The Last of Us Part II"
  "God of War Ragnarok"
  "Spider-Man Miles Morales"
  "Cyberpunk 2077"
  "Battlefield V"
  "Rainbow Six Siege"
  "Overwatch"
  "Destiny 2"
  "Fall Guys"
  "Sea of Thieves"
  "Red Dead Redemption 2"
  "Call of Duty Modern Warfare"
  "Assassin's Creed Valhalla"
  "Watch Dogs Legion"
  "Ghost of Tsushima"
  "Monster Hunter Rise"
  "Elden Ring"
  "Halo 5"
  "Starfield"
  "Doom Eternal"
  "Street Fighter 6"
  "Tekken 7"
  "Mario Kart 8"
  "Animal Crossing New Horizons"
  "Splatoon 3"
  "The Legend of Zelda Breath of the Wild"
  "Super Smash Bros Ultimate"
  "Gran Turismo 7"
  "Death Stranding"
  "Control"
  "Metal Gear Solid V"
  "Resident Evil Village"
  "Final Fantasy VII Remake"
  "CyberConnect2"
  "Hades"
  "Persona 5 Royal"
  "Dark Souls III"
  "Sekiro Shadows Die Twice"
  "Naraka Bladepoint"
  "Ghostrunner"
  "Returnal"
  "Ratchet & Clank Rift Apart"
)

console_dns_pool=(
  "185.51.200.2 178.22.122.100"
  "78.157.42.101 78.157.42.100"
  "185.55.225.25 185.55.226.26"
  "9.9.9.9 149.112.112.112"
  "64.6.64.6 64.6.65.6"
  "156.154.70.2 156.154.71.2"
  "159.250.35.250 159.250.35.251"
  "208.67.222.222 208.67.220.220"
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
  "84.200.69.80 84.200.70.40"
  "77.88.8.8 77.88.8.1"
  "195.46.39.39 195.46.39.40"
  "8.26.56.26 8.20.247.20"
  "199.85.126.10 199.85.127.10"
  "8.8.4.4 8.8.8.8"
  "114.114.114.114 114.114.115.115"
  "64.6.64.6 64.6.65.6"
  "208.67.222.222 208.67.220.220"
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
  "77.88.8.7 77.88.8.3"
  "80.80.80.80 80.80.81.81"
  "9.9.9.9 149.112.112.112"
  "64.6.65.6 64.6.64.6"
  "185.51.200.2 178.22.122.100"
  "78.157.42.101 78.157.42.100"
  "185.55.225.25 185.55.226.26"
  "9.9.9.9 149.112.112.112"
  "64.6.64.6 64.6.65.6"
  "156.154.70.2 156.154.71.2"
  "159.250.35.250 159.250.35.251"
  "208.67.222.222 208.67.220.220"
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
  "84.200.69.80 84.200.70.40"
  "77.88.8.8 77.88.8.1"
  "195.46.39.39 195.46.39.40"
  "8.26.56.26 8.20.247.20"
  "199.85.126.10 199.85.127.10"
  "8.8.4.4 8.8.8.8"
  "114.114.114.114 114.114.115.115"
  "64.6.64.6 64.6.65.6"
  "208.67.222.222 208.67.220.220"
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
)

# Download DNS list with unblocker & proxy
download_dns_list=(
  "Iran 185.51.200.2 178.22.122.100"
  "Iran 185.55.225.25 185.55.226.26"
  "Turkey 78.157.42.101 78.157.42.100"
  "UAE 64.6.64.6 64.6.65.6"
  "Saudi Arabia 156.154.70.2 156.154.71.2"
  "Qatar 159.250.35.250 159.250.35.251"
  "Iraq 208.67.222.222 208.67.220.220"
  "Jordan 1.1.1.1 1.0.0.1"
  "Lebanon 8.8.8.8 8.8.4.4"
  "Bahrain 149.112.112.112 9.9.9.9"
)

# Function to ping DNS and get average latency (ms)
check_ping() {
  local dns_ip=$1
  local ping_result
  ping_result=$(ping -c 3 -i 0.2 -W 1 "$dns_ip" 2>/dev/null | tail -1 | awk -F '/' '{print $5}')
  if [[ -z "$ping_result" ]]; then
    echo "Timeout"
  else
    echo "${ping_result} ms"
  fi
}

# Menu option functions

show_main_menu() {
  show_title
  echo -e "${bold}1) DNS Gaming${reset}"
  echo -e "2) Console DNS ${red}(New)${reset}"
  echo -e "3) Download DNS (Unblocker & Proxy) ${red}(New)${reset}"
  echo -e "4) Best DNS Finder ${red}(New)${reset}"
  echo -e "5) Ping Custom DNS ${red}(New)${reset}"
  echo -e "6) Search Game DNS ${red}(New)${reset}"
  echo -e "7) Exit"
  echo
  echo -ne "Choose an option: "
}

# DNS Gaming menu (choose game then country, show random DNS)
dns_gaming_menu() {
  clear
  echo -e "${bold}DNS Gaming${reset}"
  echo
  echo "Choose a game:"
  for i in "${!games[@]}"; do
    if [[ "${games[$i]}" == *"(New)"* ]]; then
      # Highlight new games: red number, orange (New) tag, no duplication of (New)
      game_name="${games[$i]//(New)/}"
      printf "\e[1;31m[%d]\e[0m %s ${orange}(New)\e[0m\n" $((i+1)) "$game_name"
    else
      printf "[%d] %s\n" $((i+1)) "${games[$i]}"
    fi
  done
  echo
  read -rp "Select game number: " game_choice
  if (( game_choice < 1 || game_choice > ${#games[@]} )); then
    echo "Invalid selection."
    sleep 1
    return
  fi

  clear
  echo "Choose a country:"
  for i in "${!countries[@]}"; do
    printf "[%d] %s\n" $((i+1)) "${countries[$i]}"
  done
  echo
  read -rp "Select country number: " country_choice
  if (( country_choice < 1 || country_choice > ${#countries[@]} )); then
    echo "Invalid selection."
    sleep 1
    return
  fi

  # Pick random DNS from pool for that game (for demo purpose, not country filtered)
  rand_index=$((RANDOM % ${#dns_pool_game[@]}))
  dns_entry=${dns_pool_game[$rand_index]}
  primary_dns=$(echo "$dns_entry" | awk '{print $1}')
  secondary_dns=$(echo "$dns_entry" | awk '{print $2}')

  echo
  echo -e "Game: ${bold}${games[$game_choice-1]}${reset}"
  echo -e "Country: ${bold}${countries[$country_choice-1]}${reset}"
  echo -e "Primary DNS: $primary_dns"
  echo -e "Secondary DNS: $secondary_dns"
  echo -e "Ping Primary: $(check_ping $primary_dns)"
  echo -e "Ping Secondary: $(check_ping $secondary_dns)"
  echo
  read -rp "Press Enter to return to menu..."
}

# Console DNS menu (select game, then show DNS and countries)
console_dns_menu() {
  clear
  echo -e "${bold}Console DNS (New)${reset}"
  echo
  echo "Choose a console game:"
  for i in "${!console_games[@]}"; do
    printf "[%d] %s\n" $((i+1)) "${console_games[$i]}"
  done
  echo
  read -rp "Select game number: " game_choice
  if (( game_choice < 1 || game_choice > ${#console_games[@]} )); then
    echo "Invalid selection."
    sleep 1
    return
  fi

  clear
  echo "Available countries:"
  for i in "${!countries[@]}"; do
    printf "[%d] %s\n" $((i+1)) "${countries[$i]}"
  done
  echo
  read -rp "Select country number: " country_choice
  if (( country_choice < 1 || country_choice > ${#countries[@]} )); then
    echo "Invalid selection."
    sleep 1
    return
  fi

  # Pick random DNS for console (not country-filtered, demo only)
  rand_index=$((RANDOM % ${#console_dns_pool[@]}))
  dns_entry=${console_dns_pool[$rand_index]}
  primary_dns=$(echo "$dns_entry" | awk '{print $1}')
  secondary_dns=$(echo "$dns_entry" | awk '{print $2}')

  echo
  echo -e "Game: ${bold}${console_games[$game_choice-1]}${reset}"
  echo -e "Country: ${bold}${countries[$country_choice-1]}${reset}"
  echo -e "Primary DNS: $primary_dns"
  echo -e "Secondary DNS: $secondary_dns"
  echo -e "Ping Primary: $(check_ping $primary_dns)"
  echo -e "Ping Secondary: $(check_ping $secondary_dns)"
  echo
  read -rp "Press Enter to return to menu..."
}

# Download DNS menu (Unblocker & Proxy)
download_dns_menu() {
  clear
  echo -e "${bold}Download DNS (Unblocker & Proxy) (New)${reset}"
  echo
  for entry in "${download_dns_list[@]}"; do
    country=$(echo $entry | awk '{print $1}')
    primary_dns=$(echo $entry | awk '{print $2}')
    secondary_dns=$(echo $entry | awk '{print $3}')

    ping_primary=$(check_ping "$primary_dns")
    ping_secondary=$(check_ping "$secondary_dns")

    echo -e "Country: ${bold}$country${reset}"
    echo -e "Primary DNS: $primary_dns"
    echo -e "Secondary DNS: $secondary_dns"
    echo -e "Ping Primary: $ping_primary"
    echo -e "Ping Secondary: $ping_secondary"
    echo
  done
  echo -e "${green}Press Enter to return to main menu...${reset}"
  read -r
}

# Best DNS Finder (finds DNS with lowest ping from pool)
best_dns_finder() {
  clear
  echo -e "${bold}Best DNS Finder (New)${reset}"
  echo
  best_dns=""
  best_ping=9999

  for entry in "${dns_pool_game[@]}"; do
    primary_dns=$(echo "$entry" | awk '{print $1}')
    ping_val=$(check_ping "$primary_dns" | awk '{print $1}')
    if [[ "$ping_val" != "Timeout" ]] && (( $(echo "$ping_val < $best_ping" | bc -l) )); then
      best_ping=$ping_val
      best_dns=$primary_dns
    fi
  done

  if [[ -n $best_dns ]]; then
    echo -e "Best DNS found: ${bold}$best_dns${reset} with ping ${best_ping} ms"
  else
    echo "No DNS responded."
  fi
  echo
  read -rp "Press Enter to return to main menu..."
}

# Ping Custom DNS (user enters DNS, pings and shows result)
ping_custom_dns() {
  clear
  echo -e "${bold}Ping Custom DNS (New)${reset}"
  echo
  read -rp "Enter DNS IP to ping: " custom_dns
  if [[ -z "$custom_dns" ]]; then
    echo "No DNS entered."
    sleep 1
    return
  fi
  ping_result=$(check_ping "$custom_dns")
  echo -e "Ping result for $custom_dns: $ping_result"
  echo
  read -rp "Press Enter to return to main menu..."
}

# Search Game DNS (search games by keyword)
search_game_dns() {
  clear
  echo -e "${bold}Search Game DNS (New)${reset}"
  echo
  read -rp "Enter game name keyword: " keyword
  if [[ -z "$keyword" ]]; then
    echo "No keyword entered."
    sleep 1
    return
  fi
  echo
  echo "Matching games:"
  for game in "${games[@]}"; do
    if [[ "${game,,}" == *"${keyword,,}"* ]]; then
      if [[ "$game" == *"(New)"* ]]; then
        game_name="${game//(New)/}"
        echo -e "${red}${game_name}${reset} ${orange}(New)${reset}"
      else
        echo "$game"
      fi
    fi
  done
  echo
  read -rp "Press Enter to return to main menu..."
}

# Main loop
while true; do
  show_main_menu
  read -r choice
  case $choice in
    1) dns_gaming_menu ;;
    2) console_dns_menu ;;
    3) download_dns_menu ;;
    4) best_dns_finder ;;
    5) ping_custom_dns ;;
    6) search_game_dns ;;
    7) clear; exit 0 ;;
    *) echo "Invalid option."; sleep 1 ;;
  esac
done
