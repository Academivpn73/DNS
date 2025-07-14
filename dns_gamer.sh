
#!/bin/bash

RED='\033[1;31m'
BLUE='\033[1;36m'
NC='\033[0m'

clear
echo -e "${RED}"
echo "╔══════════════════════════════════════════════════════╗"
echo "║                                                      ║"
echo "║          Telegram: @Academi_vpn                      ║"
echo "║          Admin Support: @MahdiAGM0                   ║"
echo "║                                                      ║"
echo "╚══════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${BLUE}🎮 Welcome to the Real Gaming DNS Optimizer!${NC}"
echo

# بازی‌ها
games=(
  "Call of Duty"
  "PUBG"
  "Valorant"
  "Fortnite"
  "League of Legends"
  "Dota 2"
  "CS:GO"
  "Apex Legends"
  "Free Fire"
  "Mobile Legends"
  "Rainbow Six Siege"
  "Minecraft"
  "GTA Online"
  "Rocket League"
  "Overwatch"
  "Escape from Tarkov"
  "The Finals"
  "Warzone"
  "FIFA Online"
  "Clash of Clans"
  "Clash Royale"
  "Arena of Valor"
  "Elden Ring"
  "Roblox"
  "Brawl Stars"
)

# انتخاب بازی
echo -e "${BLUE}Select your game:${NC}"
for i in "${!games[@]}"; do
  printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${games[$i]}"
done

read -p $'\nChoose a game [1-25]: ' game_choice
game_selected="${games[$((game_choice-1))]}"

# لیست کشورها
countries=(
  "Germany"
  "Netherlands"
  "France"
  "UK"
  "Singapore"
  "Japan"
  "USA"
  "Canada"
  "Turkey"
  "Iran"
)

echo -e "\n${BLUE}Select your country:${NC}"
for i in "${!countries[@]}"; do
  printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${countries[$i]}"
done

read -p $'\nChoose a country [1-10]: ' country_choice
country_selected="${countries[$((country_choice-1))]}"

# DNS واقعی مخصوص گیم
declare -A dns_servers

dns_servers["Germany"]="1.1.1.1,8.8.8.8,9.9.9.9,94.140.14.14"
dns_servers["Netherlands"]="1.1.1.1,8.8.4.4,9.9.9.9,185.222.222.222"
dns_servers["France"]="8.8.8.8,94.140.15.15,208.67.222.222"
dns_servers["UK"]="1.0.0.1,4.2.2.1,8.8.8.8"
dns_servers["Singapore"]="1.1.1.1,8.8.8.8,185.222.222.222"
dns_servers["Japan"]="8.8.4.4,1.0.0.1,9.9.9.9"
dns_servers["USA"]="8.8.8.8,1.1.1.1,208.67.222.222"
dns_servers["Canada"]="9.9.9.9,8.8.4.4,94.140.14.14"
dns_servers["Turkey"]="185.222.222.222,1.1.1.1,8.8.8.8"
dns_servers["Iran"]="178.22.122.100,185.51.200.2,10.202.10.10"

echo -e "\n${BLUE}Optimized DNS for ${game_selected} in ${country_selected}:${NC}"
IFS=',' read -ra dns_list <<< "${dns_servers[$country_selected]}"

for i in "${!dns_list[@]}"; do
  echo -e "${BLUE}DNS $((i+1)): ${dns_list[$i]}${NC}"
done

echo -e "\n${BLUE}✅ Apply these DNS manually in your device or router settings.${NC}"
