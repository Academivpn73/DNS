#!/bin/bash

VERSION="1.2.1"
TG="@Academi_vpn"
ADMIN="@MahdiAGM0"

# Define colors
GREEN='\e[32m'
BLUE='\e[36m'
NC='\e[0m'

# Type animation function
type_anim() {
    text="$1"
    delay=${2:-0.002}
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep "$delay"
    done
    echo
}

# Fast animation for game/country lists
list_anim() {
    for line in "$@"; do
        echo -e "$line"
        sleep 0.02
    done
}

# Ping test
get_ping() {
    ip=$1
    ping_result=$(ping -c 1 -W 1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [[ -n "$ping_result" ]]; then
        echo "${ping_result}ms"
    else
        echo "N/A"
    fi
}

# DNS Database (truncated sample)
declare -A DNS_DATA

# Sample DNS for "Call of Duty - Iran"
DNS_DATA["Call of Duty_Iran"]="1.1.1.1 8.8.8.8 185.51.200.2 178.22.122.100 9.9.9.9 94.140.14.14 185.51.200.4 208.67.222.222 176.103.130.130 1.0.0.1 94.130.180.225 45.90.28.0 89.32.248.2 91.239.100.100 37.156.28.10"

# Sample DNS for Download - Germany
DNS_DATA["Download_Germany"]="1.1.1.1 8.8.8.8 9.9.9.9 94.140.14.14 185.51.200.2 208.67.222.222 185.228.168.9 176.103.130.130 45.90.28.0 185.228.168.10 185.121.177.177 94.130.180.225 37.156.28.10 89.32.248.2 91.239.100.100"

# Sample lists
GAMES=(
"Call of Duty"
"PUBG"
"Fortnite"
"Valorant"
"Apex Legends"
"League of Legends"
"Dota 2"
"CS:GO"
"Overwatch"
"Battlefield"
"Mobile Legends"
"Free Fire"
"Clash of Clans"
"Clash Royale"
"Among Us"
"GTA Online"
"World of Tanks"
"Rocket League"
"FIFA Online"
"Minecraft"
"Roblox"
"Destiny 2"
"Rainbow Six Siege"
"Elden Ring"
"Warzone"
"Escape from Tarkov"
"Team Fortress 2"
"Paladins"
"Smite"
"Diablo IV"
)

MIDDLE_EAST_COUNTRIES=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Kuwait" "Jordan" "Oman")

WORLD_COUNTRIES=("Iran" "Germany" "Netherlands" "USA" "UK" "France" "Japan" "South Korea" "Russia" "India" "Italy" "Canada" "Australia" "Spain" "Brazil" "Sweden" "Poland" "Singapore" "Norway" "China")

show_main_menu() {
    clear
    echo -e "${BLUE}╔══════════════════════════════════════╗"
    echo -e "${BLUE}║${GREEN}       DNS MANAGEMENT SCRIPT        ${BLUE}║"
    echo -e "${BLUE}╠══════════════════════════════════════╣"
    echo -e "${BLUE}║  ${GREEN}Telegram:${NC} $TG"
    echo -e "${BLUE}║  ${GREEN}Admin   :${NC} $ADMIN"
    echo -e "${BLUE}║  ${GREEN}Version :${NC} $VERSION"
    echo -e "${BLUE}╚══════════════════════════════════════╝${NC}"
    echo
    type_anim "${GREEN}[1]${NC} Gaming DNS 🎮"
    type_anim "${GREEN}[2]${NC} Download DNS ⬇️"
    type_anim "${GREEN}[0]${NC} Exit ❌"
    echo
    echo -ne "${BLUE}Select an option: ${NC}"
    read opt
    case $opt in
        1) show_game_menu ;;
        2) show_download_menu ;;
        0) exit_script ;;
        *) echo -e "${RED}Invalid Option!"; sleep 1; show_main_menu ;;
    esac
}

show_game_menu() {
    clear
    echo -e "${BLUE}🎮 Select Your Game:"
    i=1
    for game in "${GAMES[@]}"; do
        echo -e "${GREEN}[$i]${NC} $game"
        ((i++))
        sleep 0.02
    done
    echo -ne "${BLUE}Enter game number: ${NC}"
    read gnum
    selected_game="${GAMES[$((gnum-1))]}"
    show_country_menu "$selected_game"
}

show_country_menu() {
    game="$1"
    clear
    echo -e "${BLUE}🌍 Select Country for $game:"
    i=1
    for country in "${MIDDLE_EAST_COUNTRIES[@]}"; do
        echo -e "${GREEN}[$i]${NC} $country"
        ((i++))
        sleep 0.02
    done
    echo -ne "${BLUE}Enter country number: ${NC}"
    read cnum
    selected_country="${MIDDLE_EAST_COUNTRIES[$((cnum-1))]}"
    show_dns "$game" "$selected_country"
}

show_download_menu() {
    clear
    echo -e "${BLUE}⬇️  Select Country for Download DNS:"
    i=1
    for country in "${WORLD_COUNTRIES[@]}"; do
        echo -e "${GREEN}[$i]${NC} $country"
        ((i++))
        sleep 0.02
    done
    echo -ne "${BLUE}Enter country number: ${NC}"
    read cnum
    selected_country="${WORLD_COUNTRIES[$((cnum-1))]}"
    show_dns "Download" "$selected_country"
}

show_dns() {
    g="$1"
    c="$2"
    key="${g}_${c}"
    dns_list=(${DNS_DATA[$key]})
    echo
    echo -e "${BLUE}Showing 15 DNS for $g - $c:${NC}"
    echo -e "${GREEN}----------------------------------${NC}"
    for i in "${!dns_list[@]}"; do
        [[ $i -ge 15 ]] && break
        dns="${dns_list[$i]}"
        ping_val=$(get_ping "$dns")
        echo -e "${GREEN}[$((i+1))]${NC} $dns ${BLUE}(Ping: $ping_val)${NC}"
        sleep 0.05
    done
    echo -e "${GREEN}----------------------------------${NC}"
    echo -ne "${BLUE}Press Enter to return...${NC}"; read
    show_main_menu
}

exit_script() {
    echo -e "\n${YELLOW}Goodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn${NC}"
    exit 0
}

# Start the script
show_main_menu
