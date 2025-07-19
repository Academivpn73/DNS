#!/bin/bash

GITHUB_BASE_URL="https://raw.githubusercontent.com/USERNAME/REPO/main"

# رنگ‌ها
colors=("\e[31m" "\e[32m" "\e[33m" "\e[34m" "\e[35m" "\e[36m")
reset="\e[0m"
random_color() {
    echo -e "${colors[$RANDOM % ${#colors[@]}]}"
}

# تایتل
show_title() {
    clear
    echo -e "$(random_color)"
    echo "╔═════════════════════════════════════╗"
    echo "║      ACADEMI VPN DNS SYSTEM         ║"
    echo "╠═════════════════════════════════════╣"
    echo "║ Telegram: @Academi_vpn              ║"
    echo "║ Admin:    @MahdiAGM0                ║"
    echo "║ Version:  1.2.3                     ║"
    echo "╚═════════════════════════════════════╝"
    echo -e "${reset}"
}

# خواندن فایل آنلاین
fetch_file() {
    curl -fsSL "$GITHUB_BASE_URL/$1"
}

# نمایش لیست و انتخاب
choose_from_list() {
    local list_file="$1"
    local prompt="$2"
    local list=()
    local index=1
    while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        echo "$index) $line"
        list+=("$line")
        ((index++))
    done < <(fetch_file "$list_file")

    echo ""
    read -p "$prompt [1-${#list[@]}]: " choice
    selected="${list[$((choice - 1))]}"
    echo "$selected"
}

# نمایش DNS رندوم
get_random_dns() {
    local game="$1"
    local country="$2"
    fetch_file "dns_gaming.txt" | grep -i "$game - $country" | shuf -n 2
}

# پینگ گرفتن از DNS
ping_dns() {
    local dns="$1"
    ping -c 1 -W 1 "$dns" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1
}

# منوی اصلی
main_menu() {
    while true; do
        show_title
        echo -e "$(random_color)Please select an option:${reset}"
        echo "1) 🎮 DNS گیمینگ"
        echo "2) 📥 DNS مخصوص دانلود"
        echo "3) 💎 DNS پرمیوم"
        echo "4) 📶 Ping DNS"
        echo "5) 🔍 Search Game"
        echo "6) ❌ خروج"
        read -p "#? " option

        case $option in
            1)
                game=$(choose_from_list "games_list.txt" "🎮 Select a game")
                country=$(choose_from_list "countries.txt" "🌍 Select a country")
                echo -e "\n🔗 $game - $country"
                get_random_dns "$game" "$country" | while read -r dns; do
                    echo "$dns"
                    echo "Ping: $(ping_dns $dns)"
                done
                read -p "Press Enter to return..."
                ;;
            2)
                country=$(choose_from_list "countries.txt" "🌍 Select a country")
                echo -e "\n📥 Premium Download DNS for $country"
                get_random_dns "DOWNLOAD" "$country" | while read -r dns; do
                    echo "$dns"
                    echo "Ping: $(ping_dns $dns)"
                done
                read -p "Press Enter to return..."
                ;;
            3)
                echo -e "\n💎 Premium DNS (Random)"
                get_random_dns "PREMIUM" "GLOBAL" | while read -r dns; do
                    echo "$dns"
                    echo "Ping: $(ping_dns $dns)"
                done
                read -p "Press Enter to return..."
                ;;
            4)
                read -p "📥 Enter DNS IP to ping: " user_dns
                echo "Ping: $(ping_dns $user_dns)"
                read -p "Press Enter to return..."
                ;;
            5)
                read -p "🔍 Enter Game Name: " search_game
                found_game=$(fetch_file "games_list.txt" | grep -i "$search_game")
                if [ -z "$found_game" ]; then
                    echo -e "\e[33m⚠️ Game not found!\e[0m"
                else
                    country=$(choose_from_list "countries.txt" "🌍 Select a country")
                    echo -e "\n🔗 $found_game - $country"
                    get_random_dns "$found_game" "$country" | while read -r dns; do
                        echo "$dns"
                        echo "Ping: $(ping_dns $dns)"
                    done
                fi
                read -p "Press Enter to return..."
                ;;
            6) echo "Bye!" && exit 0 ;;
            *) echo "❌ Invalid option" && sleep 1 ;;
        esac
    done
}

main_menu
