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

# Fast typing for title animation - faster speed
fast_type_text() {
    text="$1"
    delay="${2:-0.00002}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Show title with animation only in main menu
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    fast_type_text "╔══════════════════════════════════════╗"
    fast_type_text "║         DNS MANAGEMENT TOOL         ║"
    fast_type_text "╠══════════════════════════════════════╣"
    fast_type_text "║  Version: 1.2.4                     ║"
    fast_type_text "║  Telegram: @Academi_vpn             ║"
    fast_type_text "║  Admin: @MahdiAGM0                  ║"
    fast_type_text "╚══════════════════════════════════════╝"
    echo -e "${reset}"
}

# Pause function to wait for user input
pause() {
    echo -ne "${green}Press Enter to return...${reset}"
    read -r
}

# Print options with optional "New" tag in orange
print_option() {
    local number=$1
    local text=$2
    local new_tag=$3
    if [[ "$new_tag" == "yes" ]]; then
        echo -e "[${number}] ${text} ${orange}(New)${reset}"
    else
        echo -e "[${number}] ${text}"
    fi
}

# DNS Data arrays with real-ish DNS and countries
countries=("Iran" "UAE" "Turkey" "Qatar" "Saudi Arabia" "USA" "Germany" "Singapore" "Japan" "South Korea")

# Each country has multiple DNS servers for different games, download, proxy etc.
declare -A dns_for_game
declare -A dns_for_download

# Sample DNS for gaming per country (primary|secondary|ping in ms)
dns_for_game["Iran"]="185.51.200.2|178.22.122.100|35"
dns_for_game["UAE"]="64.6.64.6|64.6.65.6|30"
dns_for_game["Turkey"]="78.157.42.101|78.157.42.100|25"
dns_for_game["Qatar"]="185.55.225.25|185.55.226.26|28"
dns_for_game["Saudi Arabia"]="8.8.8.8|8.8.4.4|20"
dns_for_game["USA"]="1.1.1.1|1.0.0.1|15"
dns_for_game["Germany"]="9.9.9.9|149.112.112.112|22"
dns_for_game["Singapore"]="208.67.222.222|208.67.220.220|18"
dns_for_game["Japan"]="156.154.70.1|156.154.71.1|20"
dns_for_game["South Korea"]="210.220.163.82|210.220.163.83|23"

# DNS for download and proxy (more entries)
dns_for_download["Iran"]="176.103.130.130|176.103.130.131|38"
dns_for_download["UAE"]="91.239.100.100|89.233.43.71|32"
dns_for_download["Turkey"]="45.90.28.0|45.90.30.0|35"
dns_for_download["Qatar"]="208.67.222.222|208.67.220.220|28"
dns_for_download["Saudi Arabia"]="8.8.8.8|8.8.4.4|20"
dns_for_download["USA"]="119.29.29.29|223.5.5.5|18"
dns_for_download["Germany"]="84.200.69.80|84.200.70.40|24"
dns_for_download["Singapore"]="1.1.1.1|1.0.0.1|18"
dns_for_download["Japan"]="156.154.70.1|156.154.71.1|22"
dns_for_download["South Korea"]="210.220.163.82|210.220.163.83|23"

# Gaming mobile & PC games (50 items)
gaming_games=(
"Call of Duty Mobile" "PUBG Mobile" "Free Fire" "Clash Royale" "Clash of Clans" "League of Legends" "Valorant" "CS:GO" "Dota 2" "Fortnite"
"Apex Legends" "Overwatch 2" "Minecraft" "Genshin Impact" "Roblox" "Rocket League" "Warframe" "Among Us" "Rainbow Six Siege" "World of Tanks"
"GTA Online" "FIFA 24" "Arena Breakout" "XDefiant" "Battlefield 2042" "The Finals" "Modern Warfare III" "Hyper Front" "Starfield" "Naraka Bladepoint"
"Blue Protocol" "Stalker 2" "Palworld" "FC25" "Brawlhalla" "War Thunder" "Mobile Legends" "COD Warzone" "Diablo IV" "Lost Ark"
"GTA IV" "New World" "Monster Hunter" "Street Fighter 6" "Tekken 8" "Dying Light 2" "Honkai Star Rail" "Destiny 2" "Fall Guys" "Cyberpunk 2077"
)

# Console games (50 items)
console_games=(
"God of War Ragnarok" "The Last of Us Part II" "Halo Infinite" "Forza Horizon 5" "Gran Turismo 7" "Spider-Man: Miles Morales" "Elden Ring" "FIFA 24" "Call of Duty: Modern Warfare II" "Resident Evil Village"
"Horizon Forbidden West" "Guitar Hero Live" "Animal Crossing: New Horizons" "Super Mario Odyssey" "The Legend of Zelda: Breath of the Wild" "Mario Kart 8 Deluxe" "Metroid Dread" "Splatoon 3" "Death Stranding" "Ghost of Tsushima"
"Cyberpunk 2077" "Ratchet & Clank: Rift Apart" "Final Fantasy VII Remake" "Persona 5 Royal" "Sekiro: Shadows Die Twice" "Bloodborne" "Dark Souls III" "Nier: Automata" "Doom Eternal" "The Witcher 3: Wild Hunt"
"Minecraft Dungeons" "Dead Cells" "Cuphead" "Celeste" "Hades" "Ori and the Will of the Wisps" "Inside" "Control" "Resident Evil 2 Remake" "Batman: Arkham Knight"
"Marvel's Spider-Man" "Assassin's Creed Valhalla" "Ghostrunner" "For Honor" "Watch Dogs: Legion" "Deathloop" "Returnal" "Far Cry 6" "Mass Effect Legendary Edition" "Bayonetta 3"
)

# Helper to generate DNS output per country and game type
generate_dns_for_game() {
    local country="$1"
    if [[ -z "${dns_for_game[$country]}" ]]; then
        echo -e "${red}No DNS info for $country${reset}"
        return
    fi
    IFS='|' read -r primary secondary ping <<< "${dns_for_game[$country]}"
    echo -e "${cyan}Country: $country"
    echo -e "Primary DNS: $primary"
    echo -e "Secondary DNS: $secondary"
    echo -e "Estimated Ping: ${ping}ms${reset}"
}

generate_dns_for_download() {
    local country="$1"
    if [[ -z "${dns_for_download[$country]}" ]]; then
        echo -e "${red}No Download/Proxy DNS info for $country${reset}"
        return
    fi
    IFS='|' read -r primary secondary ping <<< "${dns_for_download[$country]}"
    echo -e "${cyan}Country: $country"
    echo -e "Primary DNS: $primary"
    echo -e "Secondary DNS: $secondary"
    echo -e "Estimated Ping: ${ping}ms${reset}"
}

# Pause with ability to return to main menu
return_to_menu() {
    echo
    pause
    main_menu
}

# Show gaming games list with numbering and new tag for last 5 games
show_gaming_games() {
    for i in "${!gaming_games[@]}"; do
        num=$((i+1))
        game="${gaming_games[$i]}"
        if (( i >= ${#gaming_games[@]} - 5 )); then
            echo -e "[${num}] ${game} ${orange}(New)${reset}"
        else
            echo -e "[${num}] ${game}"
        fi
    done
}

# Show console games list with numbering and new tag for last 5 games
show_console_games() {
    for i in "${!console_games[@]}"; do
        num=$((i+1))
        game="${console_games[$i]}"
        if (( i >= ${#console_games[@]} - 5 )); then
            echo -e "[${num}] ${game} ${orange}(New)${reset}"
        else
            echo -e "[${num}] ${game}"
        fi
    done
}

# Search gaming games (mobile & PC)
search_gaming_games() {
    clear
    echo -e "${cyan}Mobile & PC Games List:${reset}"
    show_gaming_games
    echo
    echo -ne "Enter keyword to search Mobile/PC games (or press Enter to skip): "
    read -r keyword
    if [[ -z "$keyword" ]]; then
        pause
        return
    fi
    echo -e "${cyan}Search Results:${reset}"
    local count=1
    local found=0
    for game in "${gaming_games[@]}"; do
        if [[ "${game,,}" == *"${keyword,,}"* ]]; then
            if (( found >= 50 )); then break; fi
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
    clear
    echo -e "${cyan}Console Games List:${reset}"
    show_console_games
    echo
    echo -ne "Enter keyword to search Console games (or press Enter to skip): "
    read -r keyword
    if [[ -z "$keyword" ]]; then
        pause
        return
    fi
    echo -e "${cyan}Search Results:${reset}"
    local count=1
    local found=0
    for game in "${console_games[@]}"; do
        if [[ "${game,,}" == *"${keyword,,}"* ]]; then
            if (( found >= 50 )); then break; fi
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

# DNS for gaming selection menu (user chooses country)
dns_gaming_menu() {
    while true; do
        clear
        echo -e "${bold}${cyan}Select country for Gaming DNS servers:${reset}"
        for i in "${!countries[@]}"; do
            echo -e "[$((i+1))] ${countries[$i]}"
        done
        echo -e "[0] Return to Main Menu"
        echo -ne "Choose option: "
        read -r choice
        if [[ "$choice" == "0" ]]; then
            return
        elif ((choice >=1 && choice <= ${#countries[@]})); then
            country="${countries[$((choice-1))]}"
            clear
            echo -e "${bold}Gaming DNS for $country:${reset}"
            generate_dns_for_game "$country"
            pause
        else
            echo -e "${red}Invalid option, try again.${reset}"
            sleep 1
        fi
    done
}

# DNS for download/proxy selection menu
dns_download_menu() {
    while true; do
        clear
        echo -e "${bold}${cyan}Select country for Download/Proxy DNS servers:${reset}"
        for i in "${!countries[@]}"; do
            echo -e "[$((i+1))] ${countries[$i]}"
        done
        echo -e "[0] Return to Main Menu"
        echo -ne "Choose option: "
        read -r choice
        if [[ "$choice" == "0" ]]; then
            return
        elif ((choice >=1 && choice <= ${#countries[@]})); then
            country="${countries[$((choice-1))]}"
            clear
            echo -e "${bold}Download/Proxy DNS for $country:${reset}"
            generate_dns_for_download "$country"
            pause
        else
            echo -e "${red}Invalid option, try again.${reset}"
            sleep 1
        fi
    done
}

# Ping DNS menu (show ping for DNS servers)
ping_dns_menu() {
    while true; do
        clear
        echo -e "${bold}${cyan}Select country to check Ping DNS servers:${reset}"
        for i in "${!countries[@]}"; do
            echo -e "[$((i+1))] ${countries[$i]}"
        done
        echo -e "[0] Return to Main Menu"
        echo -ne "Choose option: "
        read -r choice
        if [[ "$choice" == "0" ]]; then
            return
        elif ((choice >=1 && choice <= ${#countries[@]})); then
            country="${countries[$((choice-1))]}"
            clear
            echo -e "${bold}Ping DNS Servers for $country:${reset}"
            # simulate ping output with stored ping times
            IFS='|' read -r primary secondary ping <<< "${dns_for_game[$country]}"
            echo -e "${green}Pinging $primary ... ${ping}ms (simulated)${reset}"
            echo -e "${green}Pinging $secondary ... ${ping}ms (simulated)${reset}"
            pause
        else
            echo -e "${red}Invalid option, try again.${reset}"
            sleep 1
        fi
    done
}

# Exit message with confirmation
exit_message() {
    clear
    echo -e "${bold}${red}Thank you for using DNS Management Tool!${reset}"
    echo -e "Stay safe, and happy gaming! 🎮"
    exit 0
}

# Main menu
main_menu() {
    show_title
    echo -e "${bold}${blue}Main Menu:${reset}"
    echo -e "[1] DNS for Gaming (Select Country)"
    echo -e "[2] DNS for Download and Proxy (Select Country)"
    echo -e "[3] Ping DNS Servers (Select Country)"
    echo -e "[4] Search Mobile & PC Games"
    echo -e "[5] Search Console Games"
    echo -e "[0] Exit"
    echo -ne "Choose option: "
    read -r option
    case $option in
        1) dns_gaming_menu ;;
        2) dns_download_menu ;;
        3) ping_dns_menu ;;
        4) search_gaming_games ;;
        5) search_console_games ;;
        0) exit_message ;;
        *) echo -e "${red}Invalid option!${reset}" ; sleep 1 ;;
    esac
    main_menu
}

# Start program
main_menu
