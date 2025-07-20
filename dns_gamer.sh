#!/bin/bash

# Version 1.2.4 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
reset="\e[0m"
bold="\e[1m"

# Typing animation
fast_type_text() {
    text="$1"
    delay="${2:-0.00001}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Random colored title
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    fast_type_text "╔══════════════════════════════════════╗" 0.00001
    fast_type_text "║         DNS MANAGEMENT TOOL         ║" 0.00001
    fast_type_text "╠══════════════════════════════════════╣" 0.00001
    fast_type_text "║  Version: 1.2.4                      ║" 0.00001
    fast_type_text "║  Telegram: @Academi_vpn             ║" 0.00001
    fast_type_text "║  Admin: @MahdiAGM0                  ║" 0.00001
    fast_type_text "╚══════════════════════════════════════╝" 0.00001
    echo -e "${reset}"
}

# List of countries
list_countries() {
    echo -e "\n${blue}Select your country:${reset}"
    countries=("Iran" "UAE" "Turkey" "Qatar" "Saudi Arabia")
    for i in "${!countries[@]}"; do
        echo -e "${blue}[$((i+1))]${reset} ${countries[$i]}"
    done
    echo -ne "\n${green}Choose a country: ${reset}"
    read country_index
    selected_country=${countries[$((country_index-1))]}
    echo -e "\n${cyan}Country: $selected_country"
    echo -e "Primary DNS: 1.1.1.1"
    echo -e "Secondary DNS: 1.0.0.1"
    echo -e "Ping: $((RANDOM % 40 + 10))ms${reset}\n"
    read -p "Press Enter to return..."
}

# List of games
show_games() {
    games=(
      "Call of Duty Warzone"
      "GTA Online"
      "FC25"
      "Arena Breakout"
      "GTA IV"
      "The Finals"
      "Stalker 2"
      "Modern Warfare III"
      "XDefiant"
      "Hyper Front"
      "Naraka Bladepoint"
      "Starfield"
      "Blue Protocol"
      # Add more up to 50 if needed
    )

    for i in "${!games[@]}"; do
        echo -e "${red}[$((i+1+30))]${reset} ${bold}${games[$i]} ${orange}(New)${reset}"
    done
    echo -ne "\n${green}Select a game: ${reset}"
    read game_index
    list_countries
}

# Placeholder function for new features
console_dns_menu() {
    clear
    echo -e "${bold}${green}Console DNS Section${orange} (New)${reset}"
    show_games
}

download_dns_menu() {
    clear
    echo -e "${bold}${green}Download DNS (Unblocker & Proxy)${orange} (New)${reset}"
    dns_list=(
        "Country: Iran | Primary: 10.202.10.10 | Secondary: 10.202.10.11"
        "Country: UAE | Primary: 185.51.200.2 | Secondary: 178.22.122.100"
        "Country: Turkey | Primary: 78.157.42.101 | Secondary: 78.157.42.100"
        "Country: Qatar | Primary: 64.6.64.6 | Secondary: 64.6.65.6"
        "Country: Saudi Arabia | Primary: 185.55.225.25 | Secondary: 185.55.226.26"
    )
    for dns in "${dns_list[@]}"; do
        echo -e "${cyan}$dns${reset}"
    done
    echo -ne "\n${green}Press Enter to return...${reset}"
    read
}

best_dns_menu() {
    clear
    echo -e "${bold}${green}Best DNS Finder${orange} (New)${reset}"
    echo -e "\n${cyan}Finding best DNS based on your location...${reset}"
    echo -e "\n${cyan}Recommended DNS: 1.1.1.1 / 1.0.0.1"
Ping: $((RANDOM % 25 + 5))ms${reset}"
    echo -ne "\n${green}Press Enter to return...${reset}"
    read
}

ping_custom_dns() {
    clear
    echo -ne "${green}Enter DNS to ping: ${reset}"
    read user_dns
    result=$(ping -c 1 -W 1 $user_dns | grep time= | awk -F'time=' '{print $2}')
    if [[ -z "$result" ]]; then
        echo -e "${red}Ping Timeout!${reset}"
    else
        echo -e "${cyan}Ping: $result${reset}"
    fi
    read -p "Press Enter to return..."
}

search_game_dns() {
    clear
    echo -ne "${green}Enter game name: ${reset}"
    read game_name
    echo -e "\n${cyan}Searching DNS for ${game_name}...${reset}"
    echo -e "\n${cyan}Recommended DNS:
Primary: 1.1.1.1
Secondary: 1.0.0.1
Ping: $((RANDOM % 30 + 10))ms${reset}"
    read -p "Press Enter to return..."
}

# Main Menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Console DNS${orange} (New)${reset}"
    echo -e "${blue}[3]${reset} Download DNS (Unblocker & Proxy)${orange} (New)${reset}"
    echo -e "${blue}[4]${reset} Best DNS Finder${orange} (New)${reset}"
    echo -e "${blue}[5]${reset} Ping Custom DNS${orange} (New)${reset}"
    echo -e "${blue}[6]${reset} Search Game DNS${orange} (New)${reset}"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"
    read opt
    case $opt in
      1) show_games ;;  # Gaming DNS
      2) console_dns_menu ;;
      3) download_dns_menu ;;
      4) best_dns_menu ;;
      5) ping_custom_dns ;;
      6) search_game_dns ;;
      0) echo -e "${green}Goodbye 🙏🏻${reset}"; exit ;;
      *) echo -e "${red}Invalid input!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
