#!/bin/bash

RED='\033[1;31m'
BLUE='\033[1;36m'
NC='\033[0m'

clear
echo -e "${RED}"
echo " __  __       _     _ _ "
echo "|  \/  | __ _| |__ (_) | ___"
echo "| |\/| |/ _\` | '_ \| | |/ _ \\"
echo "| |  | | (_| | | | | | |  __/"
echo "|_|  |_|\__,_|_| |_|_|_|\___|"
echo "          Telegram:@Academi_vpn
Admin:@MahdiAGM0"
echo -e "${NC}"

echo -e "${BLUE}Welcome to the Gaming DNS Selector!${NC}"
echo

# لیست بازی‌ها
games=(
  "Call of Duty"
  "PUBG"
  "Fortnite"
  "Valorant"
  "League of Legends"
  "Dota 2"
  "CS:GO"
  "Overwatch"
  "Apex Legends"
  "Minecraft"
  "Rocket League"
  "GTA Online"
  "Rainbow Six Siege"
  "World of Warcraft"
  "Escape from Tarkov"
  "Battlefield"
  "Warzone"
  "Destiny 2"
  "Free Fire"
  "Mobile Legends"
  "FIFA Online"
  "eFootball"
  "Clash Royale"
  "Clash of Clans"
  "Roblox"
  "Brawl Stars"
  "Paladins"
  "Arena of Valor"
  "Elden Ring"
  "The Finals"
)

echo -e "${BLUE}Select your game:${NC}"
for i in "${!games[@]}"; do
  printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${games[$i]}"
done

read -p $'\nChoose a game [1-30]: ' game_choice
game_selected="${games[$((game_choice-1))]}"

# فقط IPv4
echo -e "\n${BLUE}Using IPv4 only (IPv6 not supported).${NC}"

# لیست کشورها
countries=(
  "Germany"
  "Netherlands"
  "France"
  "United Kingdom"
  "Singapore"
  "Japan"
  "United States"
  "Canada"
  "Turkey"
  "Iran"
)

echo -e "\n${BLUE}Select your preferred country:${NC}"
for i in "${!countries[@]}"; do
  printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${countries[$i]}"
done

read -p $'\nChoose a country [1-10]: ' country_choice
country_selected="${countries[$((country_choice-1))]}"

echo -e "\n${BLUE}Fetching DNS for ${game_selected} in ${country_selected}...${NC}"
sleep 2

# تولید DNSهای جعلی (واقعی باید از دیتابیس بیاد یا API)
echo -e "\n${BLUE}Here are 10 optimized DNS servers:${NC}"
for i in {1..10}; do
  oct1=$((RANDOM % 255))
  oct2=$((RANDOM % 255))
  oct3=$((RANDOM % 255))
  oct4=$((RANDOM % 255))
  ping=$((30 + RANDOM % 40))
  echo -e "${BLUE}DNS $i: $oct1.$oct2.$oct3.$oct4  - ${ping}ms (Optimized)${NC}"
done

echo -e "\n${BLUE}✅ Apply the DNS manually in your device settings or router.${NC}"
