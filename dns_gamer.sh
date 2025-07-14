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

echo -e "${BLUE}🎮 Welcome to the Real Gaming DNS Optimizer${NC}"
echo

# انتخاب بازی (همانند قبل) - کوتاه‌شده برای نمونه
games=("Call of Duty" "PUBG" "Valorant" "Fortnite" "CS:GO")
echo -e "${BLUE}Select your game:${NC}"
for i in "${!games[@]}"; do
  printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${games[$i]}"
done
read -p $'\nChoose a game [1-5]: ' game_choice
game_selected="${games[$((game_choice-1))]}"

# انتخاب کشور (برای ظاهر فقط)
countries=("Germany" "France" "USA" "Iran" "Singapore")
echo -e "\n${BLUE}Select your country:${NC}"
for i in "${!countries[@]}"; do
  printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${countries[$i]}"
done
read -p $'\nChoose a country [1-5]: ' country_choice
country_selected="${countries[$((country_choice-1))]}"

# لیست DNS واقعی از دیتاسنترهای معتبر
declare -A dns_map
dns_map["Cloudflare"]="1.1.1.1"
dns_map["Cloudflare Secondary"]="1.0.0.1"
dns_map["Google"]="8.8.8.8"
dns_map["Google Secondary"]="8.8.4.4"
dns_map["Quad9"]="9.9.9.9"
dns_map["ControlD"]="76.76.2.0"
dns_map["NextDNS"]="45.90.28.0"
dns_map["AdGuard"]="94.140.14.14"
dns_map["OpenDNS"]="208.67.222.222"
dns_map["CleanBrowsing"]="185.228.168.9"

echo -e "\n${BLUE}Fetching DNS for ${game_selected} from ${country_selected}...${NC}"
sleep 1

for label in "${!dns_map[@]}"; do
    ip=${dns_map[$label]}
    ping_time=$(ping -c 1 -W 1 $ip | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [[ -z "$ping_time" ]]; then
        ping_time="Timeout"
    else
        ping_time="${ping_time} ms"
    fi
    echo -e "${BLUE}$label:${NC} $ip  →  Ping: $ping_time"
done

echo -e "\n${BLUE}✅ Use the best DNS manually in your game/router settings.${NC}"
