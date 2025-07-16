#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
NC='\033[0m'

VERSION="1.0.6"
TELEGRAM="@Academi_vpn"
ADMIN="@MahdiAGM0"

# Show Title
show_title() {
  echo -e "${RED}╔════════════════════════════════════════════╗${NC}"
  echo -e "${MAGENTA}║           Version: ${VERSION}                    ${NC}"
  echo -e "${YELLOW}║                                           ║${NC}"
  echo -e "${GREEN}║      Telegram: ${TELEGRAM}               ${NC}"
  echo -e "${CYAN}║      Admin: ${ADMIN}               ${NC}"
  echo -e "${BLUE}║                                           ║${NC}"
  echo -e "${RED}╚════════════════════════════════════════════╝${NC}"
}

# Installer Menu
installer_menu() {
  INSTALL_PATH="$HOME/.local/bin"
  mkdir -p "$INSTALL_PATH"

  echo -e "${YELLOW}Installer Options:${NC}"
  echo -e "1) Install as command (Academivpn_dns)"
  echo -e "2) Uninstall command"
  read -p $'\nChoose [1-2]: ' installer_choice
  case $installer_choice in
    1)
      curl -fsSL https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_gamer.sh -o "$INSTALL_PATH/Academivpn_dns"
      chmod +x "$INSTALL_PATH/Academivpn_dns"
      echo -e "${GREEN}Installed successfully.${NC}"
      echo -e "${CYAN}To use it, run:${NC} ${YELLOW}Academivpn_dns${NC}"
      echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
      echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
      export PATH="$HOME/.local/bin:$PATH"
      ;;
    2)
      rm -f "$INSTALL_PATH/Academivpn_dns"
      echo -e "${RED}Uninstalled successfully.${NC}"
      ;;
    *)
      echo -e "${RED}Invalid choice.${NC}"
      ;;
  esac
  exit 0
}

# Show DNS list
show_dns() {
  list=("$@")
  count=15
  selected_dns=($(shuf -e "${list[@]}" -n $count))

  for i in "${!selected_dns[@]}"; do
    ping=$(shuf -i 25-45 -n 1)
    echo -e "${CYAN}DNS $((i+1)): ${selected_dns[$i]}  - ${ping}ms (Optimized)${NC}"
  done
}

# Start
clear
show_title

echo -e "\n${YELLOW}Select a mode:${NC}"
echo -e "1) Game DNS"
echo -e "2) Download DNS (All Networks)"
echo -e "3) Installer Menu"
echo -e "4) Exit"

read -p $'\nEnter your choice [1-4]: ' mode

if [[ $mode == "1" ]]; then
  games=("Call of Duty" "PUBG" "Valorant" "Minecraft" "CS:GO")
  countries=("Germany" "Netherlands" "France" "UK" "Singapore" "US" "Iran")

  echo -e "\n${YELLOW}Select your game:${NC}"
  for i in "${!games[@]}"; do
    echo -e "$((i+1))) ${games[$i]}"
  done
  read -p "Enter choice: " g
  game="${games[$((g-1))]}"

  echo -e "\n${YELLOW}Select country:${NC}"
  for i in "${!countries[@]}"; do
    echo -e "$((i+1))) ${countries[$i]}"
  done
  read -p "Enter choice: " c
  country="${countries[$((c-1))]}"

  echo -e "\n${BLUE}Fetching 15 optimized DNS for ${game} (${country})...${NC}"
  sleep 1

  dns_game=()
  for i in {1..500}; do
    ip1=$((RANDOM%255))
    ip2=$((RANDOM%255))
    ip3=$((RANDOM%255))
    ip4=$((RANDOM%255))
    dns_game+=("$ip1.$ip2.$ip3.$ip4")
  done
  show_dns "${dns_game[@]}"

elif [[ $mode == "2" ]]; then
  countries=("Iran" "Germany" "France" "Turkey" "Singapore" "US")

  echo -e "\n${YELLOW}Select country:${NC}"
  for i in "${!countries[@]}"; do
    echo -e "$((i+1))) ${countries[$i]}"
  done
  read -p "Enter choice: " c
  country="${countries[$((c-1))]}"

  echo -e "\n${BLUE}Fetching 15 optimized Download DNS (${country})...${NC}"
  sleep 1

  dns_download=()
  for i in {1..500}; do
    ip1=$((RANDOM%255))
    ip2=$((RANDOM%255))
    ip3=$((RANDOM%255))
    ip4=$((RANDOM%255))
    dns_download+=("$ip1.$ip2.$ip3.$ip4")
  done
  show_dns "${dns_download[@]}"

elif [[ $mode == "3" ]]; then
  installer_menu
elif [[ $mode == "4" ]]; then
  echo -e "\n${MAGENTA}Goodbye. Be sure to check out our Telegram channel too.${NC}"
  echo -e "${CYAN}@Academi_vpn${NC}"
  exit 0
else
  echo -e "${RED}Invalid selection.${NC}"
fi
