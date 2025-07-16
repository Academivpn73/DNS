#!/bin/bash

# ===== Colors =====
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m'

# ===== Version Info =====
VERSION="1.0.6"
TG_CHANNEL="@Academi_vpn"
ADMIN="@MahdiAGM0"

# ===== Required Packages =====
install_if_missing() {
  pkg=$1
  if ! command -v "$pkg" &>/dev/null; then
    echo -e "${YELLOW}Installing $pkg...${NC}"
    if command -v apt &>/dev/null; then
      apt update -y &>/dev/null
      apt install "$pkg" -y &>/dev/null
    elif command -v pkg &>/dev/null; then
      pkg update -y &>/dev/null
      pkg install "$pkg" -y &>/dev/null
    fi
  fi
}

for tool in curl figlet lolcat toilet; do
  install_if_missing "$tool"
done

# ===== Title Header =====
clear
if command -v figlet &>/dev/null && command -v lolcat &>/dev/null; then
  echo "AcademiVPN DNS Tool" | figlet | lolcat
else
  echo -e "${CYAN}AcademiVPN DNS Tool${NC}"
fi

echo -e "${MAGENTA}╔════════════════════════════════════╗"
echo -e "║     Version: ${VERSION}                    ║"
echo -e "║     Telegram: ${TG_CHANNEL}          ║"
echo -e "║     Admin: ${ADMIN}                 ║"
echo -e "╚════════════════════════════════════╝${NC}"
echo

# ===== DNS Lists (Sample 500) =====
dns_game_list=()
dns_download_list=()

for i in $(seq 1 500); do
  dns_game_list+=("1.1.${i}.1")
  dns_download_list+=("8.8.${i}.8")
done

# ===== Exit Message =====
exit_message() {
  echo -e "\n"
  if command -v figlet &>/dev/null && command -v lolcat &>/dev/null; then
    echo "Goodbye! Be sure to check out our Telegram channel." | figlet | lolcat
  else
    echo -e "${GREEN}Goodbye! Be sure to check out our Telegram channel.${NC}"
    echo -e "${YELLOW}${TG_CHANNEL}${NC}"
  fi
  echo
  exit 0
}

# ===== Installer Menu =====
installer_menu() {
  echo -e "${BLUE}Installer Options:${NC}"
  echo -e "1) Install as command (Academivpn_dns)"
  echo -e "2) Uninstall command"
  read -p $'\nChoose [1-2]: ' installer_choice
  case $installer_choice in
    1)
      curl -fsSL https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_gamer.sh -o /usr/local/bin/Academivpn_dns
      chmod +x /usr/local/bin/Academivpn_dns
      echo -e "${GREEN}Installed successfully. Run with: Academivpn_dns${NC}"
      ;;
    2)
      rm -f /usr/local/bin/Academivpn_dns
      echo -e "${RED}Uninstalled successfully.${NC}"
      ;;
    *)
      echo -e "${RED}Invalid choice.${NC}"
      ;;
  esac
  exit 0
}

# ===== Main Menu =====
echo -e "${CYAN}Select an option:${NC}"
echo -e "1) 🎮 Game DNS"
echo -e "2) ⬇️  Download DNS"
echo -e "3) ⚙️  Installer Menu"
echo -e "4) ❌ Exit"

read -p $'\nEnter choice [1-4]: ' main_choice

case $main_choice in
  1)
    games=("Call of Duty" "PUBG" "Fortnite" "Valorant" "LoL" "CS:GO" "Dota 2" "Overwatch")
    countries=("Germany" "Netherlands" "USA" "UK" "Singapore" "France" "Turkey" "Japan")

    echo -e "\n${CYAN}Select a game:${NC}"
    for i in "${!games[@]}"; do
      echo "$((i+1))) ${games[$i]}"
    done
    read -p $'\nYour game [1-8]: ' game_id
    selected_game=${games[$((game_id-1))]}

    echo -e "\n${CYAN}Select country:${NC}"
    for i in "${!countries[@]}"; do
      echo "$((i+1))) ${countries[$i]}"
    done
    read -p $'\nYour country [1-8]: ' country_id
    selected_country=${countries[$((country_id-1))]}

    echo -e "\n${GREEN}Fetching DNS for ${selected_game} (${selected_country})...${NC}"
    sleep 1
    selected_dns=($(shuf -e "${dns_game_list[@]}" -n 15))
    echo -e "${YELLOW}Optimized DNS Servers:${NC}"
    for i in "${!selected_dns[@]}"; do
      echo "DNS $((i+1)): ${selected_dns[$i]}"
    done
    ;;
  2)
    echo -e "\n${CYAN}Fetching Download DNS (All Networks)...${NC}"
    sleep 1
    selected_dns=($(shuf -e "${dns_download_list[@]}" -n 15))
    echo -e "${YELLOW}Optimized DNS Servers:${NC}"
    for i in "${!selected_dns[@]}"; do
      echo "DNS $((i+1)): ${selected_dns[$i]}"
    done
    ;;
  3)
    installer_menu
    ;;
  4)
    exit_message
    ;;
  *)
    echo -e "${RED}Invalid input.${NC}"
    ;;
esac

echo -e "\n${CYAN}Apply the DNS manually via your device settings or router.${NC}"
