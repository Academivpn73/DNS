#!/bin/bash

# نصب پیش‌نیازها
for pkg in curl figlet lolcat; do
    if ! command -v "$pkg" &> /dev/null; then
        apt update && apt install -y "$pkg"
    fi
done

# رنگ تصادفی برای عنوان
colors=(31 32 33 34 35 36)
color=${colors[$RANDOM % ${#colors[@]}]}
clear
echo -e "\033[1;${color}m"
figlet -f slant "DNS Gamer Pro" | lolcat
echo -e "\033[0m"
echo -e "\033[1;30m-----------------------------------------------\033[0m"
echo -e "\033[1;37mTelegram: @Academi_vpn        Admin: @MahdiAGM0\033[0m"
echo -e "\033[1;30m-----------------------------------------------\033[0m"

# انیمیشن تایپ
typer() {
    text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.0008
    done
    echo
}

slider() {
    for line in "$@"; do typer "$line"; done
}

# لیست 50 بازی
games=( 
"Apex Legends" "Call of Duty Mobile" "Fortnite" "PUBG Mobile" "Valorant"
"Free Fire" "League of Legends" "Dota 2" "CS:GO" "Clash Royale"
"Overwatch" "Battlefield V" "GTA Online" "Rocket League" "Warzone"
"Mobile Legends" "Roblox" "Among Us" "Cyberpunk 2077" "Destiny 2"
"Minecraft" "Far Cry 6" "Rainbow Six Siege" "Elden Ring" "ARK: Survival"
"Fall Guys" "The Finals [New]" "Zula" "Paladins" "Standoff 2"
"FIFA 24" "Lost Ark" "Escape From Tarkov" "Warframe" "Rust"
"Terraria" "Team Fortress 2" "World of Tanks" "Arena Breakout [New]"
"Sky: Children of the Light [New]" "Black Desert Mobile [New]"
"Diablo Immortal [New]" "Naraka: Bladepoint [New]" "Dead by Daylight [New]"
"War Thunder [New]" "PUBG Lite [New]" "Super Mecha Champions [New]"
"Tower of Fantasy [New]"
)

# کشورها
countries=("Iran" "Turkey" "UAE" "Qatar" "Saudi Arabia" "Jordan" "Iraq" "Oman")

# مجموعه کامل DNS واقعی با پینگ احتمالی زیر 50ms
REAL_DNS=(
"1.1.1.1 1.0.0.1" "8.8.8.8 8.8.4.4" "9.9.9.9 149.112.112.112"
"94.140.14.14 94.140.15.15" "208.67.222.222 208.67.220.220"
"76.76.2.0 76.76.10.0" "45.90.28.0 45.90.30.0" "64.6.64.6 64.6.65.6"
"156.154.70.1 156.154.71.1" "23.253.163.53 198.101.242.72"
"37.235.1.174 37.235.1.177" "104.131.183.90 139.99.96.66"
"202.182.98.54 185.222.222.222" "95.85.95.60 5.9.49.12"
"185.107.80.84 185.107.80.80" "104.155.237.225 139.162.112.47"
"192.71.245.208 212.83.179.239" "216.146.35.35 216.146.36.36"
# (می‌تونی تا ۵۰۰ تا ادامه بدی)
)

get_dns() {
    idx=$((RANDOM % ${#REAL_DNS[@]}))
    arr=(${REAL_DNS[$idx]})
    primary=${arr[0]}; secondary=${arr[1]}
    ping=$(ping -c1 -W1 "$primary" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [[ -z $ping || ${ping%.*} -ge 50 ]]; then
        get_dns; return
    fi
    echo -e "DNS 1: \033[1;32m$primary\033[0m  DNS 2: \033[1;32m$secondary\033[0m  (Ping: $ping)"
}

# منو
main_menu() {
    slider \
    "1) 🎮 DNS Gaming" \
    "2) 📥 DNS Download (Anti-Filter)" \
    "3) 🔍 Search DNS by Game" \
    "4) 🚀 Premium DNS" \
    "5) 📡 Check DNS Ping" \
    "6) ❌ Exit"
    read -p "Select option: " opt
    case $opt in
      1) gaming ;;
      2) download ;;
      3) search ;;
      4) premium ;;
      5) check_ping ;;
      6) echo "Goodbye 🙏🏻"; exit ;;
      *) echo "Invalid!"; sleep 1; clear; main_menu ;;
    esac
}

gaming() {
    echo; for i in "${!games[@]}"; do
        index=$((i+1))
        if [[ ${games[$i]} == *"[New]"* ]]; then
            echo -e "$index) \033[1;34m${games[$i]}\033[0m"
        else
            echo "$index) ${games[$i]}"
        fi
    done
    read -p "Select game #: " g
    echo; for i in "${!countries[@]}"; do
        echo "$((i+1))) ${countries[$i]}"
    done
    read -p "Select country #: " c
    echo; echo "Fetching DNS..."
    get_dns; press
}

download() {
    echo; for i in "${!countries[@]}"; do
        echo "$((i+1))) ${countries[$i]}"
    done
    read -p "Select country #: " c
    echo; echo "Fetching download DNS..."
    get_dns; press
}

search() {
    read -p "Enter game name: " q
    found=0
    for g in "${games[@]}"; do
        [[ "${g,,}" =~ "${q,,}" ]] && echo "Found: $g" && found=1
    done
    if (( found )); then
        echo; for i in "${!countries[@]}"; do
            echo "$((i+1))) ${countries[$i]}"
        done
        read -p "Select country #: " c
        get_dns
    else
        echo -e "\033[1;32mGame not found!\033[0m"
    fi
    press
}

premium() {
    echo; echo "Fetching premium DNS..."
    get_dns; get_dns; press
}

check_ping() {
    read -p "Enter domain or DNS: " h
    echo; ping -c4 "$h"
    press
}

press() {
    read -p "↩ Press Enter to return..." _ ; clear; main_menu
}

# Start
main_menu
