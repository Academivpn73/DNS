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

# Typing animation with faster speed
type_text() {
    text="$1"
    delay="${2:-0.0001}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Random colored title faster
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    type_text "╔══════════════════════════════════════╗" 0.0001
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0001
    type_text "╠══════════════════════════════════════╣" 0.0001
    type_text "║  Version: 1.2.3                      ║" 0.0001
    type_text "║  Telegram: @Academi_vpn              ║" 0.0001
    type_text "║  Admin: @MahdiAGM0                   ║" 0.0001
    type_text "╚══════════════════════════════════════╝" 0.0001
    echo -e "${reset}"
}

# Middle East countries list
countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan" "Lebanon" "Kuwait" "Bahrain" "Oman")

# Game list with 10 new games (new games marked "(New)" with orange color, index red)
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

# Game DNS pools - one or two DNS per game (for demo using dummy IPs, replace with real DNS)
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
  # Add more for new games or map properly by index if desired
)

# Console games list (50+), all marked (New)
consoles=(
  "Call of Duty Warzone (New)" "GTA Online (New)" "FC25 (New)" "FIFA 24 (New)"
  "The Last of Us (New)" "God of War (New)" "Halo Infinite (New)" "Spider-Man (New)"
  "Assassin's Creed Valhalla (New)" "Forza Horizon 5 (New)" "Cyberpunk 2077 (New)"
  "Resident Evil Village (New)" "Elden Ring (New)" "Horizon Forbidden West (New)"
  "Deathloop (New)" "Ratchet & Clank (New)" "Ghost of Tsushima (New)"
  "Red Dead Redemption 2 (New)" "Monster Hunter Rise (New)" "Among Us (New)"
  "Minecraft Dungeons (New)" "Fall Guys (New)" "Valorant Console (New)"
  "Rainbow Six Siege Console (New)" "Rocket League Console (New)" "Apex Legends Console (New)"
  "Overwatch Console (New)" "Fortnite Console (New)" "Battlefield 2042 (New)"
  "Destiny 2 Console (New)" "Gears 5 (New)" "Doom Eternal (New)" "Mortal Kombat 11 (New)"
  "Street Fighter V (New)" "Super Smash Bros (New)" "Splatoon 3 (New)"
  "Mario Kart 8 Deluxe (New)" "Animal Crossing (New)" "Pokemon Legends (New)"
  "Metroid Dread (New)" "Luigi’s Mansion 3 (New)" "Bayonetta 3 (New)"
  "Fire Emblem (New)" "Dark Souls III (New)" "Sekiro (New)" "Control (New)"
  "Death Stranding (New)" "Nier Automata (New)" "Celeste (New)" "Hades (New)" "Cuphead (New)"
)

# Console DNS pool, with Primary and Secondary for each (dummy IPs, replace with real ones)
dns_pool_console=(
  "192.168.10.10 192.168.10.11"
  "192.168.20.10 192.168.20.11"
  "192.168.30.10 192.168.30.11"
  "192.168.40.10 192.168.40.11"
  "192.168.50.10 192.168.50.11"
  "192.168.60.10 192.168.60.11"
  "192.168.70.10 192.168.70.11"
  "192.168.80.10 192.168.80.11"
  "192.168.90.10 192.168.90.11"
  "192.168.100.10 192.168.100.11"
  "192.168.110.10 192.168.110.11"
  "192.168.120.10 192.168.120.11"
  "192.168.130.10 192.168.130.11"
  "192.168.140.10 192.168.140.11"
  "192.168.150.10 192.168.150.11"
  "192.168.160.10 192.168.160.11"
  "192.168.170.10 192.168.170.11"
  "192.168.180.10 192.168.180.11"
  "192.168.190.10 192.168.190.11"
  "192.168.200.10 192.168.200.11"
  "192.168.210.10 192.168.210.11"
  "192.168.220.10 192.168.220.11"
  "192.168.230.10 192.168.230.11"
  "192.168.240.10 192.168.240.11"
  "192.168.250.10 192.168.250.11"
  "192.168.251.10 192.168.251.11"
  "192.168.252.10 192.168.252.11"
  "192.168.253.10 192.168.253.11"
  "192.168.254.10 192.168.254.11"
  "192.168.255.10 192.168.255.11"
  "10.0.0.10 10.0.0.11"
  "10.0.1.10 10.0.1.11"
  "10.0.2.10 10.0.2.11"
  "10.0.3.10 10.0.3.11"
  "10.0.4.10 10.0.4.11"
  "10.0.5.10 10.0.5.11"
  "10.0.6.10 10.0.6.11"
  "10.0.7.10 10.0.7.11"
  "10.0.8.10 10.0.8.11"
  "10.0.9.10 10.0.9.11"
  "10.0.10.10 10.0.10.11"
  "10.0.11.10 10.0.11.11"
  "10.0.12.10 10.0.12.11"
  "10.0.13.10 10.0.13.11"
  "10.0.14.10 10.0.14.11"
  "10.0.15.10 10.0.15.11"
)

# Download DNS (anti-censorship / unblock YouTube etc)
dns_pool_download=(
  "208.67.222.123 208.67.220.123"    # OpenDNS FamilyShield
  "208.67.222.222 208.67.220.220"    # OpenDNS Home
  "8.8.8.8 8.8.4.4"                  # Google DNS
  "1.1.1.1 1.0.0.1"                  # Cloudflare DNS
  "94.140.14.14 94.140.15.15"        # AdGuard DNS
  "9.9.9.9 149.112.112.112"          # Quad9 DNS
  "77.88.8.8 77.88.8.1"              # Yandex DNS
  "84.200.69.80 84.200.70.40"        # DNS.WATCH
  "176.103.130.130 176.103.130.131"  # CleanBrowsing Family Filter
  "185.228.168.9 185.228.169.9"      # CleanBrowsing Adult Filter
  "195.46.39.39 195.46.39.40"        # OpenNIC
  "64.6.64.6 64.6.65.6"              # Verisign Public DNS
  "45.90.28.0 45.90.28.1"            # OpenNIC (alt)
  "77.109.147.66 77.109.147.67"      # SafeDNS
  "76.76.19.19 76.223.122.150"       # Alternate DNS
  "23.253.163.53 23.253.163.54"      # UncensoredDNS
  "80.80.80.80 80.80.81.81"          # FDN
  "37.235.1.174 37.235.1.177"        # puntCAT
  "81.218.119.11 209.88.198.133"     # OpenDNS FamilyShield alt
  "198.101.242.72 23.253.163.53"     # DNS.WATCH alt
)

# Ping function with timeout and ms output
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
      name_no_new="${game_name%% (*}"
      printf "${red}[%2d]${reset} %s ${orange}(New)${reset}\n" $((i+1)) "$name_no_new"
    else
      printf "${blue}[%2d]${reset} %s\n" $((i+1)) "$game_name"
    fi
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose a game: ${reset}"; read gopt
  [[ "$gopt" == "0" ]] && return
  if [[ -z "${games[$((gopt-1))]}" ]]; then
    echo -e "${red}Invalid choice!${reset}"
    sleep 1
    return
  fi

  # Random DNS pick from pool
  pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping Primary:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping Secondary:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Console DNS menu
console_dns_menu() {
  clear
  echo -e "${bold}${green}Select a Console Game:${reset}"
  for i in "${!consoles[@]}"; do
    name="${consoles[$i]}"
    # Strip (New) for printing nicely but add orange (New) after
    name_no_new="${name%% (*}"
    printf "${red}[%2d]${reset} %s ${orange}(New)${reset}\n" $((i+1)) "$name_no_new"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose a console game: ${reset}"; read copt
  [[ "$copt" == "0" ]] && return
  if [[ -z "${consoles[$((copt-1))]}" ]]; then
    echo -e "${red}Invalid choice!${reset}"
    sleep 1
    return
  fi

  # Pick DNS pair for console game (using index modulo length)
  idx=$(( (copt-1) % ${#dns_pool_console[@]} ))
  pick="${dns_pool_console[$idx]}"
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping Primary:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping Secondary:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Download DNS menu
download_dns_menu() {
  clear
  echo -e "${bold}${green}Download / Unblock DNS (Anti-Censorship):${reset}"
  for i in "${!dns_pool_download[@]}"; do
    dns_pair="${dns_pool_download[$i]}"
    printf "${red}[%2d]${reset} %s\n" $((i+1)) "$dns_pair"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose DNS pair: ${reset}"; read dopt
  [[ "$dopt" == "0" ]] && return
  if [[ -z "${dns_pool_download[$((dopt-1))]}" ]]; then
    echo -e "${red}Invalid choice!${reset}"
    sleep 1
    return
  fi

  dns1=$(echo "${dns_pool_download[$((dopt-1))]}" | awk '{print $1}')
  dns2=$(echo "${dns_pool_download[$((dopt-1))]}" | awk '{print $2}')
  echo -e "\n${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping Primary:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping Secondary:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Main menu
main_menu() {
  while true; do
    show_title
    echo -e "${bold}${green}Main Menu:${reset}"
    echo -e "${blue}[1]${reset} Game DNS"
    echo -e "${blue}[2]${reset} Console DNS ${orange}(New)${reset}"
    echo -e "${blue}[3]${reset} Download DNS (Anti-Censorship)"
    echo -e "${blue}[0]${reset} Exit"
    echo -ne "\n${green}Choose an option: ${reset}"
    read option
    case $option in
      1) gaming_dns_menu ;;
      2) console_dns_menu ;;
      3) download_dns_menu ;;
      0) echo -e "${green}Goodbye!${reset}"; exit 0 ;;
      *) echo -e "${red}Invalid option!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
