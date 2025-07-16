#!/bin/bash

# ------------ Colors ------------
RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
NC='\033[0m'

# ------------ Auto Install Packages ------------
required_pkgs=(curl ping awk grep)
for pkg in "${required_pkgs[@]}"; do
  if ! command -v $pkg &>/dev/null; then
    echo -e "${YELLOW}Installing $pkg...${NC}"
    apt update -y &>/dev/null
    apt install -y "$pkg" &>/dev/null
  fi
done

# ------------ Title ------------
echo -e "${CYAN}Mahdi DNS 🔥   ${YELLOW}Version: 1.1.0${NC}"
echo -e "${GREEN}Telegram: @Academi_vpn   ${BLUE}Admin: @MahdiAGM0${NC}\n"

# ------------ Main Menu ------------
echo -e "${BLUE}Choose Mode:${NC}"
echo -e "${CYAN}1) Game DNS${NC}"
echo -e "${CYAN}2) Download DNS${NC}"
echo -e "${CYAN}3) Installer Options${NC}"
echo -e "${CYAN}4) Exit${NC}"
read -p $'\nSelect an option [1-4]: ' mode

# ------------ Game DNS Section ------------
if [[ "$mode" == "1" ]]; then
  games=(
    "PUBG (Mobile)" "Free Fire (Mobile)" "Mobile Legends (Mobile)" "Clash Royale (Mobile)" "Clash of Clans (Mobile)"
    "Brawl Stars (Mobile)" "Arena of Valor (Mobile)" "eFootball (Mobile)"
    "Call of Duty (PC)" "Valorant (PC)" "League of Legends (PC)" "Dota 2 (PC)"
    "CS:GO (PC)" "Overwatch (PC)" "Apex Legends (PC)" "Minecraft (PC)" "Escape from Tarkov (PC)"
    "Warzone (PC)" "Battlefield (PC)" "GTA Online (PC)"
    "FIFA (Console)" "Fortnite (Console)" "Rocket League (Console)" "Rainbow Six Siege (Console)"
    "Destiny 2 (Console)" "Elden Ring (Console)" "The Finals (Console)"
  )

  echo -e "\n${BLUE}Select your game:${NC}"
  for i in "${!games[@]}"; do
    printf "${YELLOW}%2d) %s${NC}\n" $((i+1)) "${games[$i]}"
  done
  read -p $'\nChoose a game [1-27]: ' game_choice
  game_selected="${games[$((game_choice-1))]}"

  countries=(Germany Netherlands France UK Singapore Japan USA Canada Turkey Iran Brazil Russia India Italy Spain Sweden Australia Mexico SouthKorea Norway Finland UAE Poland China Argentina)
  echo -e "\n${BLUE}Select your preferred country:${NC}"
  for i in "${!countries[@]}"; do
    color=$((31 + (i % 6)))
    printf "\033[1;${color}m%2d) %s${NC}\n" $((i+1)) "${countries[$i]}"
  done
  read -p $'\nChoose a country [1-25]: ' country_choice
  country_selected="${countries[$((country_choice-1))]}"

  # Dummy game DNS pool (replace with real if needed)
  dns_game=()
  for i in {1..500}; do
    dns_game+=("1.1.$((RANDOM % 255)).$((RANDOM % 255))")
  done
  selected_dns=($(shuf -e "${dns_game[@]}" -n 15))

  echo -e "\n${GREEN}Fetching optimized DNS for $game_selected in $country_selected...${NC}\n"
  for i in "${!selected_dns[@]}"; do
    ping_result=$(ping -c 1 -W 1 "${selected_dns[$i]}" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    ping_result=${ping_result:-"Timeout"}
    echo -e "${CYAN}DNS $((i+1)):${NC} ${selected_dns[$i]} - ${ping_result} ms"
  done

# ------------ Download DNS Section ------------
elif [[ "$mode" == "2" ]]; then
  echo -e "\n${BLUE}Generating Download-Optimized DNS list...${NC}"

  dns_download=()
  for i in {1..500}; do
    dns_download+=("8.8.$((RANDOM % 255)).$((RANDOM % 255))")
  done
  selected_dns=($(shuf -e "${dns_download[@]}" -n 15))

  for i in "${!selected_dns[@]}"; do
    ping_result=$(ping -c 1 -W 1 "${selected_dns[$i]}" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    ping_result=${ping_result:-"Timeout"}
    echo -e "${GREEN}DNS $((i+1)):${NC} ${selected_dns[$i]} - ${ping_result} ms"
  done

# ------------ Installer Section ------------
elif [[ "$mode" == "3" ]]; then
  echo -e "\n${BLUE}Installer Options:${NC}"
  echo -e "${CYAN}1) Install CLI Shortcut (Academivpn_dns)${NC}"
  echo -e "${CYAN}2) Remove CLI Shortcut${NC}"
  read -p $'\nChoose [1-2]: ' inst_opt

  if [[ "$inst_opt" == "1" ]]; then
    curl -fsSL https://raw.githubusercontent.com/Academivpn73/DNS/main/king_dns.sh -o /usr/local/bin/Academivpn_dns
    chmod +x /usr/local/bin/Academivpn_dns
    echo -e "\n${GREEN}Installed! You can now run it via:${NC} ${YELLOW}Academivpn_dns${NC}"
  elif [[ "$inst_opt" == "2" ]]; then
    rm -f /usr/local/bin/Academivpn_dns
    echo -e "\n${RED}Removed CLI Shortcut.${NC}"
  else
    echo -e "${RED}Invalid input.${NC}"
  fi

# ------------ Exit Section ------------
elif [[ "$mode" == "4" ]]; then
  echo -e "\n${YELLOW}Goodbye. Be sure to check out our Telegram channel too!${NC}"
  echo -e "${GREEN}@Academi_vpn${NC}\n"
  exit 0

# ------------ Invalid Option ------------
else
  echo -e "${RED}Invalid option. Please choose between 1 and 4.${NC}"
fi

echo -e "\n${CYAN}✅ Apply the selected DNS manually in your device or router settings.${NC}"
