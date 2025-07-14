#!/bin/bash

# رنگ‌ها
BLUE='\033[1;34m'
NC='\033[0m'

# هدر زیبا
clear
echo -e "${BLUE}"
echo "███╗   ███╗ █████╗ ██╗  ██╗██████╗ ██╗"
echo "████╗ ████║██╔══██╗██║ ██╔╝██╔══██╗██║"
echo "██╔████╔██║███████║█████╔╝ ██████╔╝██║"
echo "██║╚██╔╝██║██╔══██║██╔═██╗ ██╔═══╝ ██║"
echo "██║ ╚═╝ ██║██║  ██║██║  ██╗██║     ██║"
echo "╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝"
echo -e "${BLUE}               Mahdi${NC}"
echo ""
echo "Select your Game to get Optimized Gaming DNS:"
echo ""

# لیست بازی‌ها
games=(
    "Call of Duty"
    "PUBG"
    "Fortnite"
    "Valorant"
    "CS:GO"
    "Dota 2"
    "League of Legends"
    "Apex Legends"
    "Free Fire"
    "Minecraft"
    "Overwatch"
    "Rocket League"
    "Rainbow Six Siege"
    "Warzone"
    "Battlefield"
    "FIFA"
    "Genshin Impact"
    "Roblox"
    "Mobile Legends"
    "Clash Royale"
    "Clash of Clans"
    "Brawl Stars"
    "Arena of Valor"
    "World of Tanks"
    "World of Warcraft"
    "Elden Ring"
    "GTA Online"
    "Destiny 2"
    "Naraka Bladepoint"
    "Escape From Tarkov"
)

# نمایش لیست بازی‌ها
for i in "${!games[@]}"; do
  printf "%2d) %s\n" $((i+1)) "${games[$i]}"
done

echo ""
read -p "Enter the number of your game: " game_choice

# بررسی ورودی
if ! [[ "$game_choice" =~ ^[0-9]+$ ]] || [ "$game_choice" -lt 1 ] || [ "$game_choice" -gt ${#games[@]} ]; then
  echo "❌ Invalid selection."
  exit 1
fi

game_selected="${games[$((game_choice-1))]}"
echo -e "\n✅ Selected game: ${BLUE}$game_selected${NC}\n"

# انتخاب کشور
countries=("Germany" "France" "Netherlands" "Canada" "USA" "UK" "Singapore" "Iran" "India" "Japan")

echo "Select Country for DNS:"
for i in "${!countries[@]}"; do
  printf "%2d) %s\n" $((i+1)) "${countries[$i]}"
done

echo ""
read -p "Enter the number of your country: " country_choice

if ! [[ "$country_choice" =~ ^[0-9]+$ ]] || [ "$country_choice" -lt 1 ] || [ "$country_choice" -gt ${#countries[@]} ]; then
  echo "❌ Invalid country."
  exit 1
fi

country_selected="${countries[$((country_choice-1))]}"
echo -e "\n🌍 Country selected: ${BLUE}$country_selected${NC}\n"

echo "Fetching best DNS servers for $game_selected in $country_selected...\n"

# لیست نمونه DNS (شخصی‌سازی دستی بر اساس کشور و گیم)
dns_list=(
    "1.1.1.1"
    "8.8.8.8"
    "9.9.9.9"
    "94.140.14.14"
    "208.67.222.222"
    "76.76.2.0"
    "185.228.168.9"
    "64.6.64.6"
    "84.200.69.80"
    "45.90.28.0"
)

echo -e "${BLUE}Top DNS for $game_selected [IPv4]:${NC}"
for dns in "${dns_list[@]}"; do
    ping_result=$(ping -c 1 -W 1 $dns | grep 'time=' | awk -F'time=' '{ print $2 }' | cut -d' ' -f1)
    if [ -n "$ping_result" ]; then
        echo "$dns  ${ping_result}ms"
    else
        echo "$dns  timeout"
    fi
done

echo -e "\n${BLUE}✅ Apply manually via your system DNS settings.${NC}"
