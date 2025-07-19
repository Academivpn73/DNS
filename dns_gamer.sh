#!/bin/bash

VERSION="1.2.3"
ADMIN="@MahdiAGM0"
CHANNEL="@Academi_vpn"

# Colors
GREEN="\033[1;32m"
CYAN="\033[1;36m"
RESET="\033[0m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
MAGENTA="\033[1;35m"

# Function to simulate typing
type_effect() {
    text="$1"
    delay="${2:-0.002}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Function to pick a random color for title
random_color() {
    colors=("$GREEN" "$CYAN" "$BLUE" "$YELLOW" "$MAGENTA")
    echo -ne "${colors[$RANDOM % ${#colors[@]}]}"
}

# Title Screen
clear
random_color
type_effect "╔════════════════════════════════════════╗" 0.001
type_effect "║          DNS MANAGEMENT SCRIPT        ║" 0.001
type_effect "╠════════════════════════════════════════╣" 0.001
type_effect "║ Telegram : $CHANNEL" 0.001
type_effect "║ Admin    : $ADMIN" 0.001
type_effect "║ Version  : $VERSION" 0.001
type_effect "╚════════════════════════════════════════╝" 0.001

sleep 0.5

main_menu() {
    echo -e "${GREEN}[1]${RESET} Gaming DNS 🎮"
    echo -e "${GREEN}[2]${RESET} Download DNS ⬇️"
    echo -e "${GREEN}[3]${RESET} Premium DNS ⚡"
    echo -e "${GREEN}[4]${RESET} Real-Time Ping Test 📡"
    echo -e "${GREEN}[0]${RESET} Exit ❌"
    echo
    read -p "Select an option: " choice

    case $choice in
        1) show_game_dns ;;
        2) show_download_dns ;;
        3) show_premium_dns ;;
        4) ping_test ;;
        0) echo -e "${GREEN}Goodbye 🙏🏻${RESET}"; exit 0 ;;
        *) echo "Invalid option"; main_menu ;;
    esac
}

# Gaming DNS section
show_game_dns() {
    clear
    echo -e "${CYAN}Select a Game:${RESET}"
    games=("PUBG" "Call of Duty" "Fortnite" "Valorant" "Free Fire" "Arena Breakout")
    for i in "${!games[@]}"; do
        echo -e "${GREEN}[$((i+1))]${RESET} ${games[$i]}"
    done
    echo -e "${GREEN}[0]${RESET} Back"
    read -p "Choose a game: " gopt

    [[ "$gopt" == "0" ]] && main_menu

    case $gopt in
        1) dns=("10.202.10.10" "10.202.10.11") ;;
        2) dns=("78.157.42.100" "78.157.42.101") ;;
        3) dns=("1.1.1.1" "1.0.0.1") ;;
        4) dns=("9.9.9.9" "149.112.112.112") ;;
        5) dns=("156.154.70.2" "156.154.71.2") ;;
        6) dns=("185.51.200.2" "178.22.122.100") ;;
        *) echo "Invalid"; sleep 1; show_game_dns ;;
    esac

    echo -e "\n${BLUE}Primary DNS:${RESET} ${dns[0]}"
    echo -e "${BLUE}Secondary DNS:${RESET} ${dns[1]}"
    echo -e "${YELLOW}Press Enter to go back...${RESET}"
    read
    main_menu
}

# Download DNS section
show_download_dns() {
    clear
    echo -e "${CYAN}Download DNS with Anti-Censorship:${RESET}"

    dns_list=(
        "78.157.42.100|78.157.42.101"  # Electro
        "185.51.200.2|178.22.122.100"  # Shecan
        "185.55.225.25|185.55.226.26"  # Begzar
        "64.6.64.6|64.6.65.6"          # Ultra
        "159.250.35.250|159.250.35.251" # NTT
    )

    selected="${dns_list[$RANDOM % ${#dns_list[@]}]}"
    primary=$(echo $selected | cut -d'|' -f1)
    secondary=$(echo $selected | cut -d'|' -f2)

    echo -e "\n${BLUE}Primary DNS:${RESET} $primary"
    echo -e "${BLUE}Secondary DNS:${RESET} $secondary"
    echo -e "${YELLOW}Press Enter to go back...${RESET}"
    read
    main_menu
}

# Premium DNS section
show_premium_dns() {
    clear
    echo -e "${CYAN}High Performance Premium DNS:${RESET}"

    dns_list=(
        "103.86.96.100|103.86.99.100"  # NordVPN DNS
        "94.140.14.14|94.140.15.15"    # AdGuard DNS
        "8.26.56.26|8.20.247.20"       # Comodo Secure
        "76.76.2.0|76.76.10.0"         # Control D
    )

    selected="${dns_list[$RANDOM % ${#dns_list[@]}]}"
    primary=$(echo $selected | cut -d'|' -f1)
    secondary=$(echo $selected | cut -d'|' -f2)

    echo -e "\n${BLUE}Primary DNS:${RESET} $primary"
    echo -e "${BLUE}Secondary DNS:${RESET} $secondary"
    echo -e "${YELLOW}Press Enter to go back...${RESET}"
    read
    main_menu
}

# Real-time Ping Test
ping_test() {
    clear
    echo -e "${CYAN}Testing DNS latency...${RESET}"
    servers=("1.1.1.1" "8.8.8.8" "9.9.9.9" "185.51.200.2")
    for s in "${servers[@]}"; do
        ping -c 1 -W 1 $s &>/dev/null
        if [ $? -eq 0 ]; then
            ping_result=$(ping -c 1 -W 1 $s | grep 'time=' | awk -F'time=' '{print $2}')
            echo -e "${GREEN}$s${RESET} => ${YELLOW}${ping_result}${RESET}"
        else
            echo -e "${RED}$s => No Response${RESET}"
        fi
    done
    echo -e "${YELLOW}Press Enter to go back...${RESET}"
    read
    main_menu
}

main_menu
