#!/bin/bash

# Title animation
function title() {
    colors=(31 32 33 34 35 36)
    color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "\e[1;${color}m"
    echo "==============================================="
    echo "     Premium DNS Tool - Fast & Optimized       "
    echo "     Telegram: @Academi_vpn | Version: 1.3     "
    echo "==============================================="
    echo -e "\e[0m"
}

# Function to get online file
get_file() {
    curl -s https://raw.githubusercontent.com/Academivpn73/DNS/main/$1
}

# Show list with numbers
show_list() {
    local list_content="$1"
    local type="$2"
    local index=1
    echo ""
    echo "📋 Select your $type:"
    while IFS= read -r line; do
        echo "$index) $line"
        ((index++))
    done <<< "$list_content"
}

# Ping a DNS address
ping_dns() {
    dns=$1
    result=$(ping -c 1 -W 1 "$dns" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    echo "${result:-Timeout}"
}

# Select game and country
select_game_country() {
    games=$(get_file games_list.txt)
    countries=$(get_file countries_list.txt)
    
    show_list "$games" "game"
    read -p "Choose game number: " game_num
    game_name=$(echo "$games" | sed -n "${game_num}p")

    show_list "$countries" "country"
    read -p "Choose country number: " country_num
    country_name=$(echo "$countries" | sed -n "${country_num}p")

    dns_data=$(get_file dns_data.txt)

    match=$(echo "$dns_data" | grep -i "$game_name - $country_name" | shuf -n 1)
    if [ -n "$match" ]; then
        dns1=$(echo "$match" | cut -d',' -f2)
        dns2=$(echo "$match" | cut -d',' -f3)
        echo ""
        echo "🎮 $game_name - $country_name"
        echo "DNS 1: $dns1 | Ping: $(ping_dns $dns1)ms"
        echo "DNS 2: $dns2 | Ping: $(ping_dns $dns2)ms"
    else
        echo "⚠️  No DNS found for this game and country."
    fi
    echo ""
    read -p "Press Enter to return..."
}

# Premium DNS random
show_premium_dns() {
    dns_data=$(get_file dns_data.txt)
    match=$(echo "$dns_data" | grep -i "PREMIUM" | shuf -n 1)
    dns1=$(echo "$match" | cut -d',' -f2)
    dns2=$(echo "$match" | cut -d',' -f3)
    echo ""
    echo "💎 Premium DNS:"
    echo "DNS 1: $dns1 | Ping: $(ping_dns $dns1)ms"
    echo "DNS 2: $dns2 | Ping: $(ping_dns $dns2)ms"
    echo ""
    read -p "Press Enter to return..."
}

# Download DNS
show_download_dns() {
    dns_data=$(get_file dns_data.txt)
    match=$(echo "$dns_data" | grep -i "DOWNLOAD" | shuf -n 1)
    dns1=$(echo "$match" | cut -d',' -f2)
    dns2=$(echo "$match" | cut -d',' -f3)
    echo ""
    echo "⬇️  Download Optimized DNS:"
    echo "DNS 1: $dns1 | Ping: $(ping_dns $dns1)ms"
    echo "DNS 2: $dns2 | Ping: $(ping_dns $dns2)ms"
    echo ""
    read -p "Press Enter to return..."
}

# Ping specific DNS entered by user
ping_custom_dns() {
    read -p "Enter DNS to ping: " user_dns
    result=$(ping_dns "$user_dns")
    echo "Ping to $user_dns: $result ms"
    echo ""
    read -p "Press Enter to return..."
}

# Search game
search_game() {
    read -p "Enter game name to search: " search_query
    games=$(get_file games_list.txt)
    matched=$(echo "$games" | grep -i "$search_query")

    if [ -z "$matched" ]; then
        echo "⚠️  Game not found."
    else
        echo "🔍 Found: $matched"
        countries=$(get_file countries_list.txt)
        show_list "$countries" "country"
        read -p "Choose country number: " country_num
        country_name=$(echo "$countries" | sed -n "${country_num}p")

        dns_data=$(get_file dns_data.txt)
        match=$(echo "$dns_data" | grep -i "$matched - $country_name" | shuf -n 1)

        if [ -n "$match" ]; then
            dns1=$(echo "$match" | cut -d',' -f2)
            dns2=$(echo "$match" | cut -d',' -f3)
            echo ""
            echo "🎮 $matched - $country_name"
            echo "DNS 1: $dns1 | Ping: $(ping_dns $dns1)ms"
            echo "DNS 2: $dns2 | Ping: $(ping_dns $dns2)ms"
        else
            echo "⚠️  No DNS found for this selection."
        fi
    fi
    echo ""
    read -p "Press Enter to return..."
}

# Main menu
while true; do
    title
    echo "1) 🎮 Gaming DNS"
    echo "2) ⬇️  Download DNS"
    echo "3) 💎 Premium DNS"
    echo "4) 📶 Ping a DNS"
    echo "5) 🔍 Search Game"
    echo "0) ❌ Exit"
    echo ""
    read -p "Select an option: " choice

    case $choice in
        1) select_game_country ;;
        2) show_download_dns ;;
        3) show_premium_dns ;;
        4) ping_custom_dns ;;
        5) search_game ;;
        0) echo "Exiting..."; exit ;;
        *) echo "Invalid choice." ;;
    esac
done
