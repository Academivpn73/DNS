#!/bin/bash

# Version 2.1 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
bold="\e[1m"
reset="\e[0m"
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"

# Fast Typing
fast_type() {
    text="$1"
    speed="${2:-0.00001}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $speed
    done
    echo
}

# Show Title
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    fast_type "╔══════════════════════════════════════╗" 0.0001
    fast_type "║         DNS MANAGEMENT TOOL         ║" 0.0001
    fast_type "╠══════════════════════════════════════╣" 0.0001
    fast_type "║  Version: 2.1                       ║" 0.0001
    fast_type "║  Telegram: @Academi_vpn            ║" 0.0001
    fast_type "║  Admin: @MahdiAGM0                 ║" 0.0001
    fast_type "╚══════════════════════════════════════╝" 0.0001
    echo -e "${reset}"
}

# DNS List with Multiple DNS Options (with many DNS options for each game)
declare -A game_dns_map
game_dns_map=(
    ["Arena Breakout"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Call of Duty Mobile"]="1.1.1.1 | 8.8.8.8 | 1.0.0.1 | 9.9.9.9"
    ["PUBG Mobile"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Free Fire"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Fortnite"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Minecraft"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["League of Legends"]="1.1.1.1 | 8.8.8.8 | 9.9.9.9 | 1.0.0.1"
    ["Valorant"]="1.1.1.1 | 8.8.8.8 | 9.9.9.9 | 1.0.0.1"
    ["CS:GO"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Dota 2"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Roblox"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Overwatch"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Apex Legends"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Battlefield V"]="1.1.1.1 | 8.8.8.8 | 9.9.9.9 | 1.0.0.1"
    ["Genshin Impact"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Clash of Clans"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Clash Royale"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["FIFA Online"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Mobile Legends"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Warzone"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Honkai Star Rail"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Among Us"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Rocket League"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Team Fortress 2"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Destiny 2"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Diablo Immortal"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Fall Guys"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Halo Infinite"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Paladins"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Crossfire"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Arena of Valor"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Smite"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Realm Royale"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["World of Tanks"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["World of Warships"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Black Desert"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Lost Ark"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Rust"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["ARK"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Sea of Thieves"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["New World"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Albion Online"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Tarkov"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Brawl Stars"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["War Thunder"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Dead by Daylight"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Naruto Slugfest"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Standoff 2"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
    ["Bullet Echo"]="185.51.200.2 | 178.22.122.100 | 1.1.1.1 | 8.8.8.8"
)

# Random DNS Function
random_dns() {
    dns_list=(${game_dns_map["$selected_game"]})
    random_index=$((RANDOM % ${#dns_list[@]}))
    selected_dns=${dns_list[$random_index]}
}

# Ping DNS Function
ping_dns() {
    echo -n "Pinging DNS: $selected_dns... "
    ping -c 1 "$selected_dns" > /dev/null && echo "$selected_dns: OK" || echo "$selected_dns: FAILED"
}

# Game DNS Menu (for Mobile & PC Games)
game_dns_menu() {
    echo -e "\n${bold}${blue}Mobile & PC Games:${reset}"
    i=1
    for game in "${!game_dns_map[@]}"; do
        label="$game"
        [[ "$game" == "Arena Breakout" ]] && label="${orange}$game (New)${reset}"
        echo "[$i] $label"
        ((i++))
    done
    echo -n "Choose a game: "; read gidx
    selected_game=$(printf "%s\n" "${!game_dns_map[@]}" | sed -n "${gidx}p")
    random_dns
    echo "DNS for $selected_game: $selected_dns"
    ping_dns
}

# Main Menu Function
main_menu() {
    echo -e "${bold}${blue}Main Menu:${reset}"
    echo "1. Gaming DNS (Mobile & PC)"
    echo "0. Exit"
    echo -n "Choose an option: "
    read choice
    case $choice in
        1) game_dns_menu ;;
        0) echo "Goodbye!"; exit ;;
        *) echo "Invalid option"; main_menu ;;
    esac
}

# Show Title and Start Main Menu
show_title
main_menu
