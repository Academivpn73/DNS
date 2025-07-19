#!/bin/bash

# -------- URLs (replace with your actual GitHub username/repo) -------- #
BASE_URL="https://raw.githubusercontent.com/yourusername/DNS-Project/main"
GAMES_URL="$BASE_URL/games_list.txt"
COUNTRIES_URL="$BASE_URL/countries_list.txt"
DNS_URL="$BASE_URL/dns_data.txt"
PREMIUM_DNS_URL="$BASE_URL/premium_dns.txt"

# -------- Colors -------- #
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# -------- Banner -------- #
clear
TITLE_COLORS=("\033[0;34m" "\033[0;32m" "\033[0;35m" "\033[0;36m")
RANDOM_COLOR=${TITLE_COLORS[$RANDOM % ${#TITLE_COLORS[@]}]}
echo -e "${RANDOM_COLOR}"
echo "██████╗ ███╗   ██╗███████╗     ██████╗ ███╗   ██╗███████╗██████╗"
echo "██╔══██╗████╗  ██║██╔════╝    ██╔═══██╗████╗  ██║██╔════╝██╔══██╗"
echo "██████╔╝██╔██╗ ██║█████╗      ██║   ██║██╔██╗ ██║█████╗  ██████╔╝"
echo "██╔═══╝ ██║╚██╗██║██╔══╝      ██║   ██║██║╚██╗██║██╔══╝  ██╔══██╗"
echo "██║     ██║ ╚████║███████╗    ╚██████╔╝██║ ╚████║███████╗██║  ██║"
echo "╚═╝     ╚═╝  ╚═══╝╚══════╝     ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"

# -------- Functions -------- #

show_menu() {
    echo -e "${CYAN}📋 Choose an option:${NC}"
    echo "1) 🎮 Gaming DNS"
    echo "2) 🌍 Country-specific DNS"
    echo "3) 💎 Premium DNS"
    echo "4) 📶 Ping a DNS"
    echo "5) 🔍 Search a Game"
    echo "0) ❌ Exit"
}

get_list_from_url() {
    curl -fsSL "$1" || echo ""
}

get_dns_by_game_country() {
    local game="$1"
    local country="$2"
    local dns=$(grep -i "^$game|$country|" <<< "$dns_list" | shuf -n 2)
    if [[ -z "$dns" ]]; then
        echo -e "${RED}❌ DNS not found for this game/country${NC}"
    else
        echo "$dns" | while IFS='|' read -r game_name country_name primary secondary ping; do
            echo -e "${GREEN}🎮 Game: $game_name - 🌍 Country: $country_name${NC}"
            echo "🟢 Primary DNS: $primary"
            echo "🔵 Secondary DNS: $secondary"
            echo "📶 Ping: $ping"
            echo ""
        done
    fi
}

# -------- Main Loop -------- #

# Load all lists
games_list=$(get_list_from_url "$GAMES_URL")
countries_list=$(get_list_from_url "$COUNTRIES_URL")
dns_list=$(get_list_from_url "$DNS_URL")
premium_list=$(get_list_from_url "$PREMIUM_DNS_URL")

if [[ -z "$games_list" || -z "$countries_list" || -z "$dns_list" ]]; then
    echo -e "${RED}❌ Failed to load one or more lists from GitHub${NC}"
    exit 1
fi

while true; do
    show_menu
    read -rp "#? " option
    case "$option" in
        1)
            echo -e "${CYAN}🎮 Select a Game:${NC}"
            echo "$games_list"
            read -rp "Enter game number: " game_num
            selected_game=$(echo "$games_list" | sed -n "${game_num}p" | cut -d')' -f2 | xargs)
            echo -e "${CYAN}🌍 Select a Country:${NC}"
            echo "$countries_list"
            read -rp "Enter country number: " country_num
            selected_country=$(echo "$countries_list" | sed -n "${country_num}p" | cut -d')' -f2 | xargs)
            get_dns_by_game_country "$selected_game" "$selected_country"
            read -rp "Press Enter to return..."
            ;;
        2)
            echo -e "${CYAN}🌍 Select a Country:${NC}"
            echo "$countries_list"
            read -rp "Enter country number: " country_num
            selected_country=$(echo "$countries_list" | sed -n "${country_num}p" | cut -d')' -f2 | xargs)
            get_dns_by_game_country "Default" "$selected_country"
            read -rp "Press Enter to return..."
            ;;
        3)
            echo -e "${CYAN}💎 Premium DNS Servers:${NC}"
            echo "$premium_list"
            read -rp "Press Enter to return..."
            ;;
        4)
            read -rp "Enter DNS to ping: " dns_ip
            ping -c 3 "$dns_ip"
            read -rp "Press Enter to return..."
            ;;
        5)
            read -rp "Enter game name to search: " search_query
            echo "$games_list" | grep -i "$search_query"
            read -rp "Press Enter to return..."
            ;;
        0)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid option${NC}"
            ;;
    esac
done
