#!/bin/bash

# Author: @AcademiVPN
# Version: 1.0
# Language: English
# DNS Script with Premium, Ping, Game & Country Support

# Remote file URLs (replace with your GitHub raw URLs)
GAMES_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/games_list.txt"
COUNTRIES_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/countries_list.txt"
DNS_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_gaming.txt"

# Function to display the title
function show_title() {
    clear
    COLORS=(31 32 33 34 35 36)
    COLOR=${COLORS[$RANDOM % ${#COLORS[@]}]}
    echo -e "\e[1;${COLOR}m+------------------------------------------+"
    echo -e "| Telegram: @AcademiVPN                   |"
    echo -e "| Admin:    @MahdiAGM0                    |"
    echo -e "| Version:  1.0                           |"
    echo -e "+------------------------------------------+\e[0m"
    echo ""
}

# Function to fetch files online
function fetch_online_file() {
    curl -fsSL "$1"
}

# Function to ping DNS
function ping_dns() {
    read -p "Enter DNS IP: " dns_ip
    if [[ -z "$dns_ip" ]]; then
        echo "❌ Invalid IP"
    else
        ping_result=$(ping -c 1 "$dns_ip" | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')
        if [[ -z "$ping_result" ]]; then
            echo "❌ Ping failed"
        else
            echo "✅ Ping: ${ping_result}ms"
        fi
    fi
    read -p "Press Enter to return..."
}

# Function to show premium DNS
function show_premium_dns() {
    echo -e "\n🔥 Premium DNS:"
    for i in {1..2}; do
        ip=$(curl -s https://dnschecker.org/ping-test.php | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | shuf -n1)
        echo "$ip"
    done
    ping_dns
}

# Function to search game
function search_game() {
    echo "📱 Game Search:"
    games=$(fetch_online_file "$GAMES_URL")
    echo "$games" | nl -w2 -s') '
    echo ""
    read -p "Select game number: " game_num
    selected_game=$(echo "$games" | sed -n "${game_num}p")
    if [[ -z "$selected_game" ]]; then
        echo "❌ Game not found!"
        read -p "Press Enter to return..."
        return
    fi

    echo -e "\n🌍 Select Country:"
    countries=$(fetch_online_file "$COUNTRIES_URL")
    echo "$countries" | nl -w2 -s') '
    echo ""
    read -p "Select country number: " country_num
    selected_country=$(echo "$countries" | sed -n "${country_num}p")
    if [[ -z "$selected_country" ]]; then
        echo "❌ Country not found!"
        read -p "Press Enter to return..."
        return
    fi

    dns_data=$(fetch_online_file "$DNS_URL" | grep -A2 "$selected_game - $selected_country" | tail -n2)
    if [[ -z "$dns_data" ]]; then
        echo "❌ No DNS found for $selected_game - $selected_country"
    else
        echo -e "\n🎮 $selected_game - $selected_country"
        echo "$dns_data"
        ping_dns
    fi
    read -p "Press Enter to return..."
}

# Main menu
while true; do
    show_title
    echo "💠 Main Menu"
    echo "1) 🎮 Search Game (New)"
    echo "2) 🔥 Premium DNS (New)"
    echo "3) 📡 Ping DNS (New)"
    echo "4) ❌ Exit"
    read -p "Select an option: " choice
    case $choice in
        1) search_game ;;
        2) show_premium_dns ;;
        3) ping_dns ;;
        4) exit ;;
        *) echo "❌ Invalid option" && sleep 1 ;;
    esac
done
