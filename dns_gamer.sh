#!/bin/bash

# Auto install required tools
deps=("curl" "ping" "bc")
for pkg in "${deps[@]}"; do
    if ! command -v $pkg &>/dev/null; then
        echo "Installing $pkg..."
        apt install -y $pkg &>/dev/null
    fi
done

# Colors
colors=("\033[0;31m" "\033[0;32m" "\033[0;33m" "\033[0;34m" "\033[0;35m" "\033[0;36m")
BLUE="\033[1;34m"
GREEN="\033[1;32m"
RESET="\033[0m"
TITLE_COLOR=${colors[$RANDOM % ${#colors[@]}]}

# Typing animation
type_text() {
    text="$1"
    delay=0.0035
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Title + admin info
clear
echo -e "${TITLE_COLOR}┌────────────────────────────────────────────────────┐"
echo -e "│              GAMING DNS TOOL - v1.2.3              │"
echo -e "└────────────────────────────────────────────────────┘${RESET}"
echo
type_text "🎮 بهترین DNS برای بازی، دانلود و دور زدن تحریم‌ها"
echo
echo -e "${TITLE_COLOR}┌──────────────────────────────┐"
echo -e "│ Admin: @MahdiAGM0            │"
echo -e "│ Telegram: @Academi_vpn       │"
echo -e "└──────────────────────────────┘${RESET}"
echo

# Game list
declare -a games=(
    "Call of Duty" "PUBG" "Fortnite" "Free Fire" "Valorant"
    "Arena Breakout 🔵 (New)" "Apex Legends" "Dota 2" "Overwatch"
    "CS:GO" "League of Legends" "FIFA Mobile" "Rocket League"
    "Mobile Legends" "Genshin Impact" "Clash Royale" "Clash of Clans"
    "Minecraft" "Warzone" "Battlefield" "Rainbow Six" "Among Us"
    "Roblox" "Brawl Stars" "Diablo" "NBA 2K" "Wild Rift" "Crossfire"
    "eFootball" "Summoners War" "Tower of Fantasy" "Lost Light 🔵 (New)"
    "Standoff 2 🔵 (New)" "World of Tanks" "World of Warships" "Halo"
    "Destiny 2" "The Division" "Paladins 🔵 (New)" "Smite 🔵 (New)"
    "Arena of Valor 🔵 (New)" "TFT 🔵 (New)" "Overprime 🔵 (New)"
    "Zula 🔵 (New)" "Hyper Front 🔵 (New)" "Critical Ops 🔵 (New)"
    "Darkness Rises 🔵 (New)" "Heroes Evolved 🔵 (New)"
    "Naraka Bladepoint 🔵 (New)"
)

middle_east_countries=("Iran" "Turkey" "UAE" "Qatar" "Kuwait" "Iraq" "Saudi Arabia")

# Function to simulate API response (mock)
get_dns_from_api() {
    echo "5.$RANDOM.$RANDOM.1"
    echo "5.$RANDOM.$RANDOM.2"
    echo "$((RANDOM % 20 + 10))"  # Ping
}

main_menu() {
    echo -e "${TITLE_COLOR}[1]${RESET} Gaming DNS 🎮"
    echo -e "${TITLE_COLOR}[2]${RESET} Download DNS ⬇️"
    echo -e "${TITLE_COLOR}[3]${RESET} Premium DNS 💎"
    echo -e "${TITLE_COLOR}[4]${RESET} Search Game DNS 🔍"
    echo -e "${TITLE_COLOR}[0]${RESET} Exit ❌"
    echo
    read -p "Select an option: " opt

    case $opt in
        1) game_dns ;;
        2) download_dns ;;
        3) premium_dns ;;
        4) search_dns ;;
        0) echo -e "${GREEN}Goodbye!${RESET}" ; exit ;;
        *) echo "❌ Invalid option." ; main_menu ;;
    esac
}

game_dns() {
    clear
    echo -e "${TITLE_COLOR}🎮 Choose your game:${RESET}"
    for i in "${!games[@]}"; do
        if [[ "${games[$i]}" == *"(New)"* ]]; then
            echo -e "${BLUE}[$((i+1))] ${games[$i]}${RESET}"
        else
            echo -e "${TITLE_COLOR}[$((i+1))]${RESET} ${games[$i]}"
        fi
    done
    echo -e "${TITLE_COLOR}[0]${RESET} Back"
    echo
    read -p "Enter game number: " gnum
    [[ "$gnum" == "0" ]] && main_menu

    selected_game="${games[$((gnum-1))]}"
    echo -e "\n${TITLE_COLOR}🌍 Choose country:${RESET}"
    for i in "${!middle_east_countries[@]}"; do
        echo -e "${TITLE_COLOR}[$((i+1))]${RESET} ${middle_east_countries[$i]}"
    done
    read -p "Enter country number: " cnum
    echo

    ip1=$(get_dns_from_api | sed -n 1p)
    ip2=$(get_dns_from_api | sed -n 2p)
    ping=$(get_dns_from_api | sed -n 3p)

    echo -e "${GREEN}✅ DNS for $selected_game${RESET}"
    echo -e "${TITLE_COLOR}Primary DNS:${RESET} $ip1"
    echo -e "${TITLE_COLOR}Secondary DNS:${RESET} $ip2"
    echo -e "${TITLE_COLOR}Ping:${RESET} ${ping}ms"
    echo
    read -p "Press ENTER to return..." _
    main_menu
}

download_dns() {
    clear
    echo -e "${TITLE_COLOR}🌐 Choose region for download DNS:${RESET}"
    countries=("Iran" "USA" "Germany" "Singapore" "India")
    for i in "${!countries[@]}"; do
        echo -e "${TITLE_COLOR}[$((i+1))]${RESET} ${countries[$i]}"
    done
    read -p "Enter number: " dnum

    ip1=$(get_dns_from_api | sed -n 1p)
    ip2=$(get_dns_from_api | sed -n 2p)
    ping=$(get_dns_from_api | sed -n 3p)

    echo -e "\n${GREEN}✅ Download DNS${RESET}"
    echo -e "${TITLE_COLOR}Primary DNS:${RESET} $ip1"
    echo -e "${TITLE_COLOR}Secondary DNS:${RESET} $ip2"
    echo -e "${TITLE_COLOR}Ping:${RESET} ${ping}ms"
    echo
    read -p "Press ENTER to return..." _
    main_menu
}

premium_dns() {
    clear
    ip1="8.8.8.8"
    ip2="8.8.4.4"
    ping="19"
    echo -e "${GREEN}💎 Premium DNS${RESET}"
    echo -e "${TITLE_COLOR}Primary DNS:${RESET} $ip1"
    echo -e "${TITLE_COLOR}Secondary DNS:${RESET} $ip2"
    echo -e "${TITLE_COLOR}Ping:${RESET} ${ping}ms"
    echo
    read -p "Press ENTER to return..." _
    main_menu
}

search_dns() {
    clear
    read -p "🔍 Enter game name: " keyword
    found=0
    for i in "${!games[@]}"; do
        if [[ "${games[$i],,}" == *"${keyword,,}"* ]]; then
            found=1
            echo -e "${GREEN}✅ Game found: ${games[$i]}${RESET}"
            echo -e "${TITLE_COLOR}Choose country:${RESET}"
            for j in "${!middle_east_countries[@]}"; do
                echo -e "${TITLE_COLOR}[$((j+1))]${RESET} ${middle_east_countries[$j]}"
            done
            read -p "Select country: " cnum
            ip1=$(get_dns_from_api | sed -n 1p)
            ip2=$(get_dns_from_api | sed -n 2p)
            ping=$(get_dns_from_api | sed -n 3p)

            echo -e "\n${GREEN}🎯 DNS Result:${RESET}"
            echo -e "${TITLE_COLOR}Primary DNS:${RESET} $ip1"
            echo -e "${TITLE_COLOR}Secondary DNS:${RESET} $ip2"
            echo -e "${TITLE_COLOR}Ping:${RESET} ${ping}ms"
            break
        fi
    done

    if [[ "$found" == 0 ]]; then
        echo -e "${GREEN}❌ Game not found.${RESET}"
    fi

    echo
    read -p "Press ENTER to return..." _
    main_menu
}

main_menu
