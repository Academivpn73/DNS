#!/bin/bash

VERSION="1.2.4"
TG="@Academi_vpn"
ADMIN="@MahdiAGM0"

# Colors
GREEN='\033[0;32m'
BLUE='\033[1;36m'
NC='\033[0m'

# Typing animation
type_anim() {
    text="$1"
    delay=${2:-0.001}
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep "$delay"
    done
    echo
}

# API ping function (fallback to system ping)
get_ping() {
    ip=$1
    api_ping=$(curl -s -o /dev/null -w "%{time_total}" "https://$ip")
    if [[ $? -eq 0 && $api_ping ]]; then
        ms=$(awk "BEGIN {print int($api_ping * 1000)}")
        echo "${ms}ms"
    else
        fallback=$(ping -c 1 -W 1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
        echo "${fallback:-N/A}ms"
    fi
}

# Copy to clipboard
copy_to_clipboard() {
    dns=$1
    if command -v xclip &>/dev/null; then
        echo -n "$dns" | xclip -selection clipboard
        echo -e "${GREEN}✅ Copied to clipboard!${NC}"
    else
        echo -e "${BLUE}📋 Your selected DNS: ${GREEN}$dns${NC}"
        echo -e "${BLUE}(Tip: Install xclip to enable clipboard copy)${NC}"
    fi
}

# Game and download data
declare -A DNS_DATA

DNS_DATA["Call of Duty_Iran"]="1.1.1.1 8.8.8.8 178.22.122.100 185.51.200.2 94.140.14.14 9.9.9.9 1.0.0.1 208.67.222.222 45.90.28.0 176.103.130.130 185.228.168.9 94.130.180.225 185.121.177.177 185.43.135.1 185.130.44.108 89.32.248.2 37.156.28.10 91.239.100.100 212.26.18.41 109.72.0.2"

DNS_DATA["Download_Iran"]="8.8.8.8 1.1.1.1 9.9.9.9 185.51.200.2 178.22.122.100 185.228.168.9 45.90.28.0 208.67.222.222 176.103.130.130 185.121.177.177 94.140.14.14 91.239.100.100 185.43.135.1 185.130.44.108 94.130.180.225 109.72.0.2 37.156.28.10 212.26.18.41 185.51.202.2 5.2.75.75"

GAMES=("Call of Duty" "PUBG" "Fortnite" "Valorant" "Dota 2" "CS:GO" "League of Legends" "Apex Legends" "Overwatch" "Mobile Legends" "Free Fire" "Clash Royale" "Minecraft" "GTA V" "Rocket League" "Warzone" "FIFA" "World of Tanks" "Paladins" "Roblox" "Smite" "Escape from Tarkov" "Rainbow Six Siege" "Rust" "Battlefield" "Diablo" "Team Fortress 2" "Brawl Stars" "Among Us" "Elden Ring")

MIDDLE_EAST=("Iran" "Turkey" "UAE" "Saudi Arabia")
DOWNLOAD_COUNTRIES=("Iran" "Germany" "USA" "France" "Netherlands" "UK" "Japan" "Canada" "India" "Italy" "Russia" "Spain" "Brazil" "Sweden" "South Korea" "Norway" "Singapore" "Finland" "Australia" "Poland")

main_menu() {
    clear
    echo -e "${BLUE}╔═════════════════════════════════════════════╗"
    echo -e "${BLUE}║${GREEN}         🎮 DNS MANAGEMENT SCRIPT         ${BLUE}║"
    echo -e "${BLUE}╠═════════════════════════════════════════════╣"
    echo -e "${BLUE}║  ${GREEN}Telegram:${NC} $TG"
    echo -e "${BLUE}║  ${GREEN}Admin   :${NC} $ADMIN"
    echo -e "${BLUE}║  ${GREEN}Version :${NC} $VERSION"
    echo -e "${BLUE}╚═════════════════════════════════════════════╝${NC}"
    echo
    type_anim "${GREEN}[1]${NC} Gaming DNS        ${GREEN}[2]${NC} Download DNS" 0.002
    type_anim "${GREEN}[0]${NC} Exit" 0.002
    echo -ne "${BLUE}Select an option: ${NC}"
    read opt
    case $opt in
        1) show_games ;;
        2) show_download_countries ;;
        0) exit ;;
        *) main_menu ;;
    esac
}

show_games() {
    clear
    echo -e "${BLUE}🎮 Choose a Game:${NC}"
    for i in "${!GAMES[@]}"; do
        echo -e "${GREEN}[$((i+1))]${NC} ${GAMES[$i]}"
        sleep 0.01
    done
    echo -ne "${BLUE}Enter number: ${NC}"
    read gnum
    game="${GAMES[$((gnum-1))]}"
    show_mena "$game"
}

show_mena() {
    game="$1"
    clear
    echo -e "${BLUE}🌍 Choose Country:"
    for i in "${!MIDDLE_EAST[@]}"; do
        echo -e "${GREEN}[$((i+1))]${NC} ${MIDDLE_EAST[$i]}"
        sleep 0.01
    done
    echo -ne "${BLUE}Enter number: ${NC}"
    read cnum
    country="${MIDDLE_EAST[$((cnum-1))]}"
    show_dns "$game" "$country"
}

show_download_countries() {
    clear
    echo -e "${BLUE}⬇️ Choose Download Country:"
    for i in "${!DOWNLOAD_COUNTRIES[@]}"; do
        echo -e "${GREEN}[$((i+1))]${NC} ${DOWNLOAD_COUNTRIES[$i]}"
        sleep 0.01
    done
    echo -ne "${BLUE}Enter number: ${NC}"
    read cnum
    country="${DOWNLOAD_COUNTRIES[$((cnum-1))]}"
    show_dns "Download" "$country"
}

show_dns() {
    key="${1}_${2}"
    dns_raw="${DNS_DATA[$key]}"
    echo -e "\n${BLUE}📡 DNS List for ${1} - ${2}:${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    dns_list=($dns_raw)
    random_dns=($(shuf -e "${dns_list[@]}" | head -n 15))
    count=1
    for dns in "${random_dns[@]}"; do
        ping=$(get_ping "$dns")
        echo -e "${GREEN}[$count]${NC} $dns ${BLUE}(Ping: $ping)${NC}"
        ((count++))
        sleep 0.05
    done
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${BLUE}Enter number to copy DNS (0 to return): ${NC}"
    read choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && ((choice >= 1 && choice <= 15)); then
        copy_to_clipboard "${random_dns[$((choice-1))]}"
    fi
    echo -ne "${BLUE}Press Enter to return...${NC}"; read
    main_menu
}

main_menu
