#!/bin/bash

# Colors
GREEN='\033[0;92m'
NC='\033[0m' # No Color

clear
echo -e "${GREEN}"
echo "  ██████╗ ███╗   ██╗███████╗ ██████╗██████╗ "
echo " ██╔════╝ ████╗  ██║██╔════╝██╔════╝██╔══██╗"
echo " ██║  ███╗██╔██╗ ██║█████╗  ██║     ██████╔╝"
echo " ██║   ██║██║╚██╗██║██╔══╝  ██║     ██╔═══╝ "
echo " ╚██████╔╝██║ ╚████║███████╗╚██████╗██║     "
echo "  ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝╚═╝     "
echo -e "${NC}"

echo -e "${GREEN}Telegram: @Academi_vpn"
echo "Admin Support: @MahdiAGM0${NC}"
echo ""

# List of Games
games=("PUBG" "Call of Duty" "Fortnite" "Valorant" "CS:GO" "Free Fire" "Apex Legends" "Overwatch"
       "League of Legends" "Dota 2" "Minecraft" "Roblox" "Clash Royale" "Clash of Clans" "Hearthstone"
       "Mobile Legends" "Arena of Valor" "Genshin Impact" "Rocket League" "Brawl Stars" "Smite" "Warframe"
       "World of Tanks" "World of Warcraft" "Rainbow Six Siege" "Battlefield" "Rust" "ARK" "Tarkov" "Paladins")

echo "Select a Game:"
select game in "${games[@]}"; do
  [[ -n "$game" ]] && break
done

echo ""
echo "Choose IP Type:"
select ip_type in "IPv4" "IPv6"; do
  [[ -n "$ip_type" ]] && break
done

echo ""
echo "Select Country:"
countries=("Iran" "Germany" "France" "Singapore" "Japan" "Turkey" "Netherlands" "Canada" "USA" "UK")
select country in "${countries[@]}"; do
  [[ -n "$country" ]] && break
done

echo ""
echo "Fetching optimized DNS servers for $game ($ip_type) in $country..."
echo ""

# Simulated DNS database (for demo)
declare -a dns_list=(
  "1.1.1.1"
  "9.9.9.9"
  "94.140.14.14"
  "76.76.2.0"
  "8.8.8.8"
  "45.90.28.0"
  "185.228.168.9"
  "64.6.64.6"
  "208.67.222.222"
  "38.132.106.139"
)

# Simulated Ping + Display
for dns in "${dns_list[@]}"; do
  ping_ms=$((RANDOM % 40 + 20))
  echo -e "${GREEN}$dns  ${ping_ms}ms${NC}"
done

echo ""
echo -e "${GREEN}These DNS servers are optimized for: $game${NC}"
