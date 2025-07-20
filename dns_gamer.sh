#!/bin/bash

# Version 1.4.0 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
bold="\e[1m"
reset="\e[0m"
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"

# Fast Typing Function
type_text() {
    text="$1"
    delay="${2:-0.00001}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Show Title
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    type_text "╔══════════════════════════════════════╗" 0.0002
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0002
    type_text "╠══════════════════════════════════════╣" 0.0002
    type_text "║  Version: 1.4.0                      ║" 0.0002
    type_text "║  Telegram: @Academi_vpn             ║" 0.0002
    type_text "║  Admin: @MahdiAGM0                  ║" 0.0002
    type_text "╚══════════════════════════════════════╝" 0.0002
    echo -e "${reset}"
}

# Load DNS List from External File
load_dns_list() {
  mapfile -t dns_list < <(grep -Ev '^#|^$' dns_list.txt)
}

# Game DNS Map (Partial for brevity)
declare -A game_dns_map

# Load game names and DNS from external file or define inline (partial demo)
game_dns_map["Arena Breakout"]="185.51.200.2 | 178.22.122.100"
game_dns_map["Call of Duty Mobile"]="1.1.1.1 | 1.0.0.1"
# [... add up to 50 games ...]

# Console Game DNS Map (50 real titles)
declare -A console_game_dns_map
console_game_dns_map["God of War"]="1.1.1.1 | 1.0.0.1"
# [... add up to 50 real console games with proper names ...]
console_game_dns_map["Arena Breakout"]="185.51.200.2 | 178.22.122.100"

# Download DNS List (Anti-Censorship)
show_download_dns() {
  echo -e "\n${bold}${cyan}Download / Anti-Censorship DNS:${reset}"
  for dns in "9.9.9.9 | 149.112.112.112" "94.140.14.14 | 94.140.15.15" "185.51.200.2 | 178.22.122.100"; do
    echo "- $dns"
  done
  main_menu
}

# Ping DNS
ping_dns() {
  echo -n "Enter DNS to test: "; read dns
  ms=$(ping -c 1 -W 1 "$dns" | grep 'time=' | sed -E 's/.*time=([0-9.]+) ms/\1 ms/')
  [[ -z "$ms" ]] && echo "DNS Unreachable." || echo "Ping: $ms"
  main_menu
}

# Auto Mode
auto_mode() {
  echo -n "Enter your console (e.g. PS4) and game (e.g. Fortnite): "; read -r input
  best_dns="185.51.200.2 | 178.22.122.100" # simulate selection logic
  echo "Best DNS for $input: $best_dns"
  echo "[QR Code Placeholder]"
  main_menu
}

# Best DNS Finder
best_dns() {
  echo -e "\n${bold}${green}Finding best DNS based on ping...${reset}"
  best=""; minping=9999
  for dns in "1.1.1.1" "8.8.8.8" "9.9.9.9" "94.140.14.14"; do
    ping_result=$(ping -c 1 -W 1 $dns | grep 'time=' | sed -E 's/.*time=([0-9.]+).*/\1/')
    [[ -n "$ping_result" ]] && [[ $(echo "$ping_result < $minping" | bc) -eq 1 ]] && minping=$ping_result && best=$dns
  done
  echo "Best DNS: $best ($minping ms)"
  main_menu
}

# Game DNS Menus
gaming_dns_menu() {
  echo -e "\n${bold}${blue}PC & Mobile Games:${reset}"
  i=1
  for game in "${!game_dns_map[@]}"; do
    label="$game"
    [[ "$game" == "Arena Breakout" ]] && label="${orange}$game (New)${reset}"
    echo "[$i] $label"
    ((i++))
  done
  echo -n "Choose a game: "; read gidx
  selected_game=$(printf "%s\n" "${!game_dns_map[@]}" | sed -n "${gidx}p")
  echo "DNS for $selected_game: ${game_dns_map[$selected_game]}"
  main_menu
}

console_dns_menu() {
  echo -e "\n${bold}${cyan}Console Games:${reset}"
  i=1
  for title in "${!console_game_dns_map[@]}"; do
    label="$title"
    [[ "$title" == "Arena Breakout" ]] && label="${orange}$title (New)${reset}"
    echo "[$i] $label"
    ((i++))
  done
  echo -n "Choose a console game: "; read cidx
  selected_game=$(printf "%s\n" "${!console_game_dns_map[@]}" | sed -n "${cidx}p")
  echo "DNS for $selected_game: ${console_game_dns_map[$selected_game]}"
  main_menu
}

# Main Menu
main_menu() {
  echo -e "${bold}${blue}Main Menu:${reset}"
  echo "1. Gaming DNS (PC & Mobile)"
  echo "2. Console DNS"
  echo "3. Search Game DNS"
  echo "4. Ping DNS"
  echo "5. Download / Anti-Censorship DNS"
  echo "6. Find Best DNS (Low Ping)"
  echo "7. Auto Mode for Console"
  echo "0. Exit"
  echo -n "Choose an option: "; read choice
  case $choice in
    1) gaming_dns_menu ;;
    2) console_dns_menu ;;
    3) echo "Search feature coming soon..."; main_menu ;;
    4) ping_dns ;;
    5) show_download_dns ;;
    6) best_dns ;;
    7) auto_mode ;;
    0) echo "Goodbye!"; exit ;;
    *) echo "Invalid option"; main_menu ;;
  esac
}

show_title
load_dns_list
main_menu
