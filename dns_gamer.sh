#!/bin/bash

# Auto-fetch files if not exist
[[ ! -f "dns_list.txt" ]] && curl -fsSLO https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_list.txt
[[ ! -f "games_list.txt" ]] && curl -fsSLO https://raw.githubusercontent.com/Academivpn73/DNS/main/games_list.txt

# Clear screen
clear

# Function: Show title
show_title() {
    clear
    colors=(31 32 33 34 35 36)
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    echo -e "\e[1;${rand_color}m+------------------------------------------+"
    echo -e "|       DNS Tool | Version: 1.2.3           |"
    echo -e "| Telegram: @Academi_vpn                   |"
    echo -e "| Admin:    @MahdiAGM0                     |"
    echo -e "+------------------------------------------+\e[0m"
    echo ""
}

# Function: Show main menu
main_menu() {
    show_title
    echo "🔹 Choose an option:"
    echo "1. 🎮 Gaming DNS"
    echo "2. ⬇️  Download DNS"
    echo "3. 💎 Premium DNS (New)"
    echo "4. 📶 Ping a DNS (New)"
    echo "5. 🔍 Search Game (New)"
    echo "6. ❌ Exit"
    echo ""
    read -p "Enter your choice: " choice
    case $choice in
        1) dns_gaming ;;
        2) dns_download ;;
        3) premium_dns ;;
        4) ping_dns ;;
        5) search_game ;;
        6) exit 0 ;;
        *) echo "❌ Invalid choice."; sleep 1; main_menu ;;
    esac
}

# Function: DNS for gaming
dns_gaming() {
    show_title
    echo "📱 Game List:"
    nl -w2 -s'. ' games_list.txt
    echo ""
    read -p "Choose game number: " game_number
    selected_game=$(sed -n "${game_number}p" games_list.txt)
    echo ""
    echo "🌍 Select Region:"
    echo "1. Iran"
    echo "2. UAE"
    echo "3. Turkey"
    echo "4. Other"
    read -p "Region number: " region

    # Random DNS from file
    dns=$(shuf -n 2 dns_list.txt)
    echo ""
    echo "Recommended DNS for $selected_game:"
    echo -e "🟢 Primary DNS: $(echo "$dns" | sed -n 1p)"
    echo -e "🟢 Secondary DNS: $(echo "$dns" | sed -n 2p)"
    echo ""
    read -p "Press Enter to return..." 
    main_menu
}

# Function: DNS for downloads
dns_download() {
    show_title
    echo "🌍 Select Region:"
    echo "1. Iran"
    echo "2. UAE"
    echo "3. Turkey"
    echo "4. Other"
    read -p "Region number: " region

    dns=$(shuf -n 2 dns_list.txt)
    echo ""
    echo "Recommended DNS for Download:"
    echo -e "🟢 Primary DNS: $(echo "$dns" | sed -n 1p)"
    echo -e "🟢 Secondary DNS: $(echo "$dns" | sed -n 2p)"
    echo ""
    read -p "Press Enter to return..."
    main_menu
}

# Function: Premium DNS
premium_dns() {
    show_title
    dns=$(shuf -n 2 dns_list.txt)
    echo "💎 Premium DNS:"
    echo -e "🟢 Primary DNS: $(echo "$dns" | sed -n 1p)"
    echo -e "🟢 Secondary DNS: $(echo "$dns" | sed -n 2p)"
    echo ""
    read -p "Press Enter to return..."
    main_menu
}

# Function: Ping DNS
ping_dns() {
    show_title
    read -p "Enter DNS to ping: " user_dns
    ping_result=$(ping -c 1 "$user_dns" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [ -n "$ping_result" ]; then
        echo "📶 Ping: ${ping_result} ms"
    else
        echo "❌ Ping failed."
    fi
    echo ""
    read -p "Press Enter to return..."
    main_menu
}

# Function: Search Game
search_game() {
    show_title
    read -p "🔍 Enter game name: " search
    result=$(grep -i "$search" games_list.txt)
    if [ -z "$result" ]; then
        echo -e "\e[33m⚠️  Game not found.\e[0m"
    else
        echo "🎯 Found: $result"
        echo ""
        echo "🌍 Choose Region:"
        echo "1. Iran"
        echo "2. UAE"
        echo "3. Turkey"
        echo "4. Other"
        read -p "Region number: " region
        dns=$(shuf -n 2 dns_list.txt)
        echo ""
        echo "Recommended DNS for $result:"
        echo -e "🟢 Primary DNS: $(echo "$dns" | sed -n 1p)"
        echo -e "🟢 Secondary DNS: $(echo "$dns" | sed -n 2p)"
    fi
    echo ""
    read -p "Press Enter to return..."
    main_menu
}

# Start program
main_menu
