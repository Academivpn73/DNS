#!/bin/bash

version="1.2.0"
admin="@MahdiAGM0"
channel="@Academi_vpn"

# Clear & Title
clear
echo -e "\e[1;36m═══════════════════════════════════════════════"
echo -e "\e[1;32m          🔥 Mahdi DNS Panel 🔥"
echo -e "\e[1;36m═══════════════════════════════════════════════"
echo -e "\e[1;33mTelegram:\e[0m $channel"
echo -e "\e[1;33mAdmin:\e[0m $admin"
echo -e "\e[1;31mVersion:\e[0m $version"
echo -e "\e[1;36m═══════════════════════════════════════════════"

# Country List (Middle East Sample)
countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Iraq" "Qatar" "Jordan" "Oman" "Kuwait" "Lebanon")

# Sample Game List (Partial)
games=(
"Call of Duty Mobile (Mobile)"
"PUBG Mobile (Mobile)"
"Free Fire (Mobile)"
"Clash Royale (Mobile)"
"Mobile Legends (Mobile)"
"Fortnite (PC)"
"Valorant (PC)"
"League of Legends (PC)"
"CS:GO (PC)"
"Dota 2 (PC)"
"Apex Legends (PC)"
"Rainbow Six Siege (PC)"
"GTA Online (PC)"
"Overwatch 2 (PC)"
"FIFA 24 (PC)"
"Rocket League (PC)"
"Roblox (PC)"
"Minecraft (PC)"
"Warzone (Console)"
"FIFA 24 (Console)"
"Fortnite (Console)"
"Apex Legends (Console)"
"Call of Duty MW3 (Console)"
"Genshin Impact (Mobile)"
"eFootball 2024 (Mobile)"
"Dead by Daylight (Console)"
"Battlefield V (PC)"
"Halo Infinite (Console)"
"World of Tanks (Console)"
"Paladins (PC)"
"Naruto Blazing (Mobile)"
"Pokemon Unite (Mobile)"
"Brawl Stars (Mobile)"
"Diablo Immortal (Mobile)"
"Black Desert (PC)"
"Elden Ring (Console)"
"Cyberpunk 2077 (PC)"
"ARK Survival (PC)"
"NBA 2K24 (Console)"
)

# DNS Sample Pool
declare -A dns_map
dns_map["Iran"]="178.22.122.100 185.51.200.2 10.202.10.10 10.202.10.11 78.157.42.100"
dns_map["Turkey"]="193.140.100.100 195.175.39.39 212.156.4.20"
dns_map["UAE"]="194.170.1.6 194.170.1.7 217.165.128.6"
dns_map["Saudi Arabia"]="212.26.18.41 212.26.18.42"
dns_map["Iraq"]="185.125.170.12 185.125.170.11"
dns_map["Qatar"]="212.77.192.1 212.77.192.2"
dns_map["Jordan"]="195.112.184.4 195.112.184.5"
dns_map["Oman"]="212.72.1.6 212.72.1.8"
dns_map["Kuwait"]="62.150.20.20 62.150.20.21"
dns_map["Lebanon"]="195.112.195.20 195.112.195.21"

# Function to show DNS list
show_dns_list() {
    local country="$1"
    local all_dns=(${dns_map[$country]})
    echo -e "\n\e[1;36mFetching DNS for $country...\e[0m"
    count=1
    for dns in "${all_dns[@]}"; do
        ping_time=$(ping -c 1 -W 1 $dns | grep 'time=' | cut -d'=' -f4 | cut -d' ' -f1)
        if [[ -z "$ping_time" ]]; then
            ping_time="N/A"
        fi
        echo -e "\e[1;33mDNS $count:\e[0m $dns \e[1;32m(Ping: $ping_time ms)\e[0m"
        count=$((count+1))
        if [[ $count -gt 15 ]]; then
            break
        fi
    done
}

# Menu Loop
while true; do
    echo -e "\n\e[1;36mSelect an option:\e[0m"
    echo -e "\e[1;32m1)\e[0m Gaming DNS"
    echo -e "\e[1;34m2)\e[0m Download DNS"
    echo -e "\e[1;31m0)\e[0m Exit"
    read -p "Enter choice: " choice

    case $choice in
        1)
            echo -e "\n\e[1;36mSelect a game:\e[0m"
            i=1
            for game in "${games[@]}"; do
                echo -e "\e[1;35m$i)\e[0m $game"
                ((i++))
            done
            read -p "Game number: " gnum
            selected_game="${games[$((gnum-1))]}"
            echo -e "\n\e[1;36mSelect a country:\e[0m"
            c=1
            for country in "${countries[@]}"; do
                echo -e "\e[1;33m$c)\e[0m $country"
                ((c++))
            done
            read -p "Country number: " cnum
            selected_country="${countries[$((cnum-1))]}"
            echo -e "\n\e[1;32mSelected Game:\e[0m $selected_game"
            echo -e "\e[1;34mSelected Country:\e[0m $selected_country"
            show_dns_list "$selected_country"
            read -p $'\nPress Enter to return to menu...'
            ;;
        2)
            echo -e "\n\e[1;36mSelect a country for download DNS:\e[0m"
            d=1
            for country in "${countries[@]}"; do
                echo -e "\e[1;36m$d)\e[0m $country"
                ((d++))
            done
            read -p "Country number: " dnum
            selected_country="${countries[$((dnum-1))]}"
            echo -e "\n\e[1;34mSelected Country:\e[0m $selected_country"
            show_dns_list "$selected_country"
            read -p $'\nPress Enter to return to menu...'
            ;;
        0)
            echo -e "\e[1;33mGoodbye. Follow our channel on Telegram to see more updates and scripts.\e[0m"
            echo -e "\e[1;33m@Academi_vpn\e[0m"
            exit 0
            ;;
        *)
            echo -e "\e[1;31mInvalid option!\e[0m"
            ;;
    esac
done
