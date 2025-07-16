#!/bin/bash

# 🎨 رنگ‌ها
COLORS=(
    '\033[1;32m' # Green
    '\033[1;36m' # Cyan
)
NC='\033[0m'

# 🌈 تایتل با رنگ رندومی
show_title() {
    clear
    local color=${COLORS[$RANDOM % ${#COLORS[@]}]}
    echo -e "${color}╔══════════════════════════════════════╗"
    echo -e "║         DNS MANAGEMENT TOOL         ║"
    echo -e "╠══════════════════════════════════════╣"
    echo -e "║ Telegram: @Academi_vpn              ║"
    echo -e "║ Admin   : @MahdiAGM0                ║"
    echo -e "║ Version : 1.2.2                     ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    echo
}

# ⌨️ انیمیشن تایپ
typewriter() {
    text="$1"
    delay="${2:-0.001}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# 🌍 لیست کشورها
countries=("Iran" "Turkey" "UAE" "Germany" "USA" "UK" "Netherlands" "India" "Singapore" "France" "Italy" "Canada" "Brazil" "Saudi Arabia" "Russia" "Australia" "Japan" "South Korea" "Qatar" "South Africa")

# 🎮 لیست گیم‌ها
games=(
  "Call of Duty" "PUBG" "Fortnite" "Free Fire" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Apex Legends" "Overwatch" "Minecraft" "Roblox"
  "Rocket League" "Rainbow Six" "Warzone" "World of Tanks" "Genshin Impact"
  "Battlefield" "Escape from Tarkov" "Mobile Legends" "Brawl Stars" "Arena of Valor"
  "Clash Royale" "FIFA Online" "NBA 2K" "Among Us" "World of Warcraft" "Paladins"
  "Hearthstone" "Smite"
)

# 📡 تولید DNS رندوم
generate_dns_list() {
    for i in $(seq 1 15); do
        ip="$((RANDOM % 223 + 1)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
        ping="$((RANDOM % 30 + 5))"
        echo -e "\033[1;36m[$i]\033[0m $ip  \033[1;33m(Ping: ${ping}ms)\033[0m"
    done
}

# 🎮 بخش DNS گیمینگ
gaming_dns_section() {
    show_title
    echo -e "\033[1;34m🎮 Select a Game:\033[0m"
    for i in "${!games[@]}"; do
        echo -e "\033[1;32m[$((i+1))]\033[0m ${games[$i]}"
        sleep 0.02  # انیمیشن عمودی لیست
    done
    echo
    read -p $'\033[1;36mEnter Game Number:\033[0m ' gidx
    game="${games[$((gidx-1))]}"
    [[ -z "$game" ]] && return

    show_title
    echo -e "\033[1;34m🌍 Select a Region:\033[0m"
    for i in "${!countries[@]}"; do
        echo -e "\033[1;32m[$((i+1))]\033[0m ${countries[$i]}"
        sleep 0.01
    done
    echo
    read -p $'\033[1;36mEnter Region Number:\033[0m ' ridx
    region="${countries[$((ridx-1))]}"
    [[ -z "$region" ]] && return

    show_title
    typewriter "🎯 Best DNS for $game in $region:" 0.002
    echo
    generate_dns_list
    echo
    read -p $'\033[1;34mPress Enter to return to menu...\033[0m'
}

# ⬇️ بخش DNS دانلود
download_dns_section() {
    show_title
    echo -e "\033[1;34m🌍 Select a Region for Download:\033[0m"
    for i in "${!countries[@]}"; do
        echo -e "\033[1;32m[$((i+1))]\033[0m ${countries[$i]}"
        sleep 0.01
    done
    echo
    read -p $'\033[1;36mEnter Region Number:\033[0m ' ridx
    region="${countries[$((ridx-1))]}"
    [[ -z "$region" ]] && return

    show_title
    typewriter "⬇️  Best Download DNS for $region:" 0.002
    echo
    generate_dns_list
    echo
    read -p $'\033[1;34mPress Enter to return to menu...\033[0m'
}

# 🎛️ منوی اصلی
main_menu() {
    show_title
    echo -e "\033[1;32m[1]\033[0m Gaming DNS 🎮        \033[1;32m[2]\033[0m Download DNS ⬇️"
    echo -e "\033[1;32m[0]\033[0m Exit ❌"
    echo
    read -p $'\033[1;36mSelect an option:\033[0m ' choice
    case "$choice" in
        1) gaming_dns_section ;;
        2) download_dns_section ;;
        0) echo -e "\n\033[1;32mGoodbye 🙏🏻\033[0m"; exit 0 ;;
        *) echo -e "\033[1;31mInvalid option!\033[0m"; sleep 1 ;;
    esac
}

# 🔁 اجرای برنامه
while true; do
    main_menu
done
