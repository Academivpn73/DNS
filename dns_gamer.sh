#!/bin/bash

clear

# Banner with color rotation and Telegram ID
show_banner() {
    local colors=(31 32 33 34 35 36)
    local color=${colors[$RANDOM % ${#colors[@]}]}
    echo -e "\\e[1;${color}m+--------------------------------------------------+"
    echo -e "| Telegram: @Academi_vpn | Admin: Mahdi | Version: 1.2.4 |"
    echo -e "+--------------------------------------------------+\\e[0m"
}

# List of games (70 + Arena Breakout marked NEW)
declare -A games
games=(
    ["PUBG"]="true"
    ["Call of Duty"]="true"
    ["Fortnite"]="true"
    ["Minecraft"]="true"
    ["Apex Legends"]="true"
    ["Valorant"]="true"
    ["GTA V"]="true"
    ["League of Legends"]="true"
    ["Dota 2"]="true"
    ["Rainbow Six Siege"]="true"
    ["Rocket League"]="true"
    ["Overwatch"]="true"
    ["Among Us"]="true"
    ["CS:GO"]="true"
    ["FIFA 21"]="true"
    ["World of Warcraft"]="true"
    ["Battlefield V"]="true"
    ["Clash of Clans"]="true"
    ["Roblox"]="true"
    ["Minecraft Dungeons"]="true"
    ["Sea of Thieves"]="true"
    ["Destiny 2"]="true"
    ["Diablo III"]="true"
    ["Monster Hunter"]="true"
    ["Hearthstone"]="true"
    ["PUBG Mobile"]="true"
    ["Clash Royale"]="true"
    ["Genshin Impact"]="true"
    ["ARK: Survival Evolved"]="true"
    ["Fall Guys"]="true"
    ["Starcraft II"]="true"
    ["Cyberpunk 2077"]="true"
    ["Terraria"]="true"
    ["World of Tanks"]="true"
    ["The Witcher 3"]="true"
    ["Valorant Mobile"]="true"
    ["Halo Infinite"]="true"
    ["Animal Crossing"]="true"
    ["Pokemon GO"]="true"
    ["League of Legends: Wild Rift"]="true"
    ["Brawl Stars"]="true"
    ["Mobile Legends"]="true"
    ["Among Trees"]="true"
    ["Magic: The Gathering"]="true"
    ["F1 2021"]="true"
    ["Fallout 76"]="true"
    ["Destiny 2 Mobile"]="true"
    ["Subnautica"]="true"
    ["The Division 2"]="true"
    ["Cyber Hunter"]="true"
    ["Dying Light"]="true"
    ["Watch Dogs: Legion"]="true"
    ["Call of Duty Mobile"]="true"
    ["Apex Legends Mobile"]="true"
    ["Valorant Mobile"]="true"
    ["Arena Breakout"]="NEW"
    ["Minecraft Earth"]="true"
    ["PUBG Lite"]="true"
    ["Rainbow Six Extraction"]="true"
    ["Forza Horizon 5"]="true"
    ["Robocraft"]="true"
    ["GTA Online"]="true"
    ["Black Desert Online"]="true"
    ["Rust"]="true"
    ["Fall Guys Ultimate Knockout"]="true"
    ["Dead by Daylight"]="true"
    ["Path of Exile"]="true"
    ["Among Us Mobile"]="true"
    ["Terraria Mobile"]="true"
    ["Minecraft PE"]="true"
    ["League of Legends Mobile"]="true"
)

# Countries list
countries=(
    "USA"
    "UK"
    "Germany"
    "France"
    "Japan"
    "South Korea"
    "China"
    "India"
    "Iran"
    "Brazil"
)

# DNS database: games -> countries -> list of DNS pairs (primary secondary)
# For brevity, 3 DNS pairs per game per country (sample), real one should have more
declare -A dns_db

# Sample DNS entries (replace/add more real DNS as needed)
dns_db["PUBG,USA"]="1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 9.9.9.9 149.112.112.112"
dns_db["PUBG,UK"]="1.1.1.1 1.0.0.1 208.67.222.222 208.67.220.220 8.8.8.8 8.8.4.4"
dns_db["Arena Breakout,Iran"]="9.9.9.9 149.112.112.112 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4"

# Function to get random DNS pair (primary secondary) for given game and country
get_random_dns() {
    local game="$1"
    local country="$2"
    local key="${game},${country}"
    local dns_list="${dns_db[$key]}"

    if [[ -z "$dns_list" ]]; then
        echo "❌ No DNS found for $game in $country"
        return 1
    fi

    # split dns_list into array
    IFS=' ' read -r -a dns_array <<< "$dns_list"
    local count=$(( ${#dns_array[@]} / 2 ))
    local rand_index=$(( RANDOM % count ))

    local primary=${dns_array[$((rand_index*2))]}
    local secondary=${dns_array[$((rand_index*2+1))]}

    echo "$primary $secondary"
}

ping_dns() {
    local ip="$1"
    ping -c 1 -W 1 "$ip" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1
}

select_game() {
    echo "Select a game:"
    local i=1
    for g in "${!games[@]}"; do
        if [[ "${games[$g]}" == "NEW" ]]; then
            echo -e "$i) \e[34m$g (NEW)\e[0m"
        else
            echo "$i) $g"
        fi
        ((i++))
    done
    read -p "Enter choice number: " choice
    local index=1
    for g in "${!games[@]}"; do
        if [[ $index -eq $choice ]]; then
            echo "$g"
            return
        fi
        ((index++))
    done
    echo ""
}

select_country() {
    echo "Select a country:"
    local i=1
    for c in "${countries[@]}"; do
        echo "$i) $c"
        ((i++))
    done
    read -p "Enter choice number: " choice
    if ((choice > 0 && choice <= ${#countries[@]})); then
        echo "${countries[$((choice-1))]}"
    else
        echo ""
    fi
}

show_dns_for_game_country() {
    local game="$1"
    local country="$2"
    local dns_pair
    dns_pair=$(get_random_dns "$game" "$country")
    if [[ $? -ne 0 ]]; then
        echo "$dns_pair"
        return
    fi
    local primary=$(echo $dns_pair | cut -d' ' -f1)
    local secondary=$(echo $dns_pair | cut -d' ' -f2)
    local ping_p=$(ping_dns "$primary")
    echo "Game: $game"
    echo "Country: $country"
    echo "Primary DNS: $primary (Ping: ${ping_p:-timeout} ms)"
    echo "Secondary DNS: $secondary"
}

while true; do
    clear
    show_banner
    echo ""
    echo "Menu:"
    echo "1) Gaming DNS"
    echo "2) Download/Bypass DNS (Coming Soon)"
    echo "3) Premium DNS (Coming Soon)"
    echo "4) Search Game DNS"
    echo "5) Ping DNS"
    echo "0) Exit"
    read -p "> " option

    case $option in
        1)
            game=$(select_game)
            country=$(select_country)
            if [[ -n "$game" && -n "$country" ]]; then
                show_dns_for_game_country "$game" "$country"
            else
                echo "Invalid selection."
            fi
            ;;
        2)
            echo "Download/Bypass DNS not implemented yet."
            ;;
        3)
            echo "Premium DNS not implemented yet."
            ;;
        4)
            game=$(select_game)
            country=$(select_country)
            if [[ -n "$game" && -n "$country" ]]; then
                show_dns_for_game_country "$game" "$country"
            else
                echo "Invalid selection."
            fi
            ;;
        5)
            read -p "Enter DNS IP to ping: " dns_ip
            ping_dns "$dns_ip"
            ;;
        0)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
    echo ""
    read -p "Press enter to continue..."
done
