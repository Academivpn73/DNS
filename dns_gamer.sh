#!/bin/bash

# Colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
CYAN='\e[36m'
BLUE='\e[34m'
MAGENTA='\e[35m'
RESET='\e[0m'

# Title
clear
echo -e "${CYAN}╔══════════════════════════════════════╗"
echo -e "${CYAN}║${GREEN}      DNS MANAGEMENT SCRIPT ${CYAN}        ║"
echo -e "${CYAN}╠══════════════════════════════════════╣"
echo -e "${CYAN}║  ${YELLOW}Telegram:${RESET} @Academi_vpn"
echo -e "${CYAN}║  ${YELLOW}Admin   :${RESET} @MahdiAGM0"
echo -e "${CYAN}║  ${YELLOW}Version :${RESET} 1.2.1"
echo -e "${CYAN}╚══════════════════════════════════════╝"
sleep 1

# Function to show animated menu
function animated_menu() {
  clear
  echo -e "${BLUE}Please select a section:\n"
  sleep 0.5
  echo -e "${GREEN}[1]${RESET} Gaming DNS 🎮"
  sleep 0.3
  echo -e "${GREEN}[2]${RESET} Download DNS ⬇️"
  sleep 0.3
  echo -e "${GREEN}[0]${RESET} Exit ❌"
}

# Sample data
GAMES=("Fortnite" "Call of Duty" "PUBG" "Valorant" "League of Legends" "Minecraft" "Apex Legends" "Dota 2" "CS:GO" "Overwatch"
"FIFA" "Genshin Impact" "Rocket League" "Roblox" "Free Fire" "Mobile Legends" "Battlefield" "Rainbow Six" "Honkai" "Warzone"
"Elden Ring" "Naraka" "ARK" "Brawlhalla" "Smite" "Paladins" "Halo" "Destiny 2" "The Finals" "Escape from Tarkov" 
"Crossfire" "Lost Ark" "World of Tanks" "Clash Royale" "Brawl Stars" "Diablo IV" "Rust" "Team Fortress 2" "Splatoon" "Cyberpunk 2077")

COUNTRIES=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Kuwait" "Iraq" "Jordan" "Oman" "Bahrain")

# DNS pool (Sample)
DNS_POOL=("1.1.1.1" "8.8.8.8" "9.9.9.9" "185.51.200.2" "208.67.222.222" "94.140.14.14" "76.76.2.0" "176.103.130.130"
"149.112.112.112" "64.6.64.6" "45.90.28.0" "195.46.39.39" "156.154.70.1" "198.101.242.72" "77.88.8.8" "4.2.2.2" 
"94.130.180.225" "203.80.96.10" "114.114.114.114" "202.12.27.33")

# Function to generate DNS list
generate_dns_list() {
  echo ""
  echo -e "${MAGENTA}Fetching 15 random optimized DNS...${RESET}"
  echo ""
  for i in {1..15}; do
    dns=${DNS_POOL[$RANDOM % ${#DNS_POOL[@]}]}
    ping=$(ping -c 1 -W 1 "$dns" | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1 " ms"}')
    [[ -z "$ping" ]] && ping="N/A"
    echo -e "${YELLOW}DNS $i:${RESET} ${dns}   ${CYAN}(Ping: $ping)${RESET}"
    sleep 0.1
  done
  echo ""
  read -p "Press Enter to return to menu..."
}

# Main loop
while true; do
  animated_menu
  read -p $'\n'"${GREEN}Enter your choice: ${RESET}" choice
  case $choice in
    1)
      echo -e "${MAGENTA}\n--- Select a Game ---${RESET}"
      for idx in "${!GAMES[@]}"; do
        echo -e "${GREEN}[$idx]${RESET} ${GAMES[$idx]}"
        sleep 0.02
      done
      read -p $'\n'"${CYAN}Select game index: ${RESET}" game_idx

      echo -e "${MAGENTA}\n--- Select a Country ---${RESET}"
      for idx in "${!COUNTRIES[@]}"; do
        echo -e "${GREEN}[$idx]${RESET} ${COUNTRIES[$idx]}"
        sleep 0.02
      done
      read -p $'\n'"${CYAN}Select country index: ${RESET}" country_idx

      if [[ -z "${GAMES[$game_idx]}" || -z "${COUNTRIES[$country_idx]}" ]]; then
        echo -e "${RED}Invalid selection.${RESET}"
        sleep 1
        continue
      fi

      echo -e "${YELLOW}\nGame: ${GAMES[$game_idx]} | Country: ${COUNTRIES[$country_idx]}${RESET}"
      generate_dns_list
      ;;
    2)
      echo -e "${MAGENTA}\n--- Select a Country for Download DNS ---${RESET}"
      for idx in "${!COUNTRIES[@]}"; do
        echo -e "${GREEN}[$idx]${RESET} ${COUNTRIES[$idx]}"
        sleep 0.02
      done
      read -p $'\n'"${CYAN}Select country index: ${RESET}" country_idx

      if [[ -z "${COUNTRIES[$country_idx]}" ]]; then
        echo -e "${RED}Invalid selection.${RESET}"
        sleep 1
        continue
      fi

      echo -e "${YELLOW}\nCountry: ${COUNTRIES[$country_idx]}${RESET}"
      generate_dns_list
      ;;
    0)
      echo -e "${YELLOW}\nGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn${RESET}"
      break
      ;;
    *)
      echo -e "${RED}Invalid choice. Please try again.${RESET}"
      sleep 1
      ;;
  esac
don
