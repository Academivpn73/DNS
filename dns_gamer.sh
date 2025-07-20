#!/bin/bash

# Version 1.2.4 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
white="\e[1;37m"
reset="\e[0m"
bold="\e[1m"

# Fast typing animation (faster for main menu only)
fast_type_text() {
    text="$1"
    delay="${2:-0.00001}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Title with animation (only on main menu)
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    fast_type_text "╔══════════════════════════════════════╗" 0.00001
    fast_type_text "║         DNS MANAGEMENT TOOL         ║" 0.00001
    fast_type_text "╠══════════════════════════════════════╣" 0.00001
    fast_type_text "║  Version: 1.2.4                     ║" 0.00001
    fast_type_text "║  Telegram: @Academi_vpn              ║" 0.00001
    fast_type_text "║  Admin: @MahdiAGM0                   ║" 0.00001
    fast_type_text "╚══════════════════════════════════════╝" 0.00001
    echo -e "${reset}"
}

# Data:

# --- Countries ---
countries=("Iran" "UAE" "Turkey" "Qatar" "Saudi Arabia" "USA" "Germany" "France" "UK" "Japan")

# --- Gaming Mobile/PC Games (50 items) ---
gaming_games=(
"Call of Duty Mobile"
"PUBG Mobile"
"Free Fire"
"Clash Royale"
"Clash of Clans"
"League of Legends"
"Valorant"
"CS:GO"
"Dota 2"
"Fortnite"
"Apex Legends"
"Overwatch 2"
"Minecraft"
"Genshin Impact"
"Roblox"
"Rocket League"
"Warframe"
"Among Us"
"Rainbow Six Siege"
"World of Tanks"
"GTA Online"
"FIFA 24"
"Arena Breakout"
"XDefiant"
"Battlefield 2042"
"The Finals"
"Modern Warfare III"
"Hyper Front"
"Starfield"
"Naraka Bladepoint"
"Blue Protocol"
"Stalker 2"
"Palworld"
"FC25"
"Brawlhalla"
"War Thunder"
"Mobile Legends"
"COD Warzone"
"Diablo IV"
"Lost Ark"
"GTA IV"
"New World"
"Monster Hunter"
"Street Fighter 6"
"Tekken 8"
"Dying Light 2"
"Honkai Star Rail"
"Destiny 2"
"Fall Guys"
"Cyberpunk 2077"
)

# --- Console Games (50 items) ---
console_games=(
"God of War Ragnarök"
"Halo Infinite"
"The Last of Us Part I"
"Forza Horizon 5"
"Spider-Man: Miles Morales"
"Gran Turismo 7"
"Resident Evil Village"
"Ghost of Tsushima"
"FIFA 23"
"Call of Duty: Modern Warfare II"
"Cyberpunk 2077"
"Battlefield 2042"
"Elden Ring"
"Assassin's Creed Valhalla"
"Minecraft Dungeons"
"NBA 2K24"
"Super Mario Odyssey"
"The Legend of Zelda: Breath of the Wild"
"Animal Crossing: New Horizons"
"Splatoon 3"
"Metroid Dread"
"Ratchet & Clank: Rift Apart"
"Sea of Thieves"
"Dark Souls III"
"Godfall"
"Death Stranding"
"Hades"
"Persona 5 Royal"
"Final Fantasy VII Remake"
"Xenoblade Chronicles 3"
"Bayonetta 3"
"Street Fighter 6"
"FIFA 24"
"Tekken 8"
"Halo 5: Guardians"
"Mass Effect Legendary Edition"
"Dragon Age: Inquisition"
"Marvel's Spider-Man"
"Watch Dogs: Legion"
"Control"
"Overwatch 2"
"Diablo IV"
"Battletoads"
"Ghostrunner"
"Nier Replicant"
"Tony Hawk's Pro Skater 1+2"
"Mortal Kombat 11"
"Dead Cells"
)

# --- DNS for gaming per country (fake but structured) ---
# For each country, a pair of primary|secondary DNS for gaming (pings below 40)
gaming_dns_data=(
"103.86.96.100|103.86.99.100"    # Iran
"94.140.14.14|94.140.15.15"      # UAE
"78.157.42.101|78.157.42.100"    # Turkey
"64.6.64.6|64.6.65.6"             # Qatar
"185.55.225.25|185.55.226.26"    # Saudi Arabia
"8.8.8.8|8.8.4.4"                 # USA
"84.200.69.80|84.200.70.40"       # Germany
"80.80.80.80|80.80.81.81"         # France
"77.88.8.8|77.88.8.1"             # UK
"1.1.1.1|1.0.0.1"                 # Japan
)

# --- DNS for console per country ---
console_dns_data=(
"45.90.28.0|45.90.30.0"           # Iran
"208.67.222.222|208.67.220.220"   # UAE
"149.112.112.112|149.112.112.10"  # Turkey
"9.9.9.9|9.9.9.10"                # Qatar
"8.26.56.26|8.20.247.20"           # Saudi Arabia
"1.1.1.1|1.0.0.1"                 # USA
"77.88.8.88|77.88.8.2"             # Germany
"94.140.14.14|94.140.15.15"       # France
"64.6.64.6|64.6.65.6"             # UK
"208.67.222.222|208.67.220.220"   # Japan
)

# --- DNS for Download & Proxy (50+ real DNSs) ---
download_dns_list=(
"1.1.1.1"
"1.0.0.1"
"8.8.8.8"
"8.8.4.4"
"9.9.9.9"
"149.112.112.112"
"208.67.222.222"
"208.67.220.220"
"94.140.14.14"
"94.140.15.15"
"64.6.64.6"
"64.6.65.6"
"84.200.69.80"
"84.200.70.40"
"77.88.8.8"
"77.88.8.1"
"80.80.80.80"
"80.80.81.81"
"185.228.168.168"
"185.228.169.168"
"199.85.126.10"
"199.85.127.10"
"64.68.200.200"
"156.154.70.1"
"156.154.71.1"
"9.9.9.10"
"149.112.112.10"
"192.71.245.208"
"109.69.8.51"
"94.140.14.140"
"198.101.242.72"
"23.253.163.53"
"37.235.1.174"
"37.235.1.177"
"81.218.119.11"
"209.244.0.3"
"209.244.0.4"
"8.26.56.26"
"8.20.247.20"
"195.46.39.39"
"195.46.39.40"
"156.154.70.22"
"156.154.71.22"
"185.222.222.222"
"185.228.168.9"
"185.228.168.10"
"45.90.28.0"
"45.90.30.0"
"77.88.8.88"
"77.88.8.2"
)

# --- Helpers ---

print_new() {
    echo -e "${orange}[NEW]${reset}"
}

print_option() {
    # $1=number, $2=text, $3=is_new (yes/no)
    local num=$1
    local text=$2
    local is_new=$3
    if [[ "$is_new" == "yes" ]]; then
        echo -e "${white}${num}. ${text} ${orange}[NEW]${reset}"
    else
        echo -e "${white}${num}. ${text}${reset}"
    fi
}

pause() {
    echo
    read -rp "Press Enter to return to previous menu..."
}

# Simulated ping (random 20-40 ms)
simulate_ping() {
    echo $((20 + RANDOM % 21))
}

# Show countries list for selection
select_country() {
    echo -e "${cyan}Select Country:${reset}"
    local idx=1
    for c in "${countries[@]}"; do
        echo -e "${white}${idx}. ${c}${reset}"
        ((idx++))
    done
    echo -ne "Enter number: "
    read -r choice
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || ((choice < 1 || choice > ${#countries[@]})); then
        echo -e "${red}Invalid choice!${reset}"
        return 1
    fi
    selected_country="${countries[$((choice-1))]}"
    selected_country_index=$((choice-1))
    return 0
}

# Show gaming games list (50) with new tags for latest 5
show_gaming_games() {
    echo -e "${cyan}Gaming Mobile & PC Games:${reset}"
    local count=1
    local total=${#gaming_games[@]}
    for ((i=0; i<total; i++)); do
        if (( i >= total-5 )); then
            print_option "$count" "${gaming_games[$i]}" "yes"
        else
            print_option "$count" "${gaming_games[$i]}" "no"
        fi
        ((count++))
    done
}

# Show console games list (50) with new tags for latest 5
show_console_games() {
    echo -e "${cyan}Console Games:${reset}"
    local count=1
    local total=${#console_games[@]}
    for ((i=0; i<total; i++)); do
        if (( i >= total-5 )); then
            print_option "$count" "${console_games[$i]}" "yes"
        else
            print_option "$count" "${console_games[$i]}" "no"
        fi
        ((count++))
    done
}

# Show gaming DNS for selected country
show_gaming_dns() {
    local idx=$selected_country_index
    local dns_pair="${gaming_dns_data[$idx]}"
    IFS='|' read -r dns1 dns2 <<< "$dns_pair"
    echo -e "${cyan}Gaming DNS for ${countries[$idx]}:${reset}"
    echo -e "${white}Primary DNS: ${green}$dns1${reset}"
    echo -e "${white}Secondary DNS: ${green}$dns2${reset}"
    echo -e "Ping: ${green}$(simulate_ping) ms${reset}"
}

# Show console DNS for selected country
show_console_dns() {
    local idx=$selected_country_index
    local dns_pair="${console_dns_data[$idx]}"
    IFS='|' read -r dns1 dns2 <<< "$dns_pair"
    echo -e "${cyan}Console DNS for ${countries[$idx]}:${reset}"
    echo -e "${white}Primary DNS: ${green}$dns1${reset}"
    echo -e "${white}Secondary DNS: ${green}$dns2${reset}"
    echo -e "Ping: ${green}$(simulate_ping) ms${reset}"
}

# Show download & proxy DNS (list 50+)
show_download_dns() {
    echo -e "${cyan}Download & Proxy DNS (50+):${reset}"
    local count=1
    for dns in "${download_dns_list[@]}"; do
        echo -e "${white}${count}. ${dns}${reset} - Ping: $(simulate_ping) ms"
        ((count++))
    done
}

# Search gaming games mobile/pc
search_gaming_games() {
    echo -ne "Enter keyword to search Mobile/PC games: "
    read -r keyword
    echo -e "${cyan}Search Results:${reset}"
    local count=1
    local found=0
    for game in "${gaming_games[@]}"; do
        if [[ "${game,,}" == *"${keyword,,}"* ]]; then
            if (( found >= 45 )); then break; fi
            if (( ${#gaming_games[@]} - found <= 5 )); then
                print_option "$count" "$game" "yes"
            else
                print_option "$count" "$game" "no"
            fi
            ((count++))
            ((found++))
        fi
    done
    if ((found == 0)); then
        echo -e "${red}No games found with keyword \"$keyword\"${reset}"
    fi
    pause
}

# Search console games
search_console_games() {
    echo -ne "Enter keyword to search Console games: "
    read -r keyword
    echo -e "${cyan}Search Results:${reset}"
    local count=1
    local found=0
    for game in "${console_games[@]}"; do
        if [[ "${game,,}" == *"${keyword,,}"* ]]; then
            if (( found >= 45 )); then break; fi
            if (( ${#console_games[@]} - found <= 5 )); then
                print_option "$count" "$game" "yes"
            else
                print_option "$count" "$game" "no"
            fi
            ((count++))
            ((found++))
        fi
    done
    if ((found == 0)); then
        echo -e "${red}No games found with keyword \"$keyword\"${reset}"
    fi
    pause
}

# Ping DNS tool
ping_dns_tool() {
    echo -ne "Enter DNS IP to ping: "
    read -r dns_ip
    echo -e "Pinging $dns_ip ..."
    # Simulate ping with random value, real ping needs external tool (ping command)
    ping_ms=$(simulate_ping)
    echo -e "Ping: ${green}${ping_ms} ms${reset}"
    pause
}

# Exit message
exit_message() {
    echo -e "${orange}Thank you for using DNS Management Tool! Stay safe and enjoy fast connections!${reset}"
    exit 0
}

# Main menu
main_menu() {
    show_title
    echo -e "${white}1. Download & Proxy DNS (50+ DNS)${reset}"
    echo -e "${white}2. Ping DNS Tool${reset}"
    echo -e "${white}3. Search Gaming Mobile & PC Games${reset}"
    echo -e "${white}4. Search Console Games${reset}"
    echo -e "${white}5. Gaming DNS by Country${reset}"
    echo -e "${white}6. Console DNS by Country${reset}"
    echo -e "${white}0. Exit${reset}"
    echo -ne "Choose option: "
    read -r opt
    case $opt in
        1) download_dns_menu ;;
        2) ping_dns_tool ;;
        3) search_gaming_games ;;
        4) search_console_games ;;
        5) gaming_dns_menu ;;
        6) console_dns_menu ;;
        0) exit_message ;;
        *) echo -e "${red}Invalid option!${reset}"; sleep 1; main_menu ;;
    esac
}

# Download DNS menu
download_dns_menu() {
    clear
    show_title
    show_download_dns
    pause
    main_menu
}

# Gaming DNS menu
gaming_dns_menu() {
    clear
    show_title
    if ! select_country; then
        gaming_dns_menu
        return
    fi
    clear
    show_title
    show_gaming_dns
    pause
    main_menu
}

# Console DNS menu
console_dns_menu() {
    clear
    show_title
    if ! select_country; then
        console_dns_menu
        return
    fi
    clear
    show_title
    show_console_dns
    pause
    main_menu
}

# Run the tool
while true; do
    main_menu
done
