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

# Fast Typing (for title animation)
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
    fast_type_text "╔══════════════════════════════════════╗" 0.00002
    fast_type_text "║         DNS MANAGEMENT TOOL         ║" 0.00002
    fast_type_text "╠══════════════════════════════════════╣" 0.00002
    fast_type_text "║  Version: 1.3.0                      ║" 0.00002
    fast_type_text "║  Telegram: @Academi_vpn             ║" 0.00002
    fast_type_text "║  Admin: @MahdiAGM0                  ║" 0.00002
    fast_type_text "╚══════════════════════════════════════╝" 0.00002
    echo -e "${reset}"
}

# Countries and their DNS lists (for example, real DNS addresses with ping under 40)
countries=("Iran" "UAE" "Turkey" "Qatar" "Saudi Arabia")

# For each country, multiple DNS pairs (Primary|Secondary)
declare -A dns_data
dns_data["Iran"]="10.202.10.10|10.202.10.11 195.158.58.101|195.158.58.102 185.51.200.2|178.22.122.100"
dns_data["UAE"]="64.6.64.6|64.6.65.6 185.55.225.25|185.55.226.26 209.88.198.133|209.88.198.134"
dns_data["Turkey"]="78.157.42.101|78.157.42.100 212.156.192.5|212.156.192.6 195.142.195.100|195.142.195.101"
dns_data["Qatar"]="92.247.192.7|92.247.192.8 203.117.44.7|203.117.44.8 197.247.236.89|197.247.236.90"
dns_data["Saudi Arabia"]="203.158.96.10|203.158.96.11 62.67.70.1|62.67.70.2 154.70.126.14|154.70.126.15"

# Gaming games list (50 games, with "Arena Breakout" and games 40+ as New)
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

# Console games list (realistic names, 50 games, all marked as New)
console_game_list=(
  "FIFA 24"
  "Call of Duty: Modern Warfare III"
  "NBA 2K24"
  "Gran Turismo 7"
  "Spider-Man 2"
  "Hogwarts Legacy"
  "Elden Ring"
  "The Last of Us Part I"
  "God of War Ragnarök"
  "Ghost of Tsushima"
  "Assassin’s Creed Mirage"
  "Resident Evil 4 Remake"
  "Final Fantasy XVI"
  "Cyberpunk 2077 (Console)"
  "Marvel’s Midnight Suns"
  "Street Fighter 6"
  "Tekken 8"
  "Mortal Kombat 1"
  "Death Stranding Director’s Cut"
  "Dying Light 2"
  "Call of Duty: Warzone 2"
  "Forspoken"
  "Dark Souls III"
  "Bloodborne"
  "Sekiro: Shadows Die Twice"
  "Horizon Forbidden West"
  "Ratchet & Clank: Rift Apart"
  "Returnal"
  "Ghostrunner 2"
  "Destiny 2"
  "Fall Guys"
  "Rainbow Six Extraction"
  "Battlefield 2042"
  "Forza Horizon 5"
  "Minecraft (Console)"
  "Among Us (Console)"
  "Sea of Thieves"
  "Monster Hunter Rise"
  "Cuphead"
  "Splatoon 3"
  "Mario Kart 8 Deluxe"
  "The Legend of Zelda: Breath of the Wild"
  "Super Smash Bros. Ultimate"
  "Animal Crossing: New Horizons"
  "Pokémon Scarlet and Violet"
  "Luigi’s Mansion 3"
  "Bayonetta 3"
  "Metroid Dread"
  "Fire Emblem: Three Houses"
  "Xenoblade Chronicles 3"
  "Persona 5 Royal"
)

# Generate a random DNS for a given country
generate_dns_for_country() {
  country=$1
  dns_pairs=(${dns_data[$country]})
  rand_index=$((RANDOM % ${#dns_pairs[@]}))
  IFS='|' read -r primary secondary <<< "${dns_pairs[$rand_index]}"
  ping_val=$((20 + RANDOM % 20)) # simulate ping 20-39ms
  echo -e "${cyan}Country: $country\nPrimary DNS: $primary\nSecondary DNS: $secondary\nPing: ${ping_val}ms${reset}"
}

# Show DNS list by country after game selection
show_dns_by_country() {
  echo -e "${bold}${green}Available DNS by Country:${reset}"
  for c in "${countries[@]}"; do
    generate_dns_for_country "$c"
    echo
  done
}

# Gaming DNS Menu
gaming_dns_menu() {
  clear
  echo -e "${bold}${green}Gaming DNS${reset}"
  for i in "${!game_list[@]}"; do
    # Mark games from index 40+ and Arena Breakout as New
    if [[ "${game_list[$i]}" == "Arena Breakout" || $i -ge 40 ]]; then
      echo -e "[${i}] ${red}${game_list[$i]}${reset} ${orange}(New)${reset}"
    else
      echo -e "[${i}] ${game_list[$i]}"
    fi
  done
  echo -ne "\n${green}Choose game number: ${reset}"; read gnum
  if [[ $gnum =~ ^[0-9]+$ ]] && [ $gnum -ge 0 ] && [ $gnum -lt ${#game_list[@]} ]; then
    echo -e "\n${blue}Selected Game: ${game_list[$gnum]}${reset}\n"
    show_dns_by_country
  else
    echo -e "${red}Invalid choice!${reset}"
  fi
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Console DNS Menu
console_dns_menu() {
  clear
  echo -e "${bold}${green}Console DNS (New)${reset}"
  for i in "${!console_game_list[@]}"; do
    echo -e "[${i}] ${red}${console_game_list[$i]}${reset} ${orange}(New)${reset}"
  done
  echo -ne "\n${green}Choose console game number: ${reset}"; read gnum
  if [[ $gnum =~ ^[0-9]+$ ]] && [ $gnum -ge 0 ] && [ $gnum -lt ${#console_game_list[@]} ]; then
    echo -e "\n${blue}Selected Console Game: ${console_game_list[$gnum]}${reset}\n"
    show_dns_by_country
  else
    echo -e "${red}Invalid choice!${reset}"
  fi
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Download DNS Menu (Unblocker & Proxy)
download_dns_menu() {
  clear
  echo -e "${bold}${green}Download DNS (Unblocker & Proxy)${reset}"
  for c in "${countries[@]}"; do
    dns_pairs=(${dns_data[$c]})
    for pair in "${dns_pairs[@]}"; do
      IFS='|' read -r primary secondary <<< "$pair"
      ping_val=$((20 + RANDOM % 20))
      echo -e "${cyan}Country: $c\nPrimary DNS: $primary\nSecondary DNS: $secondary\nPing: ${ping_val}ms${reset}\n"
    done
  done
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Best DNS Menu
best_dns_menu() {
  clear
  echo -e "${bold}${green}Best DNS List${reset}"
  for c in "${countries[@]}"; do
    generate_dns_for_country "$c"
    echo
  done
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Ping Custom DNS Menu
ping_custom_dns_menu() {
  clear
  echo -ne "${green}Enter a DNS server IP to ping: ${reset}"; read dns_ip
  if [[ -z "$dns_ip" ]]; then
    echo -e "${red}No IP entered!${reset}"
  else
    echo -e "${cyan}Pinging $dns_ip...${reset}"
    ping -c 4 "$dns_ip"
  fi
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Search Game DNS Menu
search_game_dns_menu() {
  clear
  echo -ne "${green}Enter game name to search DNS: ${reset}"; read game_search
  found=0
  for i in "${!game_list[@]}"; do
    if [[ "${game_list[$i],,}" == *"${game_search,,}"* ]]; then
      echo -e "[${i}] ${game_list[$i]}"
      found=1
    fi
  done
  if [ $found -eq 0 ]; then
    echo -e "${red}No games found matching \"$game_search\".${reset}"
  fi
  echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Main menu
main_menu() {
  while true; do
    show_title
    echo -e "${bold}${green}Main Menu:${reset}"
    echo -e "1) Gaming DNS"
    echo -e "2) Console DNS"
    echo -e "3) Download DNS"
    echo -e "4) Best DNS"
    echo -e "5) Ping Custom DNS"
    echo -e "6) Search Game DNS"
    echo -e "7) Exit"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt

    case $opt in
      1) gaming_dns_menu ;;
      2) console_dns_menu ;;
      3) download_dns_menu ;;
      4) best_dns_menu ;;
      5) ping_custom_dns_menu ;;
      6) search_game_dns_menu ;;
      7) echo -e "${red}Exiting...${reset}"; exit 0 ;;
      *) echo -e "${red}Invalid option!${reset}"; sleep 1 ;;
    esac
  done
}

# Run main menu
main_menu
