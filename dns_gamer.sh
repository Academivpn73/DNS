#!/bin/bash

version="1.2.3"
admin="@MahdiAGM0"
telegram="@Academi_vpn"

# Title Colors Randomizer
colors=(31 32 33 34 35 36 91 92 93 94 95 96)
color=${colors[$RANDOM % ${#colors[@]}]}

function title() {
    clear
    echo -e "\e[1;${color}m"
    echo "██████╗ ███╗   ██╗███████╗    ██████╗ ███╗   ██╗███████╗██╗  ██╗"
    echo "██╔══██╗████╗  ██║██╔════╝    ██╔══██╗████╗  ██║██╔════╝██║  ██║"
    echo "██████╔╝██╔██╗ ██║█████╗      ██████╔╝██╔██╗ ██║█████╗  ███████║"
    echo "██╔═══╝ ██║╚██╗██║██╔══╝      ██╔═══╝ ██║╚██╗██║██╔══╝  ██╔══██║"
    echo "██║     ██║ ╚████║███████╗    ██║     ██║ ╚████║███████╗██║  ██║"
    echo "╚═╝     ╚═╝  ╚═══╝╚══════╝    ╚═╝     ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝"
    echo -e "\e[0m"
    echo -e "🔹 Version: $version    🔹 Admin: $admin"
    echo -e "📡 Telegram: $telegram"
    echo
}

function main_menu() {
    title
    echo -e "\033[1;32m[1]\033[0m Gaming DNS 🎮"
    echo -e "\033[1;32m[2]\033[0m Download DNS ⬇️"
    echo -e "\033[1;32m[3]\033[0m Ping DNS Test 📶"
    echo -e "\033[1;32m[4]\033[0m Premium DNS (Low Ping) 💎"
    echo -e "\033[1;32m[0]\033[0m Exit ❌"
    echo
    read -p "Select an option: " option
    case $option in
        1) gaming_dns ;;
        2) download_dns ;;
        3) ping_test ;;
        4) premium_dns ;;
        0) echo -e "\033[1;32mGoodbye 🙏🏻\033[0m"; exit ;;
        *) main_menu ;;
    esac
}

games=(
"Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
"Dota 2" "CS:GO" "Overwatch" "Apex Legends" "Minecraft"
"Roblox" "Rocket League" "Rainbow Six Siege" "Free Fire" "Genshin Impact"
"Warzone" "Battlefield" "Mobile Legends" "Arena Breakout" "Escape from Tarkov"
"FIFA" "eFootball" "Clash Royale" "Clash of Clans" "Brawl Stars"
"New World" "World of Warcraft" "Elden Ring" "Honkai Impact" "Cyberpunk 2077"
)

countries=("Germany" "Netherlands" "France" "UAE" "Turkey" "Iran")

function gaming_dns() {
    title
    echo "🎮 Select a game:"
    for i in "${!games[@]}"; do
        echo -e "\033[36m[$((i+1))]\033[0m ${games[$i]}"
    done
    echo -e "\033[36m[0]\033[0m Back"
    read -p "Choose a game: " game_choice
    [[ $game_choice == 0 ]] && main_menu
    selected_game="${games[$((game_choice-1))]}"
    title
    echo "🌍 Select a region for $selected_game:"
    for i in "${!countries[@]}"; do
        echo -e "\033[36m[$((i+1))]\033[0m ${countries[$i]}"
    done
    echo -e "\033[36m[0]\033[0m Back"
    read -p "Choose a region: " country_choice
    [[ $country_choice == 0 ]] && gaming_dns
    echo
    echo "🔐 DNS for $selected_game in ${countries[$((country_choice-1))]}:"
    dns_list=(
        "185.51.200.2"
        "1.1.1.1"
        "8.8.8.8"
        "185.55.225.25"
        "10.202.10.11"
        "156.154.70.2"
        "64.6.64.6"
        "208.67.222.222"
        "9.9.9.9"
    )
    random1=${dns_list[$RANDOM % ${#dns_list[@]}]}
    random2=${dns_list[$RANDOM % ${#dns_list[@]}]}
    echo -e "🟢 Primary: \033[1;32m$random1\033[0m"
    echo -e "🔵 Secondary: \033[1;34m$random2\033[0m"
    read -p "Press Enter to return..." enter
    main_menu
}

function download_dns() {
    title
    echo "🌍 Choose country for optimized download:"
    for i in "${!countries[@]}"; do
        echo -e "\033[36m[$((i+1))]\033[0m ${countries[$i]}"
    done
    echo -e "\033[36m[0]\033[0m Back"
    read -p "Choose a country: " d_choice
    [[ $d_choice == 0 ]] && main_menu
    echo
    echo "⬇️ Fast & Anti-Censorship DNS for ${countries[$((d_choice-1))]}:"
    list=(
        "10.202.10.10"
        "178.22.122.100"
        "156.154.71.2"
        "185.55.226.26"
        "208.67.220.200"
    )
    echo -e "🟢 Primary: \033[1;32m${list[$RANDOM % ${#list[@]}]}\033[0m"
    echo -e "🔵 Secondary: \033[1;34m${list[$RANDOM % ${#list[@]}]}\033[0m"
    read -p "Press Enter to return..." enter
    main_menu
}

function ping_test() {
    title
    read -p "🔍 Enter DNS to ping (e.g., 1.1.1.1): " dns
    echo "📡 Testing ping to $dns ..."
    ping -c 4 $dns
    read -p "Press Enter to return..." enter
    main_menu
}

function premium_dns() {
    title
    echo "💎 Premium Low-Ping DNS Providers:"
    prem_dns=(
        "5.2.75.75"
        "185.228.168.9"
        "94.140.14.14"
        "176.103.130.130"
        "45.90.28.0"
        "8.26.56.26"
    )
    echo -e "🟢 Primary: \033[1;32m${prem_dns[$RANDOM % ${#prem_dns[@]}]}\033[0m"
    echo -e "🔵 Secondary: \033[1;34m${prem_dns[$RANDOM % ${#prem_dns[@]}]}\033[0m"
    read -p "Press Enter to return..." enter
    main_menu
}

main_menu
