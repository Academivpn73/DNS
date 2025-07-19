#!/bin/bash

# Colors
colors=("\e[1;31m" "\e[1;32m" "\e[1;33m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
reset="\e[0m"
cyan="\e[36m"
green="\e[32m"
blue="\e[34m"
red="\e[31m"
yellow="\e[33m"
magenta="\e[35m"

# Title Colors (random)
random_color="${colors[$RANDOM % ${#colors[@]}]}"

# Admin Info
admin="Admin: @MahdiAGM0"
telegram="Telegram: @Academi_vpn"

# Typing Animation Function
type_text() {
    text="$1"
    delay=0.003
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Title Box
print_title() {
    clear
    echo -e "${random_color}╭────────────────────────────────────────────╮${reset}"
    echo -e "${random_color}│         D N S   G A M I N G   M E N U      │${reset}"
    echo -e "${random_color}╰────────────────────────────────────────────╯${reset}"
    echo -e "${cyan}$telegram | $admin${reset}"
    echo ""
}

# DNS list per game
declare -A game_dns=(
["Call of Duty"]="1.1.1.1 1.0.0.1"
["PUBG Mobile"]="8.8.8.8 8.8.4.4"
["Arena Breakout"]="10.202.10.10 10.202.10.11"
["Free Fire"]="9.9.9.9 149.112.112.112"
["Apex Legends"]="185.51.200.2 178.22.122.100"
["Valorant"]="156.154.70.2 156.154.71.2"
# ... add up to 30+ games here ...
)

# Countries
countries=("UAE" "Qatar" "Saudi Arabia" "Turkey" "Oman" "Bahrain")

# Main Menu
main_menu() {
    print_title
    type_text "1) Gaming DNS 🎮"
    type_text "2) Download DNS ⬇️"
    type_text "3) Test Custom DNS 📶"
    type_text "4) Search Game DNS 🔍"
    type_text "0) Exit ❌"
    echo -ne "\nSelect an option: "; read opt
    case $opt in
        1) gaming_dns ;;
        2) download_dns ;;
        3) test_dns ;;
        4) search_game ;;
        0) echo -e "${green}Goodbye 🙏${reset}"; exit ;;
        *) echo -e "${red}Invalid option!${reset}"; sleep 1; main_menu ;;
    esac
}

# Gaming DNS
gaming_dns() {
    clear; print_title
    echo -e "${yellow}Select your game:${reset}"
    i=1
    for game in "${!game_dns[@]}"; do
        if [[ "$game" == "Arena Breakout" ]]; then
            echo -e "${blue}[$i] $game (New)${reset}"
        else
            echo -e "${cyan}[$i] $game${reset}"
        fi
        game_list[$i]="$game"
        ((i++))
    done
    echo -e "${red}[0] Back${reset}"
    echo -ne "\nSelect: "; read gopt
    if [[ $gopt == 0 ]]; then main_menu; fi
    selected_game="${game_list[$gopt]}"
    dns_data=(${game_dns["$selected_game"]})
    echo -e "\nPrimary DNS: ${green}${dns_data[0]}${reset}"
    echo -e "Secondary DNS: ${green}${dns_data[1]}${reset}"
    read -p "Press Enter to return..." ; main_menu
}

# Download DNS
download_dns() {
    clear; print_title
    echo -e "${yellow}Select your country:${reset}"
    for i in "${!countries[@]}"; do
        echo -e "${cyan}[$((i+1))] ${countries[$i]}${reset}"
    done
    echo -e "${red}[0] Back${reset}"
    echo -ne "\nSelect: "; read copt
    if [[ $copt == 0 ]]; then main_menu; fi
    selected_country="${countries[$((copt-1))]}"
    # Simulate real DNS - in future connect to actual API
    dns1="159.250.35.$((RANDOM%255))"
    dns2="156.154.70.$((RANDOM%255))"
    echo -e "\nDownload DNS for ${green}$selected_country${reset}:"
    echo -e "Primary: ${green}$dns1${reset}"
    echo -e "Secondary: ${green}$dns2${reset}"
    read -p "Press Enter to return..." ; main_menu
}

# Test DNS Ping
test_dns() {
    clear; print_title
    echo -ne "Enter DNS to test (e.g. 1.1.1.1): "; read ip
    echo -e "${yellow}Pinging $ip...${reset}"
    ping -c 4 $ip | tail -2
    read -p "Press Enter to return..." ; main_menu
}

# Search Game DNS
search_game() {
    clear; print_title
    echo -ne "Enter game name to search: "; read query
    found=0
    i=1
    for game in "${!game_dns[@]}"; do
        if [[ "$game" =~ $query ]]; then
            echo -e "${cyan}[$i] $game${reset}"
            game_search[$i]="$game"
            ((found++))
            ((i++))
        fi
    done
    if [[ $found -eq 0 ]]; then
        echo -e "${red}No game found.${reset}"
    else
        echo -ne "\nChoose to view DNS or 0 to return: "; read sel
        if [[ $sel == 0 ]]; then main_menu; fi
        gname="${game_search[$sel]}"
        echo -e "Primary: ${green}${game_dns["$gname"]%% *}${reset}"
        echo -e "Secondary: ${green}${game_dns["$gname"]#* }${reset}"
    fi
    read -p "Press Enter to return..." ; main_menu
}

main_menu
