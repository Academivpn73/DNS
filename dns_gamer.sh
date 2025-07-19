#!/bin/bash

# ==========[ Configuration ]============
DNS_GAMING_FILE="dns_gaming.txt"
DNS_DOWNLOAD_FILE="dns_download.txt"
GAMES_LIST_FILE="games_list.txt"
VERSION="1.2.3"
ADMIN="@MahdiAGM0"
TELEGRAM="@Academi_vpn"
# =======================================

# ==========[ Color Setup ]=============
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
# =======================================

# ==========[ Functions ]===============
show_title() {
  clear
  COLOR=$((31 + RANDOM % 7))
  echo -e "\033[1;${COLOR}m"
  echo "╔═══════════════════════════════════╗"
  echo "║           DNS TOOL MENU           ║"
  echo "╚═══════════════════════════════════╝"
  echo -e "\033[0m"
  echo -e "+---------------------------------------------+"
  echo -e "| Telegram: ${TELEGRAM}"
  echo -e "| Admin:    ${ADMIN}"
  echo -e "| Version:  ${VERSION}"
  echo -e "+---------------------------------------------+"
}

random_dns_from_file() {
  file="$1"
  total=$(wc -l < "$file")
  line1=$((RANDOM % total + 1))
  line2=$((RANDOM % total + 1))
  dns1=$(sed -n "${line1}p" "$file")
  dns2=$(sed -n "${line2}p" "$file")
  echo "$dns1"
  echo "$dns2"
}

ping_dns() {
  read -p "Enter DNS to test: " dns
  echo -e "${YELLOW}Pinging $dns...${NC}"
  ping -c 3 "$dns"
  echo
  read -p "Press Enter to return..."
}

search_game_dns() {
  show_title
  echo -e "📱 ${GREEN}Game List:${NC}"
  nl "$GAMES_LIST_FILE"
  echo
  read -p "Enter game name to search: " game

  found=$(grep -i "^$game\$" "$GAMES_LIST_FILE")
  if [[ -z "$found" ]]; then
    echo -e "${YELLOW}Game not found!${NC}"
    read -p "Press Enter to return..."
    return
  fi

  echo -e "🌍 Choose Region:"
  select region in "Iran" "UAE" "Turkey" "Other"; do
    [[ -n "$region" ]] && break
  done

  echo -e "${GREEN}Recommended DNS for ${game} (${region}):${NC}"
  random_dns_from_file "$DNS_GAMING_FILE"
  echo
  read -p "Press Enter to return..."
}

download_dns() {
  show_title
  echo -e "🌍 Choose Region for Fast Download DNS:"
  select region in "Iran" "UAE" "Turkey" "Other"; do
    [[ -n "$region" ]] && break
  done

  echo -e "${GREEN}Best DNS for Download (${region}):${NC}"
  random_dns_from_file "$DNS_DOWNLOAD_FILE"
  echo
  read -p "Press Enter to return..."
}

gaming_dns() {
  show_title
  echo -e "🌍 Choose Region for Gaming DNS:"
  select region in "Iran" "UAE" "Turkey" "Other"; do
    [[ -n "$region" ]] && break
  done

  echo -e "${GREEN}Best Gaming DNS (${region}):${NC}"
  random_dns_from_file "$DNS_GAMING_FILE"
  echo
  read -p "Press Enter to return..."
}
# =======================================

# ==========[ Main Menu ]===============
while true; do
  show_title
  echo -e "${GREEN}Select an option:${NC}"
  echo "1️⃣  DNS for Gaming"
  echo "2️⃣  DNS for Download"
  echo "3️⃣  Search Game DNS (🆕)"
  echo "4️⃣  Ping a DNS"
  echo "0️⃣  Exit"
  echo
  read -p "Enter your choice: " opt

  case $opt in
    1) gaming_dns ;;
    2) download_dns ;;
    3) search_game_dns ;;
    4) ping_dns ;;
    0) exit ;;
    *) echo "Invalid option!"; sleep 1 ;;
  esac
done
# =======================================
