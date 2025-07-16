#!/bin/bash

# Auto-install required packages
for cmd in figlet lolcat; do
    if ! command -v $cmd &>/dev/null; then
        echo "Installing missing package: $cmd"
        apt update -y && apt install -y $cmd
    fi
done

# Random color function
colors=(31 32 33 34 36 91 92 93 94 96)
rand_color() {
    echo -e "\e[1;${colors[$RANDOM % ${#colors[@]}]}m$1\e[0m"
}

# Title
clear
figlet -c "MAHDI DNS" | lolcat
echo -e "$(rand_color 'Telegram:') @Academi_vpn"
echo -e "$(rand_color 'Admin:') @MahdiAGM0"
echo -e "\e[1;31mVersion: 1.2.0\e[0m\n"

# Game List
games=(
"PUBG Mobile"
"Call of Duty Mobile"
"Fortnite"
"Valorant"
"Free Fire"
"Clash of Clans"
"Clash Royale"
"Apex Legends"
"League of Legends"
"Dota 2"
"CS:GO"
"Overwatch"
"Rocket League"
"FIFA Mobile"
"Mobile Legends"
"Brawl Stars"
"Roblox"
"Among Us"
"Warzone"
"Battlefield"
"Rainbow Six Siege"
"World of Tanks"
"ARK Survival"
"Paladins"
"Smite"
"Genshin Impact"
"Diablo Immortal"
"NBA 2K"
"eFootball"
"Star Wars Battlefront"
"Minecraft"
"Rust"
"Escape From Tarkov"
"DayZ"
"Dead by Daylight"
"Hearthstone"
"EVE Online"
"Pokemon Unite"
"Naruto Blazing"
"Injustice 2"
)

# Country DNS map (gaming)
declare -A dns_map
dns_map["Iran"]="178.22.122.100 185.51.200.2"
dns_map["Turkey"]="185.33.33.33 185.38.38.38"
dns_map["UAE"]="91.74.107.180 91.74.107.181"
dns_map["Saudi Arabia"]="195.229.241.222 195.229.240.42"
dns_map["Iraq"]="185.73.112.53 185.73.112.54"
dns_map["Qatar"]="89.211.30.2 89.211.30.3"
dns_map["Egypt"]="41.128.225.1 41.128.225.2"
dns_map["Jordan"]="212.35.65.1 212.35.65.2"
dns_map["Oman"]="82.178.72.30 82.178.72.31"
dns_map["Kuwait"]="62.150.97.200 62.150.97.201"

# Sample public DNS for download mode (partial 300+ source implied)
download_dns=(
"8.8.8.8"
"1.1.1.1"
"9.9.9.9"
"8.26.56.26"
"208.67.222.222"
"1.0.0.1"
"94.140.14.14"
"195.46.39.39"
"185.228.168.9"
"76.76.2.0"
"176.103.130.130"
"45.90.28.0"
"149.112.112.112"
"64.6.64.6"
"77.88.8.8"
)

# Show list with animation
show_list() {
    local -n items=$1
    for i in "${!items[@]}"; do
        num=$((i+1))
        printf "\e[1;${colors[$RANDOM % ${#colors[@]}]}m[%02d] %s\e[0m\n" "$num" "${items[$i]}"
        sleep 0.02
    done
}

# Ping test
get_ping() {
    local ip=$1
    ping -c1 -W1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1 " ms"}'
}

# Generate 15 DNS
generate_dns_list() {
    local -n pool=$1
    shuffled=($(shuf -e "${pool[@]}" -n 15))
    for i in "${!shuffled[@]}"; do
        dns="${shuffled[$i]}"
        ping=$(get_ping "$dns")
        ping_display=${ping:-"N/A"}
        printf "\e[1;36mDNS %02d:\e[0m %s \e[1;33m(Ping: %s)\e[0m\n" "$((i+1))" "$dns" "$ping_display"
        sleep 0.1
    done
}

# Main Menu
while true; do
    echo -e "\n$(rand_color 'Select an option:')"
    echo -e "$(rand_color '[1]') Gaming DNS"
    echo -e "$(rand_color '[2]') Download DNS"
    echo -e "$(rand_color '[0]') Exit"

    read -p "$(rand_color 'Enter your choice:') " choice

    case $choice in
        1)
            echo -e "\n$(rand_color 'Select a Game:')"
            show_list games
            read -p "$(rand_color 'Game number:') " gnum
            game="${games[$((gnum-1))]}"

            echo -e "\n$(rand_color 'Select Country:')"
            countries=("${!dns_map[@]}")
            show_list countries
            read -p "$(rand_color 'Country number:') " cnum
            country="${countries[$((cnum-1))]}"

            echo -e "\n$(rand_color "Selected Game: $game")"
            echo -e "$(rand_color "Selected Country: $country")"
            IFS=' ' read -ra dns_list <<< "${dns_map[$country]}"
            generate_dns_list dns_list
            read -p $'\nPress Enter to return to main menu...'
            ;;
        2)
            echo -e "\n$(rand_color 'Select Country:')"
            show_list countries
            read -p "$(rand_color 'Country number:') " cnum
            generate_dns_list download_dns
            read -p $'\nPress Enter to return to main menu...'
            ;;
        0)
            echo -e "\e[1;33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\e[0m"
            exit 0
            ;;
        *)
            echo -e "\e[1;31mInvalid option!\e[0m"
            ;;
    esac
done
