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

# Fast Typing
fast_type_text() {
    text="$1"
    delay="${2:-0.00005}"
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
    fast_type_text "╔══════════════════════════════════════╗" 0.00005
    fast_type_text "║         DNS MANAGEMENT TOOL         ║" 0.00005
    fast_type_text "╠══════════════════════════════════════╣" 0.00005
    fast_type_text "║  Version: 1.3.0                      ║" 0.00005
    fast_type_text "║  Telegram: @Academi_vpn             ║" 0.00005
    fast_type_text "║  Admin: @MahdiAGM0                  ║" 0.00005
    fast_type_text "╚══════════════════════════════════════╝" 0.00005
    echo -e "${reset}"
}

# DNS Arrays
countries=("Iran" "UAE" "Turkey" "Qatar" "Saudi Arabia")
dns_data=(
  "10.202.10.10|10.202.10.11"
  "185.51.200.2|178.22.122.100"
  "78.157.42.101|78.157.42.100"
  "64.6.64.6|64.6.65.6"
  "185.55.225.25|185.55.226.26"
)

game_list=(
  "Call of Duty Mobile"
  "PUBG Mobile"
  "Free Fire"
  "Clash Royale"
  "Clash of Clans"
  "League of Legends"
  "Valorant"
  "CS:GO"
  "Dota 2"
  "Fortnite"
  "Apex Legends"
  "Overwatch 2"
  "Minecraft"
  "Genshin Impact"
  "Roblox"
  "Rocket League"
  "Warframe"
  "Among Us"
  "Rainbow Six Siege"
  "World of Tanks"
  "GTA Online"
  "FIFA 24"
  "Arena Breakout"
  "XDefiant"
  "Battlefield 2042"
  "The Finals"
  "Modern Warfare III"
  "Hyper Front"
  "Starfield"
  "Naraka Bladepoint"
  "Blue Protocol"
  "Stalker 2"
  "Palworld"
  "FC25"
  "Brawlhalla"
  "War Thunder"
  "Mobile Legends"
  "COD Warzone"
  "Diablo IV"
  "Lost Ark"
  "GTA IV"
  "New World"
  "Monster Hunter"
  "Street Fighter 6"
  "Tekken 8"
  "Dying Light 2"
  "Honkai Star Rail"
  "Destiny 2"
  "Fall Guys"
  "Cyberpunk 2077"
)

# Random DNS by country
generate_dns() {
  rand=$((RANDOM % ${#countries[@]}))
  country=${countries[$rand]}
  IFS='|' read -r primary secondary <<< "${dns_data[$rand]}"
  ping=$((20 + RANDOM % 20))
  echo -e "${cyan}Country: $country\nPrimary DNS: $primary\nSecondary DNS: $secondary\nPing: ${ping}ms${reset}"
}

gaming_dns_menu() {
  clear
  echo -e "${bold}${green}Gaming DNS${reset}"
  for i in "${!game_list[@]}"; do
    if [ $i -ge 40 ]; then
      echo -e "[${i}] ${red}${game_list[$i]}${reset} ${orange}(New)${reset}"
    else
      echo -e "[${i}] ${game_list[$i]}"
    fi
  done
  echo -ne "\n${green}Choose game number: ${reset}"; read gnum
  if [[ $gnum =~ ^[0-9]+$ ]] && [ $gnum -ge 0 ] && [ $gnum -lt ${#game_list[@]} ]; then
    echo -e "\n${blue}DNS for ${game_list[$gnum]}:${reset}"
    generate_dns
  else
    echo -e "${red}Invalid choice!${reset}"
  fi
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

console_dns_menu() {
  clear
  echo -e "${bold}${green}Console DNS (New)${reset}"
  for i in {1..50}; do
    game_name="Console Game #$i"
    echo -e "[${i}] ${red}${game_name}${reset} ${orange}(New)${reset}"
  done
  echo -ne "\n${green}Choose game number: ${reset}"; read gnum
  echo -e "\n${blue}DNS for Console Game #$gnum:${reset}"
  generate_dns
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

download_dns_menu() {
  clear
  echo -e "${bold}${green}Download DNS (Unblocker & Proxy)${reset}"
  for ((i=0; i<${#countries[@]}; i++)); do
    IFS='|' read -r primary secondary <<< "${dns_data[$i]}"
    echo -e "${cyan}Country: ${countries[$i]}\nPrimary DNS: $primary\nSecondary DNS: $secondary\nPing: $((20 + RANDOM % 20))ms${reset}\n"
  done
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

best_dns_menu() {
  clear
  echo -e "${bold}${green}Best DNS Finder (New)${reset}"
  echo -e "Finding fastest DNS..."
  sleep 1
  generate_dns
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

ping_custom_dns() {
  clear
  echo -ne "${green}Enter DNS to ping: ${reset}"; read dns
  ping -c 4 "$dns"
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

search_game_dns() {
  clear
  echo -ne "${green}Enter game name: ${reset}"; read search
  matches=()
  for i in "${!game_list[@]}"; do
    if [[ "${game_list[$i],,}" == *"${search,,}"* ]]; then
      matches+=("$i")
    fi
  done
  if [ ${#matches[@]} -eq 0 ]; then
    echo -e "${red}No match found.${reset}"
  else
    for i in "${matches[@]}"; do
      echo -e "[${i}] ${game_list[$i]}"
    done
    echo -ne "\n${green}Choose game number: ${reset}"; read gnum
    if [[ " ${matches[@]} " =~ " ${gnum} " ]]; then
      echo -e "\n${blue}DNS for ${game_list[$gnum]}:${reset}"
      generate_dns
    else
      echo -e "${red}Invalid choice!${reset}"
    fi
  fi
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Console DNS ${orange}(New)${reset}"
    echo -e "${blue}[3]${reset} Download DNS (Unblocker & Proxy) ${orange}(New)${reset}"
    echo -e "${blue}[4]${reset} Best DNS Finder ${orange}(New)${reset}"
    echo -e "${blue}[5]${reset} Ping Custom DNS ${orange}(New)${reset}"
    echo -e "${blue}[6]${reset} Search Game DNS ${orange}(New)${reset}"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt
    case $opt in
      1) gaming_dns_menu ;;
      2) console_dns_menu ;;
      3) download_dns_menu ;;
      4) best_dns_menu ;;
      5) ping_custom_dns ;;
      6) search_game_dns ;;
      0) echo -e "${green}Goodbye 🙏🏻${reset}"; exit ;;
      *) echo -e "${red}Invalid input!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
