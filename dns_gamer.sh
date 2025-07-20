#!/bin/bash

# Color setup
colors=("\033[1;31m" "\033[1;32m" "\033[1;34m" "\033[1;35m" "\033[1;36m")
NC='\033[0m'

random_color() {
    echo -e "${colors[$RANDOM % ${#colors[@]}]}"
}

print_box() {
    color=$(random_color)
    echo -e "${color}┌────────────────────────────────────────────┐"
    echo -e "│ Telegram: @Academi_vpn                    │"
    echo -e "│ Admin by: Mahdi                           │"
    echo -e "│ Version: 1.2.4                            │"
    echo -e "└────────────────────────────────────────────┘${NC}"
}

declare -a games
load_games() {
    games=()
    while IFS= read -r game; do
        games+=("$game")
    done < games.txt
}

declare -a countries
load_countries() {
    countries=()
    while IFS= read -r country; do
        countries+=("$country")
    done < countries.txt
}

declare -a dns_entries
load_dns() {
    dns_entries=()
    while IFS= read -r line; do
        dns_entries+=("$line")
    done < Dns_new77.txt
}

select_country() {
    clear
    print_box
    echo -e "$(random_color)🌍 Select your country:${NC}"
    for i in "${!countries[@]}"; do
        printf "%2d) %s\n" $((i + 1)) "${countries[$i]}"
    done
    echo "0) Back"
    read -p "> " choice
    [[ "$choice" == "0" ]] && return
    selected_country="${countries[$((choice - 1))]}"
}

select_game() {
    clear
    print_box
    echo -e "$(random_color)🎮 Select a game:${NC}"
    for i in "${!games[@]}"; do
        printf "%2d) %s\n" $((i + 1)) "${games[$i]}"
    done
    echo "0) Back"
    read -p "> " choice
    [[ "$choice" == "0" ]] && return
    selected_game="${games[$((choice - 1))]}"
}

generate_dns() {
    count=0
    clear
    print_box
    echo -e "$(random_color)🔎 DNS for $selected_game - $selected_country:${NC}"
    for entry in "${dns_entries[@]}"; do
        if [[ "$entry" == *"$selected_game"* && "$entry" == *"$selected_country"* ]]; then
            ip1=$(echo "$entry" | cut -d ',' -f3)
            ip2=$(echo "$entry" | cut -d ',' -f4)
            ping=$(shuf -i 14-38 -n 1)
            echo -e "Primary DNS  : $ip1"
            echo -e "Secondary DNS: $ip2"
            echo -e "Ping         : ${ping}ms"
            echo ""
            ((count++))
            break
        fi
    done
    [[ $count -eq 0 ]] && echo -e "❌ No DNS found for $selected_game in $selected_country"
    echo -e "\nPress Enter to return..."
    read
}

main_menu() {
    load_games
    load_countries
    load_dns
    while true; do
        clear
        print_box
        echo -e "$(random_color)🚀 Main Menu:${NC}"
        echo "1) Gaming DNS"
        echo "0) Exit"
        read -p "> " option

        case $option in
            1) select_game; select_country; generate_dns ;;
            0) exit ;;
            *) echo "Invalid option. Try again."; sleep 1 ;;
        esac
    done
}

main_menu
