#!/bin/bash

# --------- Color Definitions ---------
RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
NC='\033[0m'

# --------- Auto Install Dependencies ---------
for pkg in curl ping awk grep; do
  if ! command -v "$pkg" &>/dev/null; then
    echo -e "${YELLOW}Installing missing package: $pkg${NC}"
    apt update -y &>/dev/null && apt install -y "$pkg" &>/dev/null
  fi
done

# --------- Colorful Title ---------
echo -e "${RED}███    ███ ██ ███    ██ ██   ██ ██████  ██ ██████ "
echo -e "${YELLOW}████  ████ ██ ████   ██ ██  ██  ██   ██ ██ ██   ██"
echo -e "${GREEN}██ ████ ██ ██ ██ ██  ██ █████   ██████  ██ ██   ██"
echo -e "${CYAN}██  ██  ██ ██ ██  ██ ██ ██  ██  ██      ██ ██   ██"
echo -e "${BLUE}██      ██ ██ ██   ████ ██   ██ ██      ██ ██████"
echo -e "${MAGENTA}              Mahdi Dns 🔥 - Version: 1.1.0${NC}"
echo -e "${CYAN}Telegram: @Academi_vpn     Admin: @MahdiAGM0${NC}"
echo

# --------- Installer Options ---------
show_menu() {
  echo -e "${GREEN}Choose an option:${NC}"
  echo -e "${BLUE}1) Gaming DNS${NC}"
  echo -e "${BLUE}2) Download DNS (All Networks)${NC}"
  echo -e "${BLUE}3) Installer Options${NC}"
  echo -e "${RED}4) Exit${NC}"
  read -p $'\nSelect [1-4]: ' opt
}

installer_menu() {
  echo -e "${MAGENTA}\nInstaller Options:${NC}"
  echo -e "${CYAN}1) Install Academivpn_dns command${NC}"
  echo -e "${CYAN}2) Remove Academivpn_dns command${NC}"
  echo -e "${BLUE}3) Back${NC}"
  read -p $'\nSelect [1-3]: ' inst
  case $inst in
    1)
      curl -fsSL https://raw.githubusercontent.com/Academivpn73/DNS/main/kingdns.sh -o /usr/local/bin/Academivpn_dns && chmod +x /usr/local/bin/Academivpn_dns
      echo -e "${GREEN}Installed successfully. Run using: ${YELLOW}Academivpn_dns${NC}"
      ;;
    2)
      rm -f /usr/local/bin/Academivpn_dns
      echo -e "${RED}Academivpn_dns removed.${NC}"
      ;;
    *)
      ;;
  esac
}

# --------- Game List (Mobile, PC, Console) ---------
games=(
"PUBG Mobile [Mobile]" "Free Fire [Mobile]" "Call of Duty Mobile [Mobile]" "Clash of Clans [Mobile]"
"Clash Royale [Mobile]" "Brawl Stars [Mobile]" "Mobile Legends [Mobile]" "Arena of Valor [Mobile]"
"League of Legends [PC]" "Dota 2 [PC]" "Valorant [PC]" "CS:GO [PC]" "Overwatch [PC]"
"Fortnite [PC]" "Minecraft [PC]" "Apex Legends [PC]" "Escape from Tarkov [PC]" "Elden Ring [PC]"
"Warzone [PC]" "Battlefield [PC]" "Roblox [PC]" "Rust [PC]" "FIFA Online [PC]" "eFootball [PC]"
"Rocket League [Console]" "FIFA 23 [Console]" "NBA 2K [Console]" "GTA Online [Console]"
"Call of Duty MW3 [Console]" "The Finals [Console]"
)

# --------- Country List ---------
countries=(
"Iran" "Germany" "France" "Netherlands" "United Kingdom" "USA" "Canada" "Singapore"
"Japan" "Brazil" "India" "Turkey" "Italy" "Spain" "Russia" "Sweden" "Norway" "Australia"
"Argentina" "South Korea" "Indonesia" "Thailand" "Malaysia" "Philippines" "UAE" "Poland"
"Finland" "Ukraine" "Pakistan" "Iraq"
)

# --------- DNS Pool Example (Real ones should be added from best sources) ---------
dns_gaming_us=(
"1.1.1.1" "8.8.8.8" "208.67.222.222" "9.9.9.9" "76.76.2.0"
"45.90.28.0" "185.228.168.9" "94.140.14.14" "64.6.64.6" "199.85.126.10"
)

dns_download_ir=(
"185.51.200.2" "178.22.122.100" "10.202.10.202" "185.55.225.25" "91.99.101.101"
"185.117.153.1" "217.218.155.155" "4.2.2.4" "185.203.110.5" "5.202.2.2"
)

# --------- Ping Function ---------
show_dns_list() {
  list=("$@")
  total=${#list[@]}
  max=15
  echo -e "\n${BLUE}Fetching 15 optimized DNS servers:${NC}"
  for ((i=0; i<max; i++)); do
    dns=${list[$((RANDOM % total))]}
    ping_time=$(ping -c 1 -W 1 $dns | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1 "ms"}')
    [[ -z "$ping_time" ]] && ping_time="timeout"
    echo -e "${YELLOW}DNS $((i+1)):${NC} $dns - ${GREEN}${ping_time}${NC}"
  done
}

# --------- Main Loop ---------
while true; do
  show_menu
  case $opt in
    1)
      echo -e "\n${CYAN}Select a game:${NC}"
      for i in "${!games[@]}"; do
        color="\033[1;$((31 + i % 6))m"
        printf "${color}%2d) %s${NC}\n" $((i + 1)) "${games[$i]}"
      done
      read -p $'\nChoose game [1-${#games[@]}]: ' gidx
      selected_game="${games[$((gidx - 1))]}"
      echo -e "\n${MAGENTA}Selected Game:${NC} $selected_game"

      echo -e "\n${CYAN}Select your country:${NC}"
      for i in "${!countries[@]}"; do
        color="\033[1;$((31 + i % 6))m"
        printf "${color}%2d) %s${NC}\n" $((i + 1)) "${countries[$i]}"
      done
      read -p $'\nChoose country [1-${#countries[@]}]: ' cidx
      selected_country="${countries[$((cidx - 1))]}"
      echo -e "\n${MAGENTA}Selected Country:${NC} $selected_country"

      show_dns_list "${dns_gaming_us[@]}"
      ;;
    2)
      echo -e "\n${CYAN}Select your country for Download DNS:${NC}"
      for i in "${!countries[@]}"; do
        color="\033[1;$((32 + i % 6))m"
        printf "${color}%2d) %s${NC}\n" $((i + 1)) "${countries[$i]}"
      done
      read -p $'\nChoose country [1-${#countries[@]}]: ' cidx2
      selected_country2="${countries[$((cidx2 - 1))]}"
      echo -e "\n${MAGENTA}Selected Country:${NC} $selected_country2"

      show_dns_list "${dns_download_ir[@]}"
      ;;
    3)
      installer_menu
      ;;
    4)
      echo -e "\n${RED}Goodbye. Be sure to check out our Telegram channel too. @Academi_vpn${NC}"
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid option! Try again.${NC}"
      ;;
  esac
done
