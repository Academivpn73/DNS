#!/bin/bash

# Set file sources (online URLs - you can host these on GitHub)
GAMES_URL="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/games_list.txt"
COUNTRIES_URL="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/countries_list.txt"
DNS_DATA_URL="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/dns_data.txt"

# Title with changing color
colors=(31 32 33 34 35 36)
color_index=0

title() {
    clear
    echo ""
    echo -e "\e[1;${colors[$color_index]}m+----------------------------------------+"
    echo -e "|  Telegram: @Academi_vpn                |"
    echo -e "|  Admin:    @MahdiAGM0                  |"
    echo -e "|  Version:  2.0.0                       |"
    echo -e "+----------------------------------------+\e[0m"
    echo ""
    color_index=$(( (color_index + 1) % ${#colors[@]} ))
}

# Download list files if not present
download_files() {
    curl -s -o games_list.txt "$GAMES_URL"
    curl -s -o countries_list.txt "$COUNTRIES_URL"
    curl -s -o dns_data.txt "$DNS_DATA_URL"
}

# Show game list
select_game() {
    echo -e "🎮 Select Game:\n"
    cat games_list.txt
    echo -ne "\nEnter number: "
    read game_number
    game=$(sed "${game_number}q;d" games_list.txt)
}

# Show country list
select_country() {
    echo -e "\n🌍 Select Country:\n"
    cat countries_list.txt
    echo -ne "\nEnter number: "
    read country_number
    country=$(sed "${country_number}q;d" countries_list.txt)
}

# Get DNS for game + country
get_dns() {
    match=$(grep -i "${game}-${country}" dns_data.txt | shuf -n 1)
    if [[ -z "$match" ]]; then
        echo -e "\n❌ DNS not found for this game/country."
    else
        dns1=$(echo "$match" | cut -d'|' -f2)
        dns2=$(echo "$match" | cut -d'|' -f3)
        ping=$(ping -c 1 -W 1 "$dns1" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
        echo -e "\n🎮 $game - $country"
        echo -e "Primary DNS: $dns1"
        echo -e "Secondary DNS: $dns2"
        echo -e "Ping: ${ping:-Unknown}"
    fi
    read -p $'\nPress Enter to return...'
}

# Premium DNS section
premium_dns() {
    dns_entry=$(grep "premium" dns_data.txt | shuf -n 1)
    dns1=$(echo "$dns_entry" | cut -d'|' -f2)
    dns2=$(echo "$dns_entry" | cut -d'|' -f3)
    ping=$(ping -c 1 -W 1 "$dns1" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    echo -e "\n🌐 Premium DNS"
    echo -e "Primary DNS: $dns1"
    echo -e "Secondary DNS: $dns2"
    echo -e "Ping: ${ping:-Unknown}"
    read -p $'\nPress Enter to return...'
}

# Ping DNS
ping_dns() {
    read -p "Enter a DNS to ping: " input_dns
    ping_result=$(ping -c 1 -W 1 "$input_dns" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    echo -e "Ping: ${ping_result:-Unknown}"
    read -p $'\nPress Enter to return...'
}

# Search Game
search_game() {
    read -p "Enter game name to search: " search
    match_line=$(grep -in "$search" games_list.txt)
    if [[ -z "$match_line" ]]; then
        echo -e "\n⚠️ Game not found!"
    else
        echo -e "\n✅ Found Game:"
        echo "$match_line"
    fi
    read -p $'\nPress Enter to return...'
}

# Main Menu
main_menu() {
    while true; do
        title
        echo "Choose an option:"
        echo "1) 🎮 Gaming DNS"
        echo "2) ⬇️  Download DNS"
        echo "3) 🌐 Premium DNS"
        echo "4) 📶 Ping a DNS"
        echo "5) 🔍 Search Game"
        echo "0) ❌ Exit"
        echo ""
        read -p "Enter number: " choice

        case $choice in
            1)
                select_game
                select_country
                get_dns
                ;;
            2)
                game="Download"
                select_country
                get_dns
                ;;
            3) premium_dns ;;
            4) ping_dns ;;
            5) search_game ;;
            0) exit ;;
            *) echo -e "\n❌ Invalid Option\n"; sleep 1 ;;
        esac
    done
}

# Run all
download_files
main_menu
