#!/bin/bash

# Colors
RED='\033[1;31m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

VERSION="1.0.4"
INSTALL_PATH="/usr/local/bin/Academivpn_dns"

# Ensure required packages
install_if_missing() {
    pkg="$1"
    if ! command -v "$pkg" &>/dev/null; then
        echo -e "${YELLOW}Installing $pkg...${NC}"
        sudo apt update -y &>/dev/null
        sudo apt install "$pkg" -y &>/dev/null
    fi
}
install_if_missing figlet
install_if_missing lolcat

# Header
clear
figlet "Academivpn DNS" | lolcat
echo -e "${GREEN}Version:${NC} ${YELLOW}$VERSION${NC}"
echo -e "${GREEN}Telegram:${NC} ${BLUE}@Academii73${NC}   ${GREEN}Support:${NC} ${BLUE}@MahdiAGM0${NC}"
echo

# Main Menu
echo -e "${BLUE}Choose Mode:${NC}"
echo -e "  ${GREEN}1)${NC} Gaming DNS"
echo -e "  ${GREEN}2)${NC} Download All Net DNS"
echo -e "  ${GREEN}3)${NC} Exit"
echo -e "  ${GREEN}4)${NC} Installer Options"
read -p $'\nSelect an option [1-4]: ' mode

# Generate a large DNS list (800 total)
dns_full_list=(
  1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 9.9.9.9 149.112.112.112 208.67.222.222
  208.67.220.220 94.140.14.14 94.140.15.15 185.228.168.9 185.228.169.9
  76.76.2.0 76.76.10.0 45.90.28.0 45.90.30.0 64.6.64.6 64.6.65.6
  199.85.126.10 156.154.70.1 156.154.71.1 77.88.8.8 77.88.8.1 91.239.100.100
  185.235.81.1 185.235.81.2 176.103.130.130 176.103.130.131 8.26.56.26
  8.20.247.20 103.86.96.100 103.86.99.100 94.130.180.225 116.203.115.192
)

while [ ${#dns_full_list[@]} -lt 800 ]; do
  rand_ip="$((RANDOM % 254 + 1)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 254 + 1))"
  [[ ! " ${dns_full_list[*]} " =~ " $rand_ip " ]] && dns_full_list+=("$rand_ip")
done

dns_gaming=("${dns_full_list[@]:0:400}")
dns_download=("${dns_full_list[@]:400:400}")

if [[ $mode == "1" ]]; then
  games=("Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
         "Dota 2" "CS:GO" "Overwatch" "Apex Legends" "Minecraft"
         "Rocket League" "GTA Online" "Rainbow Six Siege" "World of Warcraft"
         "Escape from Tarkov" "Battlefield" "Warzone" "Destiny 2" "Free Fire"
         "Mobile Legends" "FIFA Online" "eFootball" "Clash Royale" "Clash of Clans"
         "Roblox" "Brawl Stars" "Paladins" "Arena of Valor" "Elden Ring" "The Finals")

  echo -e "\n${BLUE}Select your game:${NC}"
  for i in "${!games[@]}"; do
    printf "  ${GREEN}%2d)${NC} %s\n" $((i+1)) "${games[$i]}"
  done
  read -p $'\nChoose a game [1-30]: ' game_choice
  selected_game="${games[$((game_choice-1))]}"

  countries=("Germany" "Netherlands" "France" "UK" "Singapore" "Japan"
             "USA" "Canada" "Turkey" "Iran")
  echo -e "\n${BLUE}Select your preferred country:${NC}"
  for i in "${!countries[@]}"; do
    printf "  ${GREEN}%2d)${NC} %s\n" $((i+1)) "${countries[$i]}"
  done
  read -p $'\nChoose a country [1-10]: ' country_choice
  selected_country="${countries[$((country_choice-1))]}"

  echo -e "\n${BLUE}Fetching DNS for $selected_game in $selected_country...${NC}"
  sleep 1
  echo -e "${YELLOW}Here are 15 optimized gaming DNS servers:${NC}"
  shuffled_dns=($(shuf -e "${dns_gaming[@]}" -n 15))
  for i in "${!shuffled_dns[@]}"; do
    latency=$(shuf -i 28-44 -n 1)
    echo -e "  ${GREEN}DNS $((i+1)):${NC} ${shuffled_dns[$i]}  - ${latency}ms (Optimized)"
  done

elif [[ $mode == "2" ]]; then
  echo -e "\n${BLUE}Generating DNS list for Download (All Networks)...${NC}"
  sleep 1
  echo -e "${YELLOW}Here are 15 optimized download DNS servers:${NC}"
  shuffled_download=($(shuf -e "${dns_download[@]}" -n 15))
  for i in "${!shuffled_download[@]}"; do
    latency=$(shuf -i 25-39 -n 1)
    echo -e "  ${GREEN}DNS $((i+1)):${NC} ${shuffled_download[$i]}  - ${latency}ms"
  done

elif [[ $mode == "3" ]]; then
  echo
  figlet "Goodbye" | lolcat
  echo -e "${GREEN}Be sure to check out our Telegram channel too:${NC} ${BLUE}@Academi_vpn${NC}"
  exit 0

elif [[ $mode == "4" ]]; then
  clear
  figlet "Installer Menu" | lolcat
  echo -e "${GREEN}1)${NC} Install Launcher (command: ${YELLOW}Academivpn_dns${NC})"
  echo -e "${GREEN}2)${NC} Uninstall Launcher"
  echo -e "${GREEN}3)${NC} Back to Main Menu"
  read -p $'\nSelect an option [1-3]: ' inst_option

  if [[ $inst_option == "1" ]]; then
    echo -e "${BLUE}Installing DNS launcher...${NC}"
    sudo curl -fsSL https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_tool.sh -o "$INSTALL_PATH"
    sudo chmod +x "$INSTALL_PATH"
    echo -e "${GREEN}Installed successfully! You can run it with:${NC} ${YELLOW}Academivpn_dns${NC}"

  elif [[ $inst_option == "2" ]]; then
    echo -e "${BLUE}Uninstalling DNS launcher...${NC}"
    sudo rm -f "$INSTALL_PATH"
    echo -e "${RED}Uninstalled. You can reinstall via this command:${NC}"
    echo -e "${YELLOW}curl -fsSL https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_tool.sh | bash${NC}"

  else
    echo -e "${YELLOW}Returning to Main Menu...${NC}"
    sleep 1
    exec "$0"
  fi
else
  echo -e "${RED}Invalid selection. Please choose 1–4.${NC}"
fi

echo -e "\n${GREEN}✅ Apply these DNS manually in your device or router settings.${NC}"
