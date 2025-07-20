#!/bin/bash

clear

# Get base directory of the script to read files from the same folder
BASE_DIR="$(dirname "$(readlink -f "$0")")"

show_banner() {
    local text="Telegram: @Academi_vpn | Admin: Mahdi | Version: 1.2.4"
    local colors=(31 32 33 34 35 36)
    local color=${colors[$RANDOM % ${#colors[@]}]}
    echo -e "\e[1;${color}m+--------------------------------------------------+"
    echo -e "| ${text} |"
    echo -e "+--------------------------------------------------+\e[0m"
}

ping_dns() {
    local ip="$1"
    ping -c 1 -W 1 "$ip" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1
}

load_dns() {
    local game="$1"
    local country="$2"
    local dns_block=$(awk -v g="$game" -v c="$country" '
        BEGIN { RS="\n\n"; FS="\n" }
        tolower($1) ~ tolower("Game: " g) && tolower($2) ~ tolower("Country: " c) { print; exit }
    ' "$BASE_DIR/dns_gaming.txt")
    if [[ -z "$dns_block" ]]; then
        echo "❌ No DNS found for $game in $country"
        return
    fi
    local primary=$(echo "$dns_block" | grep "Primary:" | awk '{print $2}')
    local secondary=$(echo "$dns_block" | grep "Secondary:" | awk '{print $2}')
    local ping=$(ping_dns "$primary")
    echo "✅ Primary DNS  : $primary"
    echo "✅ Secondary DNS: $secondary"
    echo "📶 Ping         : ${ping:-timeout} ms"
}

load_bypass_dns() {
    local country="$1"
    local dns_block=$(awk -v c="$country" '
        BEGIN { RS="\n\n"; FS="\n" }
        tolower($1) ~ tolower("Country: " c) { print; exit }
    ' "$BASE_DIR/dns_bypass.txt")
    if [[ -z "$dns_block" ]]; then
        echo "❌ No Bypass DNS found for $country"
        return
    fi
    local primary=$(echo "$dns_block" | grep "Primary:" | awk '{print $2}')
    local secondary=$(echo "$dns_block" | grep "Secondary:" | awk '{print $2}')
    local ping=$(ping_dns "$primary")
    echo "✅ Primary DNS  : $primary"
    echo "✅ Secondary DNS: $secondary"
    echo "📶 Ping         : ${ping:-timeout} ms"
}

load_premium_dns() {
    local country="$1"
    local dns_block=$(awk -v c="$country" '
        BEGIN { RS="\n\n"; FS="\n" }
        tolower($1) ~ tolower("Country: " c) { print; exit }
    ' "$BASE_DIR/dns_premium.txt")
    if [[ -z "$dns_block" ]]; then
        echo "❌ No Premium DNS found for $country"
        return
    fi
    local primary=$(echo "$dns_block" | grep "Primary:" | awk '{print $2}')
    local secondary=$(echo "$dns_block" | grep "Secondary:" | awk '{print $2}')
    local ping=$(ping_dns "$primary")
    echo "✅ Primary DNS  : $primary"
    echo "✅ Secondary DNS: $secondary"
    echo "📶 Ping         : ${ping:-timeout} ms"
}

select_from_file() {
    local title="$1"
    local file="$2"
    echo "📋 $title"
    local i=1
    while IFS= read -r line; do
        echo "$i) $line"
        i=$((i + 1))
    done < "$file"
}

search_game_dns() {
    select_from_file "Select Game:" "$BASE_DIR/games.txt"
    read -p "Enter game number: " game_index
    game=$(sed -n "${game_index}p" "$BASE_DIR/games.txt")
    select_from_file "Select Country:" "$BASE_DIR/countries.txt"
    read -p "Enter country number: " country_index
    country=$(sed -n "${country_index}p" "$BASE_DIR/countries.txt")
    echo ""
    load_dns "$game" "$country"
}

search_bypass_dns() {
    select_from_file "Select Country for Bypass DNS:" "$BASE_DIR/countries.txt"
    read -p "Enter country number: " country_index
    country=$(sed -n "${country_index}p" "$BASE_DIR/countries.txt")
    echo ""
    load_bypass_dns "$country"
}

search_premium_dns() {
    select_from_file "Select Country for Premium DNS:" "$BASE_DIR/countries.txt"
    read -p "Enter country number: " country_index
    country=$(sed -n "${country_index}p" "$BASE_DIR/countries.txt")
    echo ""
    load_premium_dns "$country"
}

while true; do
    clear
    show_banner
    echo ""
    echo "1) Gaming DNS"
    echo "2) Bypass DNS"
    echo "3) Premium DNS"
    echo "4) Search Game DNS"
    echo "5) Ping a DNS"
    echo "0) Exit"
    echo ""
    read -p "> " option

    case $option in
        1)
            search_game_dns
            ;;
        2)
            search_bypass_dns
            ;;
        3)
            search_premium_dns
            ;;
        4)
            search_game_dns
            ;;
        5)
            read -p "Enter DNS to ping: " dns_ip
            result=$(ping_dns "$dns_ip")
            echo "Ping: ${result:-timeout} ms"
            ;;
        0)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
    echo ""
    read -p "Press enter to return to menu..."
done
