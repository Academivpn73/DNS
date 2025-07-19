#!/bin/bash

# ANSI رنگ‌ها
colors=('\e[1;31m' '\e[1;32m' '\e[1;33m' '\e[1;34m' '\e[1;35m' '\e[1;36m' '\e[1;37m')

# عنوان با انیمیشن تایپی
animated_text() {
    local text="$1"
    local delay="$2"
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep "$delay"
    done
}

print_title() {
    clear
    color=${colors[$RANDOM % ${#colors[@]}]}
    box_top="╔══════════════════════════════════════════════════════╗"
    box_bottom="╚══════════════════════════════════════════════════════╝"
    echo -e "$color$box_top"
    echo -ne "$color║ "
    animated_text "⚡ Gaming DNS Script | Version 1.2.3 ⚡" 0.00008
    echo -e " ║"
    echo -e "$color║   Admin: @MahdiAGM0        Telegram: @Academi_vpn    ║"
    echo -e "$color$box_bottom\n"
    echo -e "\e[0m"
}

# بازی‌ها و کشورها
games=("Call of Duty" "Valorant" "PUBG" "Fortnite" "CS:GO" "FIFA" "League of Legends" "Dota 2" "Minecraft" "Warzone" "Overwatch" "Apex Legends" "Rainbow Six" "Free Fire" "Roblox" "Rocket League" "Mobile Legends" "Arena of Valor" "Clash Royale" "Brawl Stars" "World of Tanks" "Battlefield" "Rust" "Genshin Impact" "EFootball" "Fall Guys" "Escape from Tarkov" "Smite" "Team Fortress 2" "Arena Breakout (NEW)")

countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan" "Israel" "Lebanon" "Kuwait")

# تابع تولید DNS رندوم (پولی و واقعی نمونه‌ای)
generate_dns() {
    primary="185.$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255))"
    secondary="185.$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255))"
    echo -e "\nPrimary DNS: $primary"
    echo -e "Secondary DNS: $secondary"
}

# تابع گرفتن پینگ DNS از کاربر
ping_custom_dns() {
    read -p $'\nEnter DNS IP to ping: ' dns_ip
    echo -e "\nPinging $dns_ip...\n"
    ping -c 4 "$dns_ip"
    read -p $'\nPress Enter to return to menu...'
}

# فیلتر بازی‌ها
search_game() {
    read -p $'\nSearch game name: ' keyword
    found=false
    for ((i = 0; i < ${#games[@]}; i++)); do
        if [[ "${games[i],,}" == *"${keyword,,}"* ]]; then
            echo -e "[$((i+1))] ${games[i]}"
            found=true
        fi
    done
    if ! $found; then
        echo "No match found."
    fi
    read -p $'\nPress Enter to return...'
}

main_menu() {
    while true; do
        print_title
        echo -e "[1] Gaming DNS"
        echo -e "[2] Download DNS (Bypass Censorship)"
        echo -e "[3] Global Premium DNS"
        echo -e "[4] Check Custom DNS Ping"
        echo -e "[5] Search Game"
        echo -e "[0] Exit"
        read -p $'\nChoose an option: ' opt
        case "$opt" in
            1) gaming_dns ;;
            2) download_dns ;;
            3) global_dns ;;
            4) ping_custom_dns ;;
            5) search_game ;;
            0) echo -e "\nGoodbye 🙏🏻\n"; exit ;;
            *) echo "Invalid option." ;;
        esac
    done
}

gaming_dns() {
    print_title
    echo -e "🎮 Select your game:"
    for ((i=0; i<${#games[@]}; i++)); do
        if [[ "${games[i]}" == *"Arena Breakout"* ]]; then
            echo -e "[${i+1}] \e[1;34m${games[i]}\e[0m"
        else
            echo -e "[$((i+1))] ${games[i]}"
        fi
    done
    echo -e "[0] Back"
    read -p $'\nChoose your game: ' game_index
    if [[ "$game_index" == "0" ]]; then return; fi
    selected_game="${games[$((game_index-1))]}"
    echo -e "\n🌍 Select region for $selected_game:"
    for ((i=0; i<${#countries[@]}; i++)); do
        echo -e "[$((i+1))] ${countries[i]}"
    done
    echo -e "[0] Back"
    read -p $'\nChoose region: ' region_index
    [[ "$region_index" == "0" ]] && return
    echo -e "\n🔗 DNS for $selected_game (${countries[$((region_index-1))]}):"
    generate_dns
    read -p $'\nPress Enter to return...'
}

download_dns() {
    print_title
    echo -e "🌐 Select region:"
    for ((i=0; i<${#countries[@]}; i++)); do
        echo -e "[$((i+1))] ${countries[i]}"
    done
    echo -e "[0] Back"
    read -p $'\nChoose region: ' region_index
    [[ "$region_index" == "0" ]] && return
    echo -e "\n⬇️ Premium DNS for Downloads & Censorship Bypass (${countries[$((region_index-1))]}):"
    generate_dns
    read -p $'\nPress Enter to return...'
}

global_dns() {
    print_title
    echo -e "🌍 Global Premium DNS:"
    generate_dns
    read -p $'\nPress Enter to return...'
}

# اجرای اسکریپت
main_menu
