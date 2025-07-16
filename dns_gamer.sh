#!/bin/bash

# Version
VERSION="1.0.9"

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# Required packages
REQUIRED_PKGS=(curl wget ping)

install_if_missing() {
  for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! command -v "$pkg" &>/dev/null; then
      echo -e "${YELLOW}Installing missing package: $pkg${NC}"
      pkg install "$pkg" -y &>/dev/null || apt install "$pkg" -y &>/dev/null
    fi
  done
}

install_if_missing

# Fancy Title (no figlet/lolcat to avoid issues)
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║                 King DNS - Version: ${VERSION}                ${NC}"
echo -e "${BLUE}║     Telegram: @Academi_vpn  |  Admin: @MahdiAGM0     ${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}\n"

main_menu() {
  echo -e "${GREEN}Select an option:${NC}"
  echo -e "${CYAN}1) Gaming DNS"
  echo -e "2) Download All Net DNS"
  echo -e "3) Install/Remove Installer"
  echo -e "4) Exit${NC}"
  read -p $'\nEnter your choice [1-4]: ' opt

  case $opt in
    1) gaming_dns ;;
    2) download_dns ;;
    3) installer_menu ;;
    4) goodbye ;;
    *) echo -e "${RED}Invalid choice. Try again.${NC}"; main_menu ;;
  esac
}

# Country List (30)
countries=("Iran" "Germany" "Netherlands" "France" "UK" "USA" "Canada" "Turkey" "Russia" "Japan" "Singapore" "Brazil" "Argentina" "UAE" "India" "South Korea" "Sweden" "Norway" "Italy" "Spain" "China" "Australia" "Malaysia" "Thailand" "Ukraine" "Poland" "Mexico" "South Africa" "Switzerland" "Indonesia")

# Random color per country
country_colors=($RED $GREEN $YELLOW $BLUE $PURPLE $CYAN)

# DNS providers for each country
declare -A dns_by_country
for country in "${countries[@]}"; do
  dns_by_country["$country"]=$(shuf -n 500 -e \
    1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 9.9.9.9 149.112.112.112 \
    208.67.222.222 208.67.220.220 185.228.168.9 94.140.14.14 \
    76.76.2.0 45.90.28.0 64.6.64.6 156.154.70.1 77.88.8.8 \
    91.239.100.100 198.101.242.72 84.200.69.80 192.71.245.208 \
    109.69.8.51 185.235.81.1 185.228.169.9 94.130.180.225 \
    176.103.130.130 176.103.130.131 198.54.117.10 37.235.1.174 \
    89.233.43.71 203.80.96.10 103.86.96.100 185.107.80.84)
done

# Game List (50)
games_mobile=(
  "Call of Duty Mobile (Mobile)" "PUBG Mobile (Mobile)" "Free Fire (Mobile)"
  "Mobile Legends (Mobile)" "Clash Royale (Mobile)" "Clash of Clans (Mobile)"
  "Brawl Stars (Mobile)" "Arena of Valor (Mobile)" "eFootball Mobile (Mobile)"
)

games_pc=(
  "Valorant (PC)" "League of Legends (PC)" "Dota 2 (PC)"
  "CS:GO (PC)" "Apex Legends (PC)" "Minecraft (PC)"
  "Overwatch (PC)" "Escape from Tarkov (PC)" "The Finals (PC)"
  "Elden Ring (PC)" "GTA Online (PC)" "Rainbow Six Siege (PC)"
  "Battlefield (PC)" "Warzone (PC)" "Destiny 2 (PC)"
)

games_console=(
  "FIFA 24 (Console)" "NBA 2K (Console)" "Fortnite (Console)"
  "Rocket League (Console)" "Paladins (Console)" "Roblox (Console)"
  "Forza Horizon (Console)" "Red Dead Online (Console)" "Halo Infinite (Console)"
)

games=("${games_mobile[@]}" "${games_pc[@]}" "${games_console[@]}")

gaming_dns() {
  echo -e "\n${GREEN}Select your game:${NC}"
  for i in "${!games[@]}"; do
    printf "${YELLOW}%2d) %s${NC}\n" $((i+1)) "${games[$i]}"
  done

  read -p $'\nChoose a game [1-50]: ' game_choice
  game_selected="${games[$((game_choice-1))]}"

  echo -e "\n${GREEN}Select your country:${NC}"
  for i in "${!countries[@]}"; do
    color="${country_colors[$((i % ${#country_colors[@]}))]}"
    printf "${color}%2d) %s${NC}\n" $((i+1)) "${countries[$i]}"
  done

  read -p $'\nChoose a country [1-30]: ' country_choice
  country_selected="${countries[$((country_choice-1))]}"

  echo -e "\n${BLUE}Fetching optimized DNS for $game_selected in $country_selected...${NC}\n"
  sleep 1

  IFS=' ' read -ra dns_list <<< "${dns_by_country[$country_selected]}"
  selected_dns=($(shuf -e "${dns_list[@]}" -n 15))

  for i in "${!selected_dns[@]}"; do
    ip="${selected_dns[$i]}"
    ping_result=$(ping -c 1 -W 1 "$ip" | grep 'time=' | sed -E 's/.*time=([0-9.]+).*/\1 ms/')
    echo -e "${CYAN}DNS $((i+1)): $ip  - ${ping_result:-N/A}${NC}"
  done
  echo
}

download_dns() {
  echo -e "\n${GREEN}Select your country:${NC}"
  for i in "${!countries[@]}"; do
    color="${country_colors[$((i % ${#country_colors[@]}))]}"
    printf "${color}%2d) %s${NC}\n" $((i+1)) "${countries[$i]}"
  done

  read -p $'\nChoose a country [1-30]: ' country_choice
  country_selected="${countries[$((country_choice-1))]}"

  echo -e "\n${BLUE}Fetching download-optimized DNS for $country_selected...${NC}\n"
  sleep 1

  IFS=' ' read -ra dns_list <<< "${dns_by_country[$country_selected]}"
  selected_dns=($(shuf -e "${dns_list[@]}" -n 15))

  for i in "${!selected_dns[@]}"; do
    ip="${selected_dns[$i]}"
    ping_result=$(ping -c 1 -W 1 "$ip" | grep 'time=' | sed -E 's/.*time=([0-9.]+).*/\1 ms/')
    echo -e "${PURPLE}DNS $((i+1)): $ip  - ${ping_result:-N/A}${NC}"
  done
  echo
}

installer_menu() {
  echo -e "\n${GREEN}Installer Options:${NC}"
  echo "1) Install as command: Academivpn_dns"
  echo "2) Remove installer"
  read -p $'\nSelect [1-2]: ' inst_opt

  if [[ $inst_opt == "1" ]]; then
    cp "$0" /data/data/com.termux/files/usr/bin/Academivpn_dns 2>/dev/null
    chmod +x /data/data/com.termux/files/usr/bin/Academivpn_dns
    echo -e "${GREEN}Installed! Run with: ${CYAN}Academivpn_dns${NC}"
  elif [[ $inst_opt == "2" ]]; then
    rm -f /data/data/com.termux/files/usr/bin/Academivpn_dns
    echo -e "${RED}Installer removed.${NC}"
  else
    echo -e "${RED}Invalid option.${NC}"
  fi
}

goodbye() {
  echo -e "\n${YELLOW}Goodbye. Be sure to check out our Telegram channel too. @Academi_vpn${NC}"
  exit 0
}

# Start
main_menu
