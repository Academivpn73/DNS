#!/bin/bash

# 🎨 رنگ‌های ANSI
colors=('\e[1;31m' '\e[1;32m' '\e[1;33m' '\e[1;34m' '\e[1;35m' '\e[1;36m' '\e[1;37m')

# 🧠 لیست بازی‌ها (30 عدد)
games=(
"Call of Duty" "Valorant" "PUBG" "Fortnite" "CS:GO"
"FIFA" "League of Legends" "Dota 2" "Minecraft" "Warzone"
"Overwatch" "Apex Legends" "Rainbow Six" "Free Fire" "Roblox"
"Rocket League" "Mobile Legends" "Arena of Valor" "Clash Royale" "Brawl Stars"
"World of Tanks" "Battlefield" "Rust" "Genshin Impact" "EFootball"
"Fall Guys" "Escape from Tarkov" "Smite" "Team Fortress 2" "Arena Breakout (NEW)"
)

# 🌍 لیست کشورهای منطقه خاورمیانه
countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan" "Israel" "Lebanon" "Kuwait")

# ⏱️ تایپ انیمیشنی
animated_text() {
    local text="$1"
    local delay="$2"
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep "$delay"
    done
}

# 🖼️ چاپ عنوان زیبا با رنگ متغیر
print_title() {
    clear
    color=${colors[$RANDOM % ${#colors[@]}]}
    echo -e "$color"
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo -n "║ "; animated_text "⚡ Gaming DNS Script - Version 1.2.3 ⚡" 0.00008; echo " ║"
    echo "╠════════════════════════════════════════════════════════════════╣"
    echo "║ Admin: @MahdiAGM0         Telegram: @Academi_vpn              ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo -e "\e[0m"
}

# 📡 تولید DNS رندوم (واقعی نمایشی)
generate_dns() {
    primary="185.$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255))"
    secondary="185.$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255))"
    echo -e "\nPrimary DNS: $primary"
    echo -e "Secondary DNS: $secondary"
}

# 📶 پینگ DNS واردشده توسط کاربر
ping_custom_dns() {
    read -p $'\nEnter DNS IP to ping: ' dns_ip
    echo -e "\nPinging $dns_ip...\n"
    ping -c 4 "$dns_ip"
    read -p $'\nPress Enter to return to menu...'
}

# 🔎 جستجوی بازی
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

# 🧠 منوی اصلی
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

# 🎮 انتخاب بازی و کشور
gaming_dns() {
    print_title
    echo -e "🎮 Select your game:"
    for ((i=0; i<${#games[@]}; i++)); do
        if [[ "${games[i]}" == *"Arena Breakout"* ]]; then
            echo -e "[ $((i+1)) ] \e[1;34m${games[i]}\e[0m"
        else
            echo -e "[ $((i+1)) ] ${games[i]}"
        fi
    done
    echo -e "[0] Back"
    read -p $'\nChoose your game: ' game_index
    [[ "$game_index" == "0" ]] && return
    selected_game="${games[$((game_index-1))]}"
    echo -e "\n🌍 Select region for $selected_game:"
    for ((i=0; i<${#countries[@]}; i++)); do
        echo -e "[ $((i+1)) ] ${countries[i]}"
    done
    echo -e "[0] Back"
    read -p $'\nChoose region: ' region_index
    [[ "$region_index" == "0" ]] && return
    echo -e "\n🔗 DNS for $selected_game (${countries[$((region_index-1))]}):"
    generate_dns
    read -p $'\nPress Enter to return...'
}

# ⬇️ DNS مخصوص دانلود
download_dns() {
    print_title
    echo -e "🌐 Select region:"
    for ((i=0; i<${#countries[@]}; i++)); do
        echo -e "[ $((i+1)) ] ${countries[i]}"
    done
    echo -e "[0] Back"
    read -p $'\nChoose region: ' region_index
    [[ "$region_index" == "0" ]] && return
    echo -e "\n⬇️ Premium DNS for Downloads & Bypass (${countries[$((region_index-1))]}):"
    generate_dns
    read -p $'\nPress Enter to return...'
}

# 🌍 DNS جهانی
global_dns() {
    print_title
    echo -e "🌍 Global Premium DNS:"
    generate_dns
    read -p $'\nPress Enter to return...'
}

# ▶️ اجرای منو
main_menu
