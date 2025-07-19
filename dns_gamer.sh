#!/bin/bash

# Remote file URLs (replace with your own GitHub raw URLs)
GAMES_URL="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/games_list.txt"
COUNTRIES_URL="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/countries_list.txt"
DNS_URL="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/dns_data.txt"
PREMIUM_DNS_URL="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/premium_dns.txt"

# Download files to temp
GAMES_FILE=$(mktemp)
COUNTRIES_FILE=$(mktemp)
DNS_FILE=$(mktemp)
PREMIUM_DNS_FILE=$(mktemp)

curl -fsSL "$GAMES_URL" -o "$GAMES_FILE" || { echo "❌ Failed to load games list."; exit 1; }
curl -fsSL "$COUNTRIES_URL" -o "$COUNTRIES_FILE" || { echo "❌ Failed to load country list."; exit 1; }
curl -fsSL "$DNS_URL" -o "$DNS_FILE" || { echo "❌ Failed to load DNS data."; exit 1; }
curl -fsSL "$PREMIUM_DNS_URL" -o "$PREMIUM_DNS_FILE" || echo "⚠️ Premium DNS list not found."

# Main menu
main_menu() {
    clear
    echo "🎮 DNS Gaming Utility"
    echo "1) Get Gaming DNS"
    echo "2) Get Premium DNS"
    echo "3) Search Game"
    echo "4) Ping Custom DNS"
    echo "5) Exit"
    read -p "Choose option: " opt
    case $opt in
        1) get_gaming_dns ;;
        2) show_premium_dns ;;
        3) search_game ;;
        4) ping_dns ;;
        5) exit ;;
        *) echo "❌ Invalid choice."; sleep 1; main_menu ;;
    esac
}

get_gaming_dns() {
    echo "🎮 Game List:"
    cat -n "$GAMES_FILE"

    read -p "Enter game number: " game_num
    GAME=$(sed -n "${game_num}p" "$GAMES_FILE")
    [[ -z "$GAME" ]] && echo "❌ Invalid game selection." && return

    echo "🌍 Country List:"
    cat -n "$COUNTRIES_FILE"
    read -p "Enter country number: " country_num
    COUNTRY=$(sed -n "${country_num}p" "$COUNTRIES_FILE")
    [[ -z "$COUNTRY" ]] && echo "❌ Invalid country selection." && return

    echo "📡 Fetching DNS for $GAME - $COUNTRY..."
    MATCHES=$(grep -i "^$GAME|$COUNTRY|" "$DNS_FILE")
    if [[ -z "$MATCHES" ]]; then
        echo "❌ DNS not found for this game/country"
    else
        RANDOM_DNS=$(echo "$MATCHES" | shuf -n1)
        DNS1=$(echo "$RANDOM_DNS" | cut -d'|' -f3)
        DNS2=$(echo "$RANDOM_DNS" | cut -d'|' -f4)
        echo "🎯 DNS 1: $DNS1"
        echo "🎯 DNS 2: $DNS2"
        echo "📶 Pinging..."
        ping -c 1 "$DNS1" | grep 'time='
    fi
    read -p "Press enter to return..."
    main_menu
}

show_premium_dns() {
    echo "💎 Premium DNS List:"
    cat "$PREMIUM_DNS_FILE" | while read line; do
        DNS1=$(echo "$line" | cut -d'|' -f1)
        DNS2=$(echo "$line" | cut -d'|' -f2)
        PING=$(ping -c 1 "$DNS1" | grep 'time=' | awk -F"time=" '{print $2}' | awk '{print $1}')
        echo "🔹 $DNS1 | $DNS2 - Ping: $PING ms"
    done
    read -p "Press enter to return..."
    main_menu
}

search_game() {
    read -p "🔍 Enter game name to search: " query
    grep -i "$query" "$GAMES_FILE" | cat -n
    read -p "Press enter to return..."
    main_menu
}

ping_dns() {
    read -p "📡 Enter DNS IP to ping: " dns_ip
    ping -c 3 "$dns_ip"
    read -p "Press enter to return..."
    main_menu
}

# Start script
main_menu
