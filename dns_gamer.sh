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
    delay="${2:-0.0001}"
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
    fast_type_text "╔══════════════════════════════════════╗" 0.0001
    fast_type_text "║         DNS MANAGEMENT TOOL         ║" 0.0001
    fast_type_text "╠══════════════════════════════════════╣" 0.0001
    fast_type_text "║  Version: 1.2.4                      ║" 0.0001
    fast_type_text "║  Telegram: @Academi_vpn             ║" 0.0001
    fast_type_text "║  Admin: @MahdiAGM0                  ║" 0.0001
    fast_type_text "╚══════════════════════════════════════╝" 0.0001
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
        "Country: Iran | Primary: 10.202.10.10 | Secondary: 10.202.10.11"
        "Country: UAE | Primary: 185.51.200.2 | Secondary: 178.22.122.100"
        "Country: Turkey | Primary: 78.157.42.101 | Secondary: 78.157.42.100"
        "Country: Qatar | Primary: 64.6.64.6 | Secondary: 64.6.65.6"
        "Country: Saudi Arabia | Primary: 185.55.225.25 | Secondary: 185.55.226.26"
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

# Main Menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Console DNS (New)"
    echo -e "${blue}[3]${reset} Download DNS (Unblocker & Proxy)"
    echo -e "${blue}[4]${reset} Best DNS Finder (New)"
    echo -e "${blue}[5]${reset} Ping Custom DNS (New)"
    echo -e "${blue}[6]${reset} Search Game DNS (New)"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt
    case $opt in
      1) gaming_dns_menu ;;
      2) console_dns_menu ;;
      3) download_dns_menu ;;
      4) best_dns_menu ;;
      5) ping_custom_dns ;;  # placeholder
      6) search_game_dns ;;  # placeholder
      0) echo -e "${green}Goodbye 🙏🏻${reset}"; exit ;;
      *) echo -e "${red}Invalid input!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
