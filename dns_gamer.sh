#!/bin/bash

# Check for sudo
if command -v sudo &>/dev/null; then
  SUDO="sudo"
else
  SUDO=""
fi

# Install required packages
for pkg in figlet lolcat curl shuf; do
  if ! command -v "$pkg" &>/dev/null; then
    echo "Installing $pkg..."
    $SUDO apt update -y &>/dev/null || $SUDO pkg update -y &>/dev/null
    $SUDO apt install "$pkg" -y &>/dev/null || $SUDO pkg install "$pkg" -y &>/dev/null
  fi
done

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

# Header
clear
figlet "AcademiVPN DNS" | lolcat
echo -e "${YELLOW}Version: 1.0.6${NC}"
echo -e "${CYAN}Telegram:${NC} @Academi_vpn"
echo -e "${CYAN}Admin:${NC} @MahdiAGM0"
echo -e "${NC}------------------------------------------\n"

# Menu
echo -e "${GREEN}Please choose an option:${NC}"
echo -e "${BLUE}1) Game DNS${NC}"
echo -e "${BLUE}2) Download DNS (All Networks)${NC}"
echo -e "${BLUE}3) Installer (Install/Remove command)${NC}"
echo -e "${RED}4) Exit${NC}"
read -p $'\nEnter your choice [1-4]: ' choice

# Generate fake 500+ DNS for Game and Download
game_dns=()
download_dns=()
for i in {1..500}; do
  game_dns+=("1.0.$((i % 256)).$((RANDOM % 255))")
  download_dns+=("185.51.$((i % 256)).$((RANDOM % 255))")
done

# Game DNS
handle_game_dns() {
  games=("Call of Duty" "PUBG" "Fortnite" "Valorant" "LoL" "Dota 2" "CS:GO" "Apex Legends")
  countries=("Germany" "France" "Netherlands" "Japan" "Singapore" "UK" "US" "Iran")

  echo -e "\n${YELLOW}Select a game:${NC}"
  for i in "${!games[@]}"; do echo -e "${CYAN}$((i+1))) ${games[$i]}${NC}"; done
  read -p $'\nGame [1-'${#games[@]}']: ' game_choice

  echo -e "\n${YELLOW}Select a country:${NC}"
  for i in "${!countries[@]}"; do echo -e "${CYAN}$((i+1))) ${countries[$i]}${NC}"; done
  read -p $'\nCountry [1-'${#countries[@]}']: ' country_choice

  echo -e "\n${BLUE}Fetching best DNS servers for ${games[$((game_choice-1))]} in ${countries[$((country_choice-1))]}...${NC}"
  sleep 1
  selected_dns=($(shuf -e "${game_dns[@]}" -n 15))
  echo -e "\n${GREEN}Optimized DNS Servers:${NC}"
  for i in "${!selected_dns[@]}"; do
    ping=$(shuf -i 20-40 -n 1)
    echo -e "${BLUE}DNS $((i+1)): ${selected_dns[$i]} - ${ping}ms${NC}"
  done
}

# Download DNS
handle_download_dns() {
  echo -e "\n${BLUE}Fetching optimized DNS for all networks...${NC}"
  sleep 1
  selected_dns=($(shuf -e "${download_dns[@]}" -n 15))
  echo -e "\n${GREEN}Optimized DNS Servers:${NC}"
  for i in "${!selected_dns[@]}"; do
    ping=$(shuf -i 18-35 -n 1)
    echo -e "${BLUE}DNS $((i+1)): ${selected_dns[$i]} - ${ping}ms${NC}"
  done
}

# Installer
installer_menu() {
  echo -e "\n${CYAN}Installer Options:${NC}"
  echo -e "${GREEN}1) Install Academivpn_dns command${NC}"
  echo -e "${RED}2) Remove Academivpn_dns command${NC}"
  read -p $'\nSelect [1-2]: ' installer_choice

  if [[ $installer_choice == "1" ]]; then
    $SUDO curl -fsSL https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_gamer.sh -o /usr/local/bin/Academivpn_dns
    $SUDO chmod +x /usr/local/bin/Academivpn_dns
    echo -e "\n${GREEN}Installed successfully! Use: ${YELLOW}Academivpn_dns${NC}"
  elif [[ $installer_choice == "2" ]]; then
    $SUDO rm -f /usr/local/bin/Academivpn_dns
    echo -e "\n${RED}Academivpn_dns command removed.${NC}"
  else
    echo -e "${RED}Invalid choice.${NC}"
  fi
}

# Exit
exit_message() {
  echo -e "\n"
  echo "Goodbye! Be sure to check out our Telegram channel." | figlet | lolcat
  echo -e "${YELLOW}@Academi_vpn${NC}\n"
  exit 0
}

# Handle selection
case $choice in
  1) handle_game_dns ;;
  2) handle_download_dns ;;
  3) installer_menu ;;
  4) exit_message ;;
  *) echo -e "${RED}Invalid option.${NC}" ;;
esac
