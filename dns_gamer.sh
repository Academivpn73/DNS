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

# Typing animation (faster)
fast_type_text() {
    text="$1"
    delay="${2:-0.00005}"
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
    fast_type_text "╔══════════════════════════════════════╗" 0.00005
    fast_type_text "║         DNS MANAGEMENT TOOL         ║" 0.00005
    fast_type_text "╠══════════════════════════════════════╣" 0.00005
    fast_type_text "║  Version: 1.2.4                      ║" 0.00005
    fast_type_text "║  Telegram: @Academi_vpn             ║" 0.00005
    fast_type_text "║  Admin: @MahdiAGM0                  ║" 0.00005
    fast_type_text "╚══════════════════════════════════════╝" 0.00005
    echo -e "${reset}"
}

# Placeholder function for new features
console_dns_menu() {
    clear
    echo -e "${bold}${green}Console DNS Section (New)${reset}"
    echo -e "[Under development: will list 50 console games with random DNS for each + Middle East countries]"
    echo -ne "\n${green}Press Enter to return...${reset}"; read
}

download_dns_menu() {
    clear
    echo -e "${bold}${green}Download DNS (Unblocker)${reset}"
    dns_list=(
        "Country: Iran | Primary DNS: 10.202.10.10 | Secondary DNS: 10.202.10.11 | Ping: 20ms"
        "Country: UAE | Primary DNS: 185.51.200.2 | Secondary DNS: 178.22.122.100 | Ping: 25ms"
        "Country: Turkey | Primary DNS: 78.157.42.101 | Secondary DNS: 78.157.42.100 | Ping: 30ms"
        "Country: Qatar | Primary DNS: 64.6.64.6 | Secondary DNS: 64.6.65.6 | Ping: 28ms"
        "Country: Saudi Arabia | Primary DNS: 185.55.225.25 | Secondary DNS: 185.55.226.26 | Ping: 27ms"
        "Country: Bahrain | Primary DNS: 162.159.24.1 | Secondary DNS: 162.159.25.1 | Ping: 26ms"
        "Country: Oman | Primary DNS: 149.112.112.112 | Secondary DNS: 149.112.112.113 | Ping: 29ms"
        "Country: Kuwait | Primary DNS: 208.67.222.222 | Secondary DNS: 208.67.220.220 | Ping: 22ms"
        "Country: Lebanon | Primary DNS: 1.1.1.1 | Secondary DNS: 1.0.0.1 | Ping: 31ms"
        "Country: Jordan | Primary DNS: 8.8.8.8 | Secondary DNS: 8.8.4.4 | Ping: 30ms"
    )
    for dns in "${dns_list[@]}"; do
        echo -e "${cyan}$dns${reset}"
    done
    echo -ne "\n${green}Press Enter to return...${reset}"; read
}

best_dns_menu() {
    clear
    echo -e "${bold}${green}Best DNS Finder (New)${reset}"
    echo -e "[Under development: Will automatically select the fastest DNS based on your location]"
    echo -ne "\n${green}Press Enter to return...${reset}"; read
}

ping_custom_dns() {
    clear
    echo -e "${bold}${green}Ping Custom DNS (New)${reset}"
    echo -ne "Enter DNS IP: "
    read dns_ip
    if [[ -z "$dns_ip" ]]; then
        echo -e "${red}No DNS entered!${reset}"
        sleep 1
        return
    fi
    ping_result=$(ping -c 4 -W 1 "$dns_ip" 2>/dev/null | tail -1 | awk -F '/' '{print $5}')
    if [[ -z "$ping_result" ]]; then
        echo -e "${red}Ping Timeout or failed${reset}"
    else
        echo -e "DNS: ${dns_ip}\nPing: ${ping_result} ms"
    fi
    echo -ne "\n${green}Press Enter to return...${reset}"; read
}

search_game_dns() {
    clear
    echo -e "${bold}${green}Search Game DNS (New)${reset}"
    echo -ne "Enter game name: "
    read game_name
    # Placeholder - should search dns by game_name
    echo -e "Searching DNS for game: $game_name"
    echo -ne "\n${green}Press Enter to return...${reset}"; read
}

# Gaming DNS menu with new games + Arena Breakout (with colors)
gaming_dns_menu() {
    clear
    echo -e "${bold}${green}Gaming DNS List${reset}"
    declare -A games_dns
    games_dns=(
        ["League of Legends"]="1.1.1.1 1.0.0.1"
        ["Fortnite"]="8.8.8.8 8.8.4.4"
        ["Valorant"]="9.9.9.9 149.112.112.112"
        ["Minecraft"]="208.67.222.222 208.67.220.220"
        ["Call of Duty"]="64.6.64.6 64.6.65.6"
        ["Arena Breakout"]="${red}New${reset} 84.17.72.72 84.17.72.73"
        ["GTA IV"]="${red}New${reset} 8.8.8.8 8.8.4.4"
        ["The Finals"]="${red}New${reset} 1.1.1.1 1.0.0.1"
        ["Stalker 2"]="${red}New${reset} 162.159.24.1 162.159.25.1"
        ["Modern Warfare III"]="${red}New${reset} 149.112.112.112 149.112.112.113"
        ["XDefiant"]="${red}New${reset} 208.67.222.222 208.67.220.220"
        ["Hyper Front"]="${red}New${reset} 64.6.64.6 64.6.65.6"
        ["Naraka Bladepoint"]="${red}New${reset} 8.8.8.8 8.8.4.4"
        ["Starfield"]="${red}New${reset} 1.1.1.1 1.0.0.1"
        ["Blue Protocol"]="${red}New${reset} 162.159.24.1 162.159.25.1"
    )
    i=1
    for game in "${!games_dns[@]}"; do
        # Mark new games with orange "(New)" after name
        if [[ "$game" == "Arena Breakout" || "$game" == "GTA IV" || "$game" == "The Finals" || "$game" == "Stalker 2" || "$game" == "Modern Warfare III" || "$game" == "XDefiant" || "$game" == "Hyper Front" || "$game" == "Naraka Bladepoint" || "$game" == "Starfield" || "$game" == "Blue Protocol" ]]; then
            echo -e "[${i}] ${red}${game}${reset} ${orange}(New)${reset}"
        else
            echo -e "[${i}] ${game}"
        fi
        ((i++))
    done
    echo -ne "\n${green}Press Enter to return...${reset}"; read
}

main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Console DNS ${orange}(New)${reset}"
    echo -e "${blue}[3]${reset} Download DNS ${orange}(New)${reset}"
    echo -e "${blue}[4]${reset} Best DNS Finder ${orange}(New)${reset}"
    echo -e "${blue}[5]${reset} Ping Custom DNS ${orange}(New)${reset}"
    echo -e "${blue}[6]${reset} Search Game DNS ${orange}(New)${reset}"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt
    case $opt in
      1) gaming_dns_menu ;;
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
