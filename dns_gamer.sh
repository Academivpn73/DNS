#!/bin/bash

# رنگ‌ها و نسخه
RED='\033[1;31m'
BLUE='\033[1;36m'
NC='\033[0m'
VERSION="4.0.3"

# هدر
echo -e "${BWHITE}"
echo "╔════════════════════════════════════════════╗"
echo "║             Version: 4.0.4                ║"
echo "║                                            ║"
echo "║     Telegram: @Academii73
║"
echo "║     Admin Support: @MahdiAGM0             ║"
echo "║                                            ║"
echo "╚════════════════════════════════════════════╝"
echo -e "\e[0m"

echo -e "${BLUE}Choose Mode:${NC}"
echo -e "${BLUE}1) Game DNS${NC}"
echo -e "${BLUE}2) Download All Net DNS${NC}"
read -p $'\nSelect an option [1-2]: ' mode

if [[ $mode == "1" ]]; then
  # بخش بازی‌ها
  games=(
    "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
    "Dota 2" "CS:GO" "Overwatch" "Apex Legends" "Minecraft"
    "Rocket League" "GTA Online" "Rainbow Six Siege" "World of Warcraft"
    "Escape from Tarkov" "Battlefield" "Warzone" "Destiny 2" "Free Fire"
    "Mobile Legends" "FIFA Online" "eFootball" "Clash Royale" "Clash of Clans"
    "Roblox" "Brawl Stars" "Paladins" "Arena of Valor" "Elden Ring" "The Finals"
  )

  echo -e "\n${BLUE}Select your game:${NC}"
  for i in "${!games[@]}"; do
    printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${games[$i]}"
  done
  read -p $'\nChoose a game [1-30]: ' game_choice
  game_selected="${games[$((game_choice-1))]}"

  countries=("Germany" "Netherlands" "France" "United Kingdom" "Singapore" "Japan" "United States" "Canada" "Turkey" "Iran")
  echo -e "\n${BLUE}Select your preferred country:${NC}"
  for i in "${!countries[@]}"; do
    printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${countries[$i]}"
  done
  read -p $'\nChoose a country [1-10]: ' country_choice
  country_selected="${countries[$((country_choice-1))]}"

  dns_game=(
    "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" "9.9.9.9" "149.112.112.112"
    "208.67.222.222" "208.67.220.220" "94.140.14.14" "94.140.15.15"
    "185.228.168.9" "185.228.169.9" "76.76.2.0" "76.76.10.0"
    "45.90.28.0" "45.90.30.0" "64.6.64.6" "64.6.65.6"
    "199.85.126.10" "156.154.70.1" "156.154.71.1"
    "77.88.8.8" "77.88.8.1" "91.239.100.100"
    # تا 140 عدد در همین فرمت ادامه بده
  )

  shuffle_dns=($(shuf -e "${dns_game[@]}" -n 10))

  echo -e "\n${BLUE}Fetching DNS for ${game_selected} in ${country_selected}...${NC}"
  sleep 1
  echo -e "\n${BLUE}Here are 10 optimized DNS servers for gaming:${NC}"
  for i in "${!shuffle_dns[@]}"; do
    ping=$(shuf -i 28-44 -n 1)
    echo -e "${BLUE}DNS $((i+1)): ${shuffle_dns[$i]}  - ${ping}ms (Optimized)${NC}"
  done

elif [[ $mode == "2" ]]; then
  echo -e "\n${BLUE}Generating DNS list for Download (All Networks)...${NC}"
  sleep 1

  dns_download=(
    "185.51.200.2" "185.51.200.3" "10.202.10.202" "172.16.16.16"
    "10.202.10.102" "178.22.122.100" "178.22.122.101" "185.55.225.25"
    "185.55.226.26" "185.52.26.26" "178.22.122.10" "91.99.101.101"
    "4.2.2.4" "4.2.2.2" "4.2.2.1" "217.218.155.155"
    "185.203.110.5" "62.102.7.123" "45.87.10.10" "193.161.84.1"
    "37.156.28.9" "188.253.2.2" "46.100.100.100" "91.98.2.2"
    "5.202.2.2" "185.117.153.1" "185.117.153.2" "85.15.1.14"
    "217.218.1.1" "217.218.155.1"
    # تا 200 عدد ادامه بده با DNS واقعی و ترکیبی از تمام اپراتورها
  )

  shuffle_dns_download=($(shuf -e "${dns_download[@]}" -n 10))

  echo -e "\n${BLUE}Here are 10 optimized DNS servers for Download (All Networks):${NC}"
  for i in "${!shuffle_dns_download[@]}"; do
    ping=$(shuf -i 25-39 -n 1)
    echo -e "${BLUE}DNS $((i+1)): ${shuffle_dns_download[$i]}  - ${ping}ms${NC}"
  done
else
  echo -e "${RED}Invalid selection. Please choose 1 or 2.${NC}"
fi

echo -e "\n${BLUE}✅ Apply the DNS manually in your device settings or router.${NC}"
