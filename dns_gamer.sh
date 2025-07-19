#!/bin/bash

# DNS Configurator v1.2.4 by @MahdiAGM0

colors=("\033[1;31m" "\033[1;32m" "\033[1;33m" "\033[1;34m" "\033[1;35m" "\033[1;36m")
nocolor="\033[0m"

function show_title() {
    clear
    color="${colors[$RANDOM % ${#colors[@]}]}"
    echo -e "${color}"
    echo -e "╔══════════════════════════════════════╗"
    echo -e "║       🔥 Gaming DNS Configurator 🔥      ║"
    echo -e "╠══════════════════════════════════════╣"
    echo -e "║   Telegram: @Academi_vpn             ║"
    echo -e "║   Admin:    @MahdiAGM0               ║"
    echo -e "╚══════════════════════════════════════╝"
    echo -e "${nocolor}"
}

countries=("Iran" "UAE" "Turkey" "Saudi Arabia" "Qatar" "Iraq" "Jordan" "Oman" "Bahrain" "Lebanon")

games=(
  "Call of Duty"
  "Arena Breakout"
  "PUBG"
  "Free Fire"
  "Fortnite"
  "Apex Legends"
  "Warzone"
  "CS:GO"
  "Valorant"
  "FIFA"
  "Rainbow Six"
  "Overwatch"
  "League of Legends"
  "Dota 2"
  "Minecraft"
  "Battlefield"
  "Mobile Legends"
  "Rocket League"
  "Clash Royale"
  "Brawl Stars"
  "Roblox"
  "Diablo"
  "World of Tanks"
  "Smite"
  "Escape from Tarkov"
  "Black Desert"
  "CrossFire"
  "World of Warcraft"
  "Team Fortress 2"
  "Paladins"
)

select_country() {
    echo -e "\n🌍 Available Regions:"
    for ((i = 0; i < ${#countries[@]}; i++)); do
        echo "[$((i+1))] ${countries[$i]}"
    done
    read -p $'\nChoose a region number: ' region_idx
    region="${countries[$((region_idx - 1))]}"
    echo -e "\nSelected Region: $region"
}

generate_dns() {
    a=$((RANDOM % 100 + 20))
    b=$((RANDOM % 200 + 50))
    dns1="185.${a}.${b}.1"
    dns2="185.${a}.${b}.2"
}

ping_dns() {
    read -p "Enter DNS to check ping: " dns_to_ping
    echo -e "\nPinging $dns_to_ping...\n"
    ping -c 4 "$dns_to_ping"
}

arena_breakout_dns() {
    dns1="185.202.121.10"
    dns2="185.202.121.11"
}

dns_info() {
    ip=$1
    info=$(curl -s "https://ipinfo.io/$ip?token=demo" | jq -r '.ip + " - " + .country + " - " + .org')
    echo "$info"
}

filter_games() {
    read -p $'\n🔍 Search for a game (press Enter to skip): ' keyword
    filtered=()
    for game in "${games[@]}"; do
        if [[ "$game" =~ ${keyword,,} ]]; then
            filtered+=("$game")
        fi
    done

    if [ ${#filtered[@]} -eq 0 ]; then
        echo -e "❌ No matching game found. Showing all..."
        filtered=("${games[@]}")
    fi

    echo -e "\n🎮 Available Games:"
    for ((i = 0; i < ${#filtered[@]}; i++)); do
        idx=$((i+1))
        if [[ "${filtered[$i]}" == "Arena Breakout" ]]; then
            echo -e "[$idx] \033[1;34m${filtered[$i]}\033[0m"
        else
            echo "[$idx] ${filtered[$i]}"
        fi
    done

    read -p $'\nSelect a game number: ' game_idx
    game="${filtered[$((game_idx - 1))]}"
}

main_menu() {
    while true; do
        show_title
        echo -e "${colors[1]}[1]${nocolor} Gaming DNS 🎮"
        echo -e "${colors[2]}[2]${nocolor} Download DNS ⬇️"
        echo -e "${colors[3]}[3]${nocolor} Premium Gaming DNS ⚡"
        echo -e "${colors[4]}[4]${nocolor} Ping a DNS 📶"
        echo -e "${colors[5]}[0]${nocolor} Exit ❌"

        read -p $'\nSelect an option: ' opt
        case $opt in
            1)
                clear
                filter_games
                select_country
                echo -e "\nGenerating DNS for $game in $region..."
                if [[ "$game" == "Arena Breakout" ]]; then
                    arena_breakout_dns
                else
                    generate_dns
                fi
                echo -e "\n✅ Primary DNS: $dns1"
                echo -e "✅ Secondary DNS: $dns2"
                echo -e "\n🌐 Location Info:"
                echo "• $(dns_info "$dns1")"
                echo "• $(dns_info "$dns2")"
                read -p $'\nPress Enter to return to main menu...' ;;
            2)
                clear
                echo -e "\n⬇️ Download DNS (Bypass Censorship)"
                select_country
                generate_dns
                echo -e "\n✅ Primary DNS: $dns1"
                echo -e "✅ Secondary DNS: $dns2"
                echo -e "\n🌐 Location Info:"
                echo "• $(dns_info "$dns1")"
                echo "• $(dns_info "$dns2")"
                read -p $'\nPress Enter to return to main menu...' ;;
            3)
                clear
                echo -e "\n⚡ Premium Gaming DNS (Ping < 40ms)"
                dns_list=(
                    "103.74.112.241|103.74.112.242"
                    "185.51.200.2|185.51.200.3"
                    "10.202.10.10|10.202.10.11"
                    "178.22.122.100|185.51.200.4"
                    "185.228.168.9|185.228.169.9"
                )
                pick=${dns_list[$RANDOM % ${#dns_list[@]}]}
                dns1="${pick%%|*}"
                dns2="${pick##*|}"
                echo -e "\n✅ Primary DNS: $dns1"
                echo -e "✅ Secondary DNS: $dns2"
                echo -e "\n🌐 Location Info:"
                echo "• $(dns_info "$dns1")"
                echo "• $(dns_info "$dns2")"
                read -p $'\nPress Enter to return to main menu...' ;;
            4)
                clear
                ping_dns
                read -p $'\nPress Enter to return to main menu...' ;;
            0)
                echo -e "${colors[0]}\nGoodbye 🙏🏻${nocolor}"
                exit 0 ;;
            *)
                echo "❌ Invalid option. Try again." ;;
        esac
    done
}

main_menu
