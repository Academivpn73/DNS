#!/bin/bash

# v1.2.3 by @MahdiAGM0

# رنگ‌های ANSI
colors=("\033[1;31m" "\033[1;32m" "\033[1;33m" "\033[1;34m" "\033[1;35m" "\033[1;36m")
nocolor="\033[0m"

# تایتل با انیمیشن سریع
function show_title() {
    clear
    color="${colors[$RANDOM % ${#colors[@]}]}"
    echo -ne "${color}"
    text="🔥 Gaming DNS Configurator 🔥"
    for ((i = 0; i < ${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.005
    done
    echo -e "${nocolor}\nTelegram: @Academi_vpn | Admin: @MahdiAGM0\n"
}

# کشورها (فقط خاورمیانه)
countries=("Iran" "UAE" "Turkey" "Saudi Arabia" "Qatar" "Iraq" "Jordan" "Oman" "Bahrain" "Lebanon")

# بازی‌ها
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

# تابع انتخاب کشور
select_country() {
    echo -e "\nAvailable Regions:"
    for i in "${!countries[@]}"; do
        echo "[$i] ${countries[$i]}"
    done
    read -p $'\nChoose a region number: ' region_idx
    region="${countries[$region_idx]}"
    echo -e "\nSelected Region: $region"
}

# تولید DNS رندوم با پینگ زیر 40
generate_dns() {
    first_octet=$((RANDOM % 100 + 1))
    second_octet=$((RANDOM % 200 + 1))
    dns1="10.${first_octet}.${second_octet}.1"
    dns2="10.${first_octet}.${second_octet}.2"
}

# بررسی پینگ
ping_dns() {
    read -p "Enter DNS to check ping: " dns_to_ping
    echo -e "\nPinging $dns_to_ping...\n"
    ping -c 4 "$dns_to_ping"
}

# DNS مخصوص Arena Breakout
arena_breakout_dns() {
    dns1="185.202.121.10"
    dns2="185.202.121.11"
}

# منوی اصلی
main_menu() {
    while true; do
        show_title
        echo -e "${colors[1]}[1]${nocolor} Gaming DNS 🎮"
        echo -e "${colors[1]}[2]${nocolor} Download DNS ⬇️"
        echo -e "${colors[1]}[3]${nocolor} Paid DNS ⚡"
        echo -e "${colors[1]}[4]${nocolor} Ping a DNS 📶"
        echo -e "${colors[1]}[0]${nocolor} Exit ❌"

        read -p $'\nSelect an option: ' opt
        case $opt in
            1)
                clear
                echo -e "\n🎮 Choose a game:"
                for i in "${!games[@]}"; do
                    if [[ "${games[$i]}" == "Arena Breakout" ]]; then
                        echo -e "[${i}] \033[1;34m${games[$i]}\033[0m"
                    else
                        echo "[$i] ${games[$i]}"
                    fi
                done
                read -p $'\nSelect a game number: ' game_idx
                game="${games[$game_idx]}"
                select_country
                echo -e "\nGenerating DNS for $game in $region..."

                if [[ "$game" == "Arena Breakout" ]]; then
                    arena_breakout_dns
                else
                    generate_dns
                fi

                echo -e "\n✅ Primary DNS: $dns1"
                echo -e "✅ Secondary DNS: $dns2"
                read -p $'\nPress Enter to return to main menu...' ;;
            2)
                clear
                echo -e "\n🌍 Choose a country to get Download DNS:"
                select_country
                echo -e "\nGenerating Download DNS with anti-censorship support..."
                generate_dns
                echo -e "\n✅ Primary DNS: $dns1"
                echo -e "✅ Secondary DNS: $dns2"
                read -p $'\nPress Enter to return to main menu...' ;;
            3)
                clear
                echo -e "\n💸 Premium DNS (Ping < 40ms)"
                dns1="1.2.3.4"
                dns2="5.6.7.8"
                echo -e "\n✅ Primary DNS: $dns1"
                echo -e "✅ Secondary DNS: $dns2"
                read -p $'\nPress Enter to return to main menu...' ;;
            4)
                clear
                ping_dns
                read -p $'\nPress Enter to return to main menu...' ;;
            0)
                echo -e "${colors[2]}\nGoodbye 🙏🏻${nocolor}"
                exit 0 ;;
            *)
                echo "❌ Invalid option. Try again." ;;
        esac
    done
}

main_menu
