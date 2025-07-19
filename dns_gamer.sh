#!/bin/bash

version="1.2.3"
admin="@MahdiAGM0"
telegram="@Academi_vpn"
colors=(31 32 33 34 35 36 91 92 93 94 95 96)
color=${colors[$RANDOM % ${#colors[@]}]}

function type_print() {
    text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "\e[1;${color}m${text:$i:1}\e[0m"
        sleep 0.01
    done
    echo
}

function title() {
    clear
    color=${colors[$RANDOM % ${#colors[@]}]} # Change on every return
    echo
    type_print "⚡ Gaming DNS Manager - Version $version"
    echo -e "\033[2mAdmin: $admin    Telegram: $telegram\033[0m"
    echo
}

function main_menu() {
    title
    echo -e "\033[1;32m[1]\033[0m 🎮 Gaming DNS"
    echo -e "\033[1;32m[2]\033[0m ⬇️ Download DNS (Unblock + Fast)"
    echo -e "\033[1;32m[3]\033[0m 📶 Ping DNS Test"
    echo -e "\033[1;32m[4]\033[0m 💎 Premium DNS (Under 40ms)"
    echo -e "\033[1;32m[0]\033[0m ❌ Exit"
    echo
    read -p "Select an option: " option
    case $option in
        1) gaming_dns ;;
        2) download_dns ;;
        3) ping_test ;;
        4) premium_dns ;;
        0) echo -e "\033[1;32mGoodbye!\033[0m"; exit ;;
        *) main_menu ;;
    esac
}

games=("Call of Duty" "PUBG" "Arena Breakout" "Fortnite" "Valorant" "Dota 2")
countries=("Germany" "France" "Netherlands" "UAE" "Turkey")

# DNS Data Structures (Keyed per game)
declare -A dns_map
dns_map["Call of Duty"]="185.51.200.2,185.51.200.3"
dns_map["PUBG"]="185.55.225.25,185.55.226.26"
dns_map["Arena Breakout"]="5.2.75.75,5.2.75.76"
dns_map["Fortnite"]="9.9.9.9,149.112.112.112"
dns_map["Valorant"]="1.0.0.1,1.1.1.1"
dns_map["Dota 2"]="208.67.222.222,208.67.220.220"

function gaming_dns() {
    title
    echo "🎮 Select a game:"
    for i in "${!games[@]}"; do
        echo -e "\033[36m[$((i+1))]\033[0m ${games[$i]}"
    done
    echo -e "\033[36m[0]\033[0m Back"
    read -p "Choose a game: " choice
    [[ $choice == 0 ]] && main_menu
    selected_game="${games[$((choice-1))]}"
    title
    echo "🌍 Choose region for $selected_game:"
    for i in "${!countries[@]}"; do
        echo -e "\033[36m[$((i+1))]\033[0m ${countries[$i]}"
    done
    echo -e "\033[36m[0]\033[0m Back"
    read -p "Choose region: " r_choice
    [[ $r_choice == 0 ]] && gaming_dns

    dns_pair=${dns_map["$selected_game"]}
    primary=$(echo "$dns_pair" | cut -d',' -f1)
    secondary=$(echo "$dns_pair" | cut -d',' -f2)
    echo
    echo -e "🎯 Game: \033[1m$selected_game\033[0m"
    echo -e "🟢 Primary DNS: \033[32m$primary\033[0m"
    echo -e "🔵 Secondary DNS: \033[34m$secondary\033[0m"
    read -p "Press Enter to return..." _
    main_menu
}

function download_dns() {
    title
    echo "🌍 Choose country for fast download:"
    for i in "${!countries[@]}"; do
        echo -e "\033[36m[$((i+1))]\033[0m ${countries[$i]}"
    done
    echo -e "\033[36m[0]\033[0m Back"
    read -p "Choose country: " d_choice
    [[ $d_choice == 0 ]] && main_menu

    dns_list=(
        "10.202.10.10,10.202.10.11"     # Shecan
        "178.22.122.100,185.51.200.2"   # Unblock
        "185.55.225.25,185.55.226.26"   # Custom CDN
    )
    rand=$((RANDOM % ${#dns_list[@]}))
    primary=$(echo "${dns_list[$rand]}" | cut -d',' -f1)
    secondary=$(echo "${dns_list[$rand]}" | cut -d',' -f2)

    echo
    echo -e "⬇️ Optimized DNS for Downloads:"
    echo -e "🟢 Primary DNS: \033[32m$primary\033[0m"
    echo -e "🔵 Secondary DNS: \033[34m$secondary\033[0m"
    read -p "Press Enter to return..." _
    main_menu
}

function ping_test() {
    title
    read -p "🔍 Enter DNS to ping: " dns
    echo "📡 Testing ping to $dns..."
    ping -c 4 "$dns"
    read -p "Press Enter to return..." _
    main_menu
}

function premium_dns() {
    title
    dns_list=("45.90.28.0,45.90.30.0" "94.140.14.14,94.140.15.15" "8.26.56.26,8.20.247.20")
    rand=$((RANDOM % ${#dns_list[@]}))
    primary=$(echo "${dns_list[$rand]}" | cut -d',' -f1)
    secondary=$(echo "${dns_list[$rand]}" | cut -d',' -f2)
    echo -e "💎 Premium DNS:"
    echo -e "🟢 Primary DNS: \033[32m$primary\033[0m"
    echo -e "🔵 Secondary DNS: \033[34m$secondary\033[0m"
    read -p "Press Enter to return..." _
    main_menu
}

main_menu
