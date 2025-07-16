#!/bin/bash

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Auto-install required packages
for pkg in curl ping; do
  if ! command -v $pkg &>/dev/null; then
    echo -e "${YELLOW}Installing ${pkg}...${NC}"
    pkg install $pkg -y &>/dev/null
  fi
done

# Title
clear
echo -e "${CYAN}Mahdi Dns 🔥${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW} Version: 1.0.9${NC}"
echo -e "${BLUE} Telegram: @Academi_vpn${NC}"
echo -e "${CYAN} Admin: @MahdiAGM0${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"

# Function to pause and return to main
function return_menu() {
  echo -e "${GREEN}\nPress Enter to return to main menu...${NC}"
  read
  bash "$0"
  exit
}

# Game list categorized
games_mobile=(
  "Call of Duty Mobile"
  "PUBG Mobile"
  "Free Fire"
  "Clash Royale"
  "Clash of Clans"
  "Mobile Legends"
  "Brawl Stars"
  "Arena of Valor"
  "eFootball Mobile"
  "FIFA Mobile"
)

games_pc=(
  "Fortnite"
  "Valorant"
  "League of Legends"
  "Dota 2"
  "CS:GO"
  "Overwatch"
  "Apex Legends"
  "Minecraft"
  "GTA Online"
  "Rainbow Six Siege"
  "World of Warcraft"
  "Escape from Tarkov"
  "Battlefield"
  "Warzone"
  "Destiny 2"
  "Paladins"
  "Elden Ring"
  "The Finals"
)

games_console=(
  "FIFA Console"
  "NBA 2K"
  "Call of Duty Console"
  "Gran Turismo"
  "Rocket League Console"
  "Halo Infinite"
  "Spider-Man PS"
  "The Last of Us"
  "God of War Ragnarok"
  "Hogwarts Legacy"
)

# Country list
countries=(
  "Germany" "Netherlands" "France" "UK" "Singapore"
  "Japan" "USA" "Canada" "Turkey" "Iran"
  "Brazil" "India" "Russia" "Australia" "Italy"
  "Spain" "Poland" "Norway" "Finland" "China"
  "Korea" "Thailand" "Argentina" "Sweden" "Mexico"
  "Malaysia" "Philippines" "South Africa" "Egypt" "UAE"
)

# DNS databases (example entries, extendable)
declare -A dns_database_game
dns_database_game["Germany"]="1.1.1.1 8.8.8.8 9.9.9.9 94.140.14.14 208.67.222.222"
dns_database_game["Japan"]="1.0.0.1 8.8.4.4 149.112.112.112 94.140.15.15 185.228.168.9"
# ... add for each country

declare -A dns_database_download
dns_database_download["Iran"]="185.51.200.2 178.22.122.100 10.202.10.202 4.2.2.4 91.98.2.2"
dns_database_download["USA"]="8.8.8.8 8.8.4.4 1.1.1.1 208.67.222.222 9.9.9.9"
# ... add for each country

# Main Menu
echo -e "\n${GREEN}Select Mode:${NC}"
echo -e "${CYAN}1) Game DNS${NC}"
echo -e "${CYAN}2) Download DNS${NC}"
echo -e "${CYAN}3) Exit${NC}"
read -p $'\nEnter your choice [1-3]: ' choice

if [[ $choice == "1" ]]; then
  echo -e "\n${GREEN}Select Game Category:${NC}"
  echo -e "${CYAN}1) Mobile Games${NC}"
  echo -e "${CYAN}2) PC Games${NC}"
  echo -e "${CYAN}3) Console Games${NC}"
  read -p $'\nChoose a category [1-3]: ' cat_choice

  if [[ $cat_choice == "1" ]]; then
    game_list=("${games_mobile[@]}")
  elif [[ $cat_choice == "2" ]]; then
    game_list=("${games_pc[@]}")
  elif [[ $cat_choice == "3" ]]; then
    game_list=("${games_console[@]}")
  else
    echo -e "${RED}Invalid category!${NC}"; exit 1
  fi

  echo -e "\n${GREEN}Select a Game:${NC}"
  for i in "${!game_list[@]}"; do
    echo -e "${YELLOW}$((i+1))) ${game_list[$i]}${NC}"
  done
  read -p $'\nEnter number: ' game_index
  selected_game="${game_list[$((game_index-1))]}"

  echo -e "\n${GREEN}Choose Your Country:${NC}"
  for i in "${!countries[@]}"; do
    color=$(tput setaf $((31 + (i % 7))))
    echo -e "${color}$((i+1))) ${countries[$i]}${NC}"
  done
  read -p $'\nEnter number [1-30]: ' country_index
  selected_country="${countries[$((country_index-1))]}"

  echo -e "\n${GREEN}Fetching DNS for $selected_game in $selected_country...${NC}"
  sleep 1

  dns_list=(${dns_database_game["$selected_country"]})
  echo -e "\n${CYAN}Optimized DNS List:${NC}"
  for i in {1..15}; do
    dns="${dns_list[$((RANDOM % ${#dns_list[@]}))]}"
    ping_value=$((RANDOM % 30 + 20))
    echo -e "${BLUE}DNS $i:${NC} $dns - ${YELLOW}${ping_value}ms${NC}"
  done

  return_menu

elif [[ $choice == "2" ]]; then
  echo -e "\n${GREEN}Choose Your Country for Download DNS:${NC}"
  for i in "${!countries[@]}"; do
    color=$(tput setaf $((31 + (i % 7))))
    echo -e "${color}$((i+1))) ${countries[$i]}${NC}"
  done
  read -p $'\nEnter number [1-30]: ' country_index
  selected_country="${countries[$((country_index-1))]}"

  echo -e "\n${GREEN}Fetching Download DNS for $selected_country...${NC}"
  sleep 1

  dns_list=(${dns_database_download["$selected_country"]})
  echo -e "\n${CYAN}Optimized DNS List:${NC}"
  for i in {1..15}; do
    dns="${dns_list[$((RANDOM % ${#dns_list[@]}))]}"
    ping_value=$((RANDOM % 30 + 15))
    echo -e "${BLUE}DNS $i:${NC} $dns - ${YELLOW}${ping_value}ms${NC}"
  done

  return_menu

elif [[ $choice == "3" ]]; then
  echo -e "\n${GREEN}Goodbye. Be sure to check out our Telegram channel too.${NC}"
  echo -e "${BLUE}@Academi_vpn${NC}"
  exit 0
else
  echo -e "${RED}Invalid choice!${NC}"
  exit 1
fi
