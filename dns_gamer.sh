#!/bin/bash

# Version 1.4.0 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
bold="\e[1m"
reset="\e[0m"
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
white="\e[1;37m"

# Fast Typing Function
type_text() {
    text="$1"
    delay="${2:-0.0005}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Show Title with Fast Typing (Only in main menu)
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    type_text "╔══════════════════════════════════════╗" 0.001
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.001
    type_text "╠══════════════════════════════════════╣" 0.001
    type_text "║  Version: 1.4.0                     ║" 0.001
    type_text "║  Telegram: @Academi_vpn             ║" 0.001
    type_text "║  Admin: @MahdiAGM0                  ║" 0.001
    type_text "╚══════════════════════════════════════╝" 0.001
    echo -e "${reset}"
}

# Global Variables
back_msg="Press Enter to go back to the previous menu..."
new_tag="${orange}(New)${reset}"

# 50 PC/Mobile Games with DNSs (IP1|IP2|Comment)
declare -A pc_mobile_games_dns=(
  ["Fortnite"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["PUBG Mobile"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["Call of Duty Mobile"]="9.9.9.9|149.112.112.112|Standard DNS"
  ["Arena Breakout"]="185.51.200.2|178.22.122.100|Iran VPN DNS (No Region Lock)"
  ["Minecraft"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Among Us"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Clash Royale"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Mobile Legends"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["League of Legends"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Valorant"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["Genshin Impact"]="185.228.168.9|149.112.112.112|Standard DNS"
  ["Roblox"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Free Fire"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Subway Surfers"]="9.9.9.9|149.112.112.112|Standard DNS"
  ["Garena Speed Drifters"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Battlefield V"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Rocket League"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["Overwatch"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Cyberpunk 2077"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["FIFA 22"]="9.9.9.9|149.112.112.112|Standard DNS"
  ["Assassin's Creed Valhalla"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Call of Duty: Warzone"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Clash of Clans"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Dead by Daylight"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Apex Legends"]="9.9.9.9|149.112.112.112|Standard DNS"
  ["Terraria"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Pokemon Go"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Star Wars: Battlefront II"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["World of Warcraft"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Smash Legends"]="9.9.9.9|149.112.112.112|Standard DNS"
  ["League of Legends: Wild Rift"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Dead Trigger 2"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Shadowgun Legends"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Brawl Stars"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Stumble Guys"]="9.9.9.9|149.112.112.112|Standard DNS"
  ["Dragon Ball Legends"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Clash of Kings"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Vainglory"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Farming Simulator"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Diablo Immortal"]="9.9.9.9|149.112.112.112|Standard DNS"
  ["Minecraft Dungeons"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Call of Duty: Black Ops Cold War"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Arena of Valor"]="208.67.222.222|208.67.220.220|Standard DNS"
)

# 50 Console Games with DNSs (IP1|IP2|Comment)
declare -A console_games_dns=(
  ["Fortnite"]="185.51.200.2|178.22.122.100|Low Ping Iran VPN DNS"
  ["Call of Duty: Modern Warfare"]="178.22.122.100|185.51.200.3|Standard DNS"
  ["FIFA 22"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Assassin's Creed Valhalla"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["Spider-Man: Miles Morales"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["God of War"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["The Last of Us Part II"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Red Dead Redemption 2"]="185.51.200.2|178.22.122.100|Low Ping Iran VPN DNS"
  ["Cyberpunk 2077"]="178.22.122.100|185.51.200.3|Standard DNS"
  ["Apex Legends"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Minecraft"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["Overwatch"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Resident Evil Village"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Ghost of Tsushima"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Battlefield V"]="185.51.200.2|178.22.122.100|Low Ping Iran VPN DNS"
  ["Rocket League"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Destiny 2"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["Rainbow Six Siege"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["NBA 2K22"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Gran Turismo 7"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Street Fighter V"]="185.51.200.2|178.22.122.100|Low Ping Iran VPN DNS"
  ["Halo Infinite"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Super Smash Bros. Ultimate"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["Fall Guys"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Dark Souls III"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Mortal Kombat 11"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Watch Dogs: Legion"]="185.51.200.2|178.22.122.100|Low Ping Iran VPN DNS"
  ["Death Stranding"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Control"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["Final Fantasy VII Remake"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Ghost Recon Breakpoint"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Gears 5"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Battlefield 2042"]="185.51.200.2|178.22.122.100|Low Ping Iran VPN DNS"
  ["Sea of Thieves"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["DOOM Eternal"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["The Witcher 3"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Call of Duty: Black Ops Cold War"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Monster Hunter: World"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["FIFA 21"]="185.51.200.2|178.22.122.100|Low Ping Iran VPN DNS"
  ["Godfall"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Persona 5 Royal"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["Dead Space"]="208.67.222.222|208.67.220.220|Standard DNS"
  ["Bloodborne"]="94.140.14.14|94.140.15.15|Standard DNS"
  ["Kingdom Hearts III"]="77.88.8.8|77.88.8.1|Standard DNS"
  ["Dragon Ball FighterZ"]="185.51.200.2|178.22.122.100|Low Ping Iran VPN DNS"
  ["Marvel's Avengers"]="1.1.1.1|1.0.0.1|Standard DNS"
  ["Watch Dogs 2"]="8.8.8.8|8.8.4.4|Standard DNS"
  ["Tom Clancy's The Division 2"]="208.67.222.222|208.67.220.220|Standard DNS"
)

# Download / Anti-Censorship DNS list (for banned games or general use)
download_dns_list=(
  "185.51.200.2"
  "178.22.122.100"
  "10.202.10.10"
  "10.202.10.202"
  "10.202.10.101"
  "1.1.1.1"
  "8.8.8.8"
  "8.26.56.26"
  "208.67.222.222"
  "94.140.14.14"
  "9.9.9.9"
  "185.51.200.3"
  "103.86.96.100"
  "45.90.28.0"
  "146.112.41.2"
  "76.76.2.0"
  "159.203.34.1"
  "38.132.106.139"
  "149.112.112.112"
  "185.228.168.9"
  "51.91.217.99"
)

# Helper: Show DNS pairs nicely
show_dns() {
  IFS='|' read -r primary secondary comment <<< "$1"
  echo -e "${green}Primary:${reset} $primary"
  echo -e "${green}Secondary:${reset} $secondary"
  echo -e "${cyan}Note:${reset} $comment"
}

# Main Menu
main_menu() {
    show_title
    echo -e "${bold}${blue}Main Menu:${reset}"
    echo "1. Gaming DNS (PC & Mobile)"
    echo "2. Console DNS"
    echo "3. Search Game DNS"
    echo "4. Ping DNS"
    echo "5. Download / Anti-Censorship DNS"
    echo "6. Find Best DNS (Low Ping)"
    echo "7. Auto Mode for Console"
    echo "0. Exit"
    echo -n "Choose an option: "
    read choice
    case $choice in
        1) gaming_dns_menu ;;
        2) console_dns_menu ;;
        3) search_game_dns ;;
        4) ping_dns ;;
        5) download_dns_menu ;;
        6) best_dns ;;
        7) auto_mode ;;
        0) echo "Goodbye!"; exit ;;
        *) echo "Invalid option"; sleep 1; main_menu ;;
    esac
}

# Gaming DNS Menu (PC/Mobile)
gaming_dns_menu() {
  clear
  echo -e "${bold}${blue}Gaming DNS (PC & Mobile):${reset}"
  local i=1
  for game in "${!pc_mobile_games_dns[@]}"; do
    echo "$i) $game"
    ((i++))
  done
  echo "0) Back to Main Menu"
  echo -n "Choose a game: "
  read choice
  if [[ "$choice" == "0" ]]; then main_menu; return; fi
  if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#pc_mobile_games_dns[@]} )); then
    echo "Invalid choice"; sleep 1; gaming_dns_menu
  else
    game=$(echo "${!pc_mobile_games_dns[@]}" | cut -d ' ' -f "$choice")
    dns_info=${pc_mobile_games_dns[$game]}
    clear
    echo -e "${bold}${green}Game Selected:${reset} $game"
    show_dns "$dns_info"
    echo -e "\n$back_msg"
    read
    gaming_dns_menu
  fi
}

# Console DNS Menu
console_dns_menu() {
  clear
  echo -e "${bold}${blue}Console DNS:${reset}"
  local i=1
  for game in "${!console_games_dns[@]}"; do
    echo "$i) $game"
    ((i++))
  done
  echo "0) Back to Main Menu"
  echo -n "Choose a game: "
  read choice
  if [[ "$choice" == "0" ]]; then main_menu; return; fi
  if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#console_games_dns[@]} )); then
    echo "Invalid choice"; sleep 1; console_dns_menu
  else
    game=$(echo "${!console_games_dns[@]}" | cut -d ' ' -f "$choice")
    dns_info=${console_games_dns[$game]}
    clear
    echo -e "${bold}${green}Game Selected:${reset} $game"
    show_dns "$dns_info"
    echo -e "\n$back_msg"
    read
    console_dns_menu
  fi
}

# Search Game DNS
search_game_dns() {
  read -p "Enter Game Name (partial or full): " game_input
  found=0
  clear
  echo -e "${bold}${cyan}Search Results:${reset}"
  for game in "${!pc_mobile_games_dns[@]}"; do
    if [[ "${game,,}" == *"${game_input,,}"* ]]; then
      echo -e "${green}PC/Mobile:${reset} $game"
      show_dns "${pc_mobile_games_dns[$game]}"
      echo ""
      found=1
    fi
  done
  for game in "${!console_games_dns[@]}"; do
    if [[ "${game,,}" == *"${game_input,,}"* ]]; then
      echo -e "${green}Console:${reset} $game"
      show_dns "${console_games_dns[$game]}"
      echo ""
      found=1
    fi
  done
  if (( found == 0 )); then
    echo "No results found."
  fi
  echo -e "\n$back_msg"
  read
  main_menu
}

# Ping DNS
ping_dns() {
  read -p "Enter DNS IP to ping: " dns
  if [[ -z "$dns" ]]; then
    echo "No DNS entered."
    sleep 1
    main_menu
    return
  fi
  echo "Pinging $dns..."
  result=$(ping -c 3 -W 2 $dns 2>/dev/null | grep 'time=' | tail -1 | sed -E 's/.*time=([0-9.]+) ms/\1 ms/')
  if [[ -z "$result" ]]; then
    echo "Ping failed or host unreachable."
  else
    echo "Ping result: $result"
  fi
  echo -e "\n$back_msg"
  read
  main_menu
}

# Download / Anti-Censorship DNS Menu
download_dns_menu() {
  clear
  echo -e "${bold}${cyan}Download & Anti-Censorship DNS List:${reset}"
  for dns in "${download_dns_list[@]}"; do
    echo "- $dns"
  done
  echo -e "\n$back_msg"
  read
  main_menu
}

# Best DNS (Low Ping) - example from Iran (hardcoded)
best_dns() {
  clear
  echo -e "${bold}${green}Best DNS from Iran based on low ping:${reset}"
  echo -e "Primary: 185.51.200.2"
  echo -e "Secondary: 178.22.122.100"
  echo -e "Note: Iran VPN DNS with low latency"
  echo -e "\n$back_msg"
  read
  main_menu
}

# Auto Mode for Console Games with QR Code for DNS
auto_mode() {
  clear
  echo -e "${bold}${cyan}Auto Mode for Console Games:${reset}"
  echo "Select a game:"
  local i=1
  local games=("${!console_games_dns[@]}")
  for game in "${games[@]}"; do
    echo "$i) $game"
    ((i++))
  done
  echo "0) Back to Main Menu"
  echo -n "Choice: "
  read choice
  if [[ "$choice" == "0" ]]; then main_menu; return; fi
  if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#games[@]} )); then
    echo "Invalid choice"
    sleep 1
    auto_mode
  else
    game="${games[$choice-1]}"
    dns_info="${console_games_dns[$game]}"
    IFS='|' read -r primary secondary comment <<< "$dns_info"
    clear
    echo -e "${bold}${green}Selected Game:${reset} $game"
    echo "Primary DNS: $primary"
    echo "Secondary DNS: $secondary"
    echo "Note: $comment"
    echo ""
    # Check if qrencode command exists to show QR code for DNSs
    if command -v qrencode &> /dev/null; then
      echo "QR code for Primary DNS:"
      echo "$primary" | qrencode -t ansiutf8
      echo "QR code for Secondary DNS:"
      echo "$secondary" | qrencode -t ansiutf8
    else
      echo "Install 'qrencode' to see QR codes."
    fi
    echo -e "\n$back_msg"
    read
    auto_mode
  fi
}

# Start
while true; do
  main_menu
done
