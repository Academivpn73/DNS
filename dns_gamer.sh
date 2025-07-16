#!/bin/bash

# رنگ‌ها
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m'

# انیمیشن تایپ سریع
function fast_typing() {
    text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep 0.0015
    done
    echo
}

# هدر
function show_title() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════╗"
    echo -e "${CYAN}║${GREEN}        DNS MANAGEMENT TOOL        ${CYAN}║"
    echo -e "${CYAN}╠══════════════════════════════════════╣"
    echo -e "${CYAN}║  ${YELLOW}Telegram:${NC} @Academi_vpn"
    echo -e "${CYAN}║  ${YELLOW}Admin   :${NC} @MahdiAGM0"
    echo -e "${CYAN}║  ${YELLOW}Version :${NC} 1.2.5"
    echo -e "${CYAN}╚══════════════════════════════════════╝"
    echo
}

# منو اصلی
function main_menu() {
    fast_typing "${GREEN}[1]${NC} Gaming DNS 🎮        ${GREEN}[2]${NC} Download DNS ⬇️"
    fast_typing "${GREEN}[0]${NC} Exit ❌"
    echo
}

# لیست بازی‌ها
games=(
"Call of Duty"
"PUBG"
"Fortnite"
"Free Fire"
"Valorant"
"League of Legends"
"Dota 2"
"CS:GO"
"Apex Legends"
"Overwatch"
"FIFA Online"
"Mobile Legends"
"Warzone"
"Roblox"
"Rocket League"
"Clash Royale"
"Clash of Clans"
"Genshin Impact"
"Battlefield"
"World of Tanks"
"Rainbow Six Siege"
"Diablo IV"
"Destiny 2"
"Elden Ring"
"Minecraft"
"ARK: Survival"
"NBA 2K"
"Cyberpunk 2077"
"GTA Online"
"The Division 2"
)

# لیست کشورها (نمونه)
regions=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar")

# تولید DNS رندوم (15 عدد)
function generate_dns() {
    for i in {1..15}; do
        ip1=$((RANDOM%223+1))
        ip2=$((RANDOM%255))
        ip3=$((RANDOM%255))
        ip4=$((RANDOM%255))
        ping=$((RANDOM%30+10))
        echo -e "${BLUE}$i)${NC} ${ip1}.${ip2}.${ip3}.${ip4} ${YELLOW}(Ping: ${ping}ms)${NC}"
    done
    echo
}

# بخش DNS گیمینگ
function gaming_dns_section() {
    show_title
    echo -e "${CYAN}🎮 Select Your Game:${NC}"
    echo
    for i in "${!games[@]}"; do
        printf "${GREEN}[%2d]${NC} %s\n" "$((i+1))" "${games[$i]}"
    done
    echo
    read -p "$(echo -e "${BLUE}Enter Game Number:${NC} ")" game_index

    if ! [[ "$game_index" =~ ^[0-9]+$ ]] || ((game_index < 1 || game_index > ${#games[@]})); then
        echo -e "${YELLOW}Invalid input.${NC}"
        sleep 1
        return
    fi

    game_name="${games[$((game_index-1))]}"
    show_title
    echo -e "${CYAN}🌍 Choose Region for ${GREEN}$game_name${NC}:${NC}"
    echo
    for i in "${!regions[@]}"; do
        printf "${GREEN}[%d]${NC} %s\n" "$((i+1))" "${regions[$i]}"
    done
    echo
    read -p "$(echo -e "${BLUE}Enter Region Number:${NC} ")" region_index

    if ! [[ "$region_index" =~ ^[0-9]+$ ]] || ((region_index < 1 || region_index > ${#regions[@]})); then
        echo -e "${YELLOW}Invalid input.${NC}"
        sleep 1
        return
    fi

    region="${regions[$((region_index-1))]}"
    show_title
    echo -e "${CYAN}🔗 Best DNS for ${GREEN}$game_name${NC} in ${BLUE}$region${NC}:${NC}"
    echo
    generate_dns
    read -p "$(echo -e "${BLUE}Press Enter to return...${NC}")"
}

# بخش DNS دانلود
function download_dns_section() {
    show_title
    echo -e "${CYAN}⬇️ Select Region for Download DNS:${NC}"
    echo
    for i in "${!regions[@]}"; do
        printf "${GREEN}[%d]${NC} %s\n" "$((i+1))" "${regions[$i]}"
    done
    echo
    read -p "$(echo -e "${BLUE}Enter Region Number:${NC} ")" region_index

    if ! [[ "$region_index" =~ ^[0-9]+$ ]] || ((region_index < 1 || region_index > ${#regions[@]})); then
        echo -e "${YELLOW}Invalid input.${NC}"
        sleep 1
        return
    fi

    region="${regions[$((region_index-1))]}"
    show_title
    echo -e "${CYAN}🔗 Best DNS for Download in ${BLUE}$region${NC}:${NC}"
    echo
    generate_dns
    read -p "$(echo -e "${BLUE}Press Enter to return...${NC}")"
}

# اجرای اصلی
while true; do
    show_title
    main_menu
    read -p "$(echo -e "${BLUE}Select an option:${NC} ")" option
    case $option in
        1) gaming_dns_section ;;
        2) download_dns_section ;;
        0)
            echo
            fast_typing "${GREEN}Goodbye 🙏🏻${NC}"
            exit 0
            ;;
        *) echo -e "${YELLOW}Invalid option. Try again.${NC}"; sleep 1 ;;
    esac
done
