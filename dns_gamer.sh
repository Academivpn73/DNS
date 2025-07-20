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

# Games list (70 games + Arena Breakout marked NEW)
games=(
    "PUBG" "Call of Duty" "Fortnite" "Minecraft" "Apex Legends" "Valorant" "GTA V"
    "League of Legends" "Dota 2" "Rainbow Six Siege" "Rocket League" "Overwatch"
    "Among Us" "CS:GO" "FIFA 21" "World of Warcraft" "Battlefield V" "Clash of Clans"
    "Roblox" "Minecraft Dungeons" "Sea of Thieves" "Destiny 2" "Diablo III"
    "Monster Hunter" "Hearthstone" "PUBG Mobile" "Clash Royale" "Genshin Impact"
    "ARK: Survival Evolved" "Fall Guys" "Starcraft II" "Cyberpunk 2077" "Terraria"
    "World of Tanks" "The Witcher 3" "Valorant Mobile" "Halo Infinite" "Animal Crossing"
    "Pokemon GO" "League of Legends: Wild Rift" "Brawl Stars" "Mobile Legends"
    "Among Trees" "Magic: The Gathering" "F1 2021" "Fallout 76" "Destiny 2 Mobile"
    "Subnautica" "The Division 2" "Cyber Hunter" "Dying Light" "Watch Dogs: Legion"
    "Call of Duty Mobile" "Apex Legends Mobile" "Valorant Mobile" "Arena Breakout (NEW)"
    "Minecraft Earth" "PUBG Lite" "Rainbow Six Extraction" "Forza Horizon 5"
    "Robocraft" "GTA Online" "Black Desert Online" "Rust" "Fall Guys Ultimate Knockout"
    "Dead by Daylight" "Path of Exile" "Among Us Mobile" "Terraria Mobile" "Minecraft PE"
    "League of Legends Mobile"
)

# Countries
countries=("USA" "UK" "Germany" "France" "Japan" "South Korea" "China" "India" "Iran" "Brazil")

# DNS lists for different sections (sample DNS addresses, add more real ones)
declare -A dns_gaming=(
    ["USA"]="1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 9.9.9.9 149.112.112.112"
    ["UK"]="208.67.222.222 208.67.220.220 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4"
    ["Iran"]="9.9.9.9 149.112.112.112 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4"
)

declare -A dns_download=(
    ["USA"]="94.140.14.14 94.140.15.15 77.88.8.8 77.88.8.1"
    ["UK"]="176.103.130.130 176.103.130.131 94.140.14.15 94.140.14.16"
    ["Iran"]="89.233.43.71 89.233.43.71 94.140.14.15 94.140.14.16"
)

declare -A dns_premium=(
    ["USA"]="64.6.64.6 64.6.65.6 209.244.0.3 209.244.0.4"
    ["UK"]="64.6.64.6 64.6.65.6 209.244.0.3 209.244.0.4"
    ["Iran"]="64.6.64.6 64.6.65.6 209.244.0.3 209.244.0.4"
)

# Select function for games or countries
select_from_list() {
    local prompt="$1"
    shift
    local list=("$@")
    echo "$prompt"
    for i in "${!list[@]}"; do
        echo "$((i+1))) ${list[$i]}"
    done
    read -p "Enter choice number: " choice
    if (( choice > 0 && choice <= ${#list[@]} )); then
        echo "${list[$((choice-1))]}"
    else
        echo ""
    fi
}

# Get random DNS pair from dns array for a country
get_random_dns() {
    local section="$1"  # dns_gaming, dns_download, dns_premium
    local country="$2"
    local dns_str

    case $section in
        gaming) dns_str="${dns_gaming[$country]}" ;;
        download) dns_str="${dns_download[$country]}" ;;
        premium) dns_str="${dns_premium[$country]}" ;;
        *) echo "Invalid DNS section"; return 1 ;;
    esac

    if [[ -z "$dns_str" ]]; then
        echo "No DNS found for $country in $section"
        return 1
    fi

    # DNS list is space separated, pairs are 2 DNS addresses
    read -r -a dns_array <<< "$dns_str"
    local pairs_count=$((${#dns_array[@]} / 2))
    local rand_index=$(( RANDOM % pairs_count ))
    local primary=${dns_array[$((rand_index*2))]}
    local secondary=${dns_array[$((rand_index*2+1))]}
    echo "$primary $secondary"
}

ping_dns() {
    local ip="$1"
    ping -c 1 -W 1 "$ip" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1
}

show_dns_section() {
    local section="$1"
    local section_name
    case $section in
        gaming) section_name="Gaming DNS" ;;
        download) section_name="Download/Bypass DNS" ;;
        premium) section_name="Premium DNS" ;;
    esac

    echo "=== $section_name ==="
    local game=""
    if [[ "$section" == "gaming" ]]; then
        game=$(select_from_list "Select a game:" "${games[@]}")
        if [[ -z "$game" ]]; then
            echo "Invalid game selection."
            return
        fi
    fi

    local country=$(select_from_list "Select a country:" "${countries[@]}")
    if [[ -z "$country" ]]; then
        echo "Invalid country selection."
        return
    fi

    echo ""
    if [[ "$section" == "gaming" ]]; then
        echo "Game: $game"
    fi

    local dns_pair
    dns_pair=$(get_random_dns "$section" "$country")
    if [[ $? -ne 0 ]]; then
        echo "$dns_pair"
        return
    fi
    local primary=$(echo $dns_pair | cut -d' ' -f1)
    local secondary=$(echo $dns_pair | cut -d' ' -f2)
    local ping_p=$(ping_dns "$primary")

    echo "Primary DNS: $primary (Ping: ${ping_p:-timeout} ms)"
    echo "Secondary DNS: $secondary"
}

while true; do
    clear
    show_banner
    echo ""
    echo "Menu:"
    echo "1) Gaming DNS"
    echo "2) Download/Bypass DNS"
    echo "3) Premium DNS"
    echo "4) Search Game DNS"
    echo "5) Ping DNS"
    echo "0) Exit"
    read -p "> " option

    case $option in
        1)
            show_dns_section "gaming"
            ;;
        2)
            show_dns_section "download"
            ;;
        3)
            show_dns_section "premium"
            ;;
        4)
            # Search game DNS is same as Gaming DNS here
            show_dns_section "gaming"
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
