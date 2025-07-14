#!/bin/bash

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

clear
echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════╗"
echo "║           🎮 GAMING DNS SELECTOR TOOL             ║"
echo "╠════════════════════════════════════════════════════╣"
echo "║ Telegram: @Academi_vpn         Admin: Mahdi       ║"
echo "╚════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Game list
games=(
"Call of Duty Mobile"
"PUBG Mobile"
"Free Fire"
"Fortnite"
"Apex Legends"
"Valorant"
"Roblox"
"Minecraft"
"League of Legends"
"Dota 2"
"CS:GO"
"Clash of Clans"
"Clash Royale"
"Brawl Stars"
"Mobile Legends"
"Wild Rift"
"FIFA Mobile"
"Genshin Impact"
"Warzone"
"Rainbow Six Siege"
)

# Show game menu
echo -e "${YELLOW}Select your game:${NC}"
for i in "${!games[@]}"; do
    printf "%2d) %s\n" $((i+1)) "${games[$i]}"
done

read -p $'\nEnter number (1-20): ' game_choice
if ! [[ "$game_choice" =~ ^[1-9]$|^1[0-9]$|^20$ ]]; then
    echo -e "${RED}Invalid selection! Exiting...${NC}"
    exit 1
fi

echo -e "\n${YELLOW}Select IP version:${NC}"
echo "1) IPv4"
echo "2) IPv6"
read -p $'\nYour choice (1/2): ' ip_choice

if [[ "$ip_choice" == "1" ]]; then
    ip_version="IPv4"
elif [[ "$ip_choice" == "2" ]]; then
    ip_version="IPv6"
else
    echo -e "${RED}Invalid selection. Exiting...${NC}"
    exit 1
fi

# DNS Database (based on game category and IP version)
declare -A dns_ipv4
declare -A dns_ipv6

# These are example optimized DNS values - can be updated with real-time testing
dns_ipv4=(
  ["cod"]="76.76.2.2"
  ["pubg"]="1.1.1.1"
  ["default"]="94.140.14.14"
)

dns_ipv6=(
  ["cod"]="2606:1a40::"
  ["pubg"]="2606:4700:4700::1111"
  ["default"]="2a10:50c0::ad1:ff"
)

selected_game=${games[$((game_choice-1))]}
dns_key="default"
[[ "$selected_game" == *"Call of Duty"* ]] && dns_key="cod"
[[ "$selected_game" == *"PUBG"* ]] && dns_key="pubg"

# Set DNS
if [[ "$ip_choice" == "1" ]]; then
    selected_dns=${dns_ipv4[$dns_key]}
else
    selected_dns=${dns_ipv6[$dns_key]}
fi

# Output DNS
echo -e "\n${GREEN}🎯 Recommended DNS for ${selected_game} (${ip_version}):${NC}"
echo -e "${CYAN}$selected_dns${NC}"

# Optionally apply
read -p $'\nDo you want to apply this DNS temporarily? (y/n): ' apply

if [[ "$apply" =~ ^[Yy]$ ]]; then
    if [[ -d /data/data/com.termux ]]; then
        echo "nameserver $selected_dns" > $PREFIX/etc/resolv.conf
    else
        sudo bash -c "echo 'nameserver $selected_dns' > /etc/resolv.conf"
    fi
    echo -e "${GREEN}✅ DNS applied successfully.${NC}"
else
    echo -e "${CYAN}No changes were made.${NC}"
fi
