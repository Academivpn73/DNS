#!/bin/bash

# Colors
colors=(31 32 33 34 35 36)
color=${colors[$RANDOM % ${#colors[@]}]}
box_line="------------------------------------------"

# Title
clear
echo -e "\e[1;${color}m$box_line"
echo -e "|         DNS Utility Script v1.2.3        |"
echo -e "|   Telegram: @Academi_vpn                 |"
echo -e "|   Admin:    @MahdiAGM0                   |"
echo -e "$box_line\e[0m"
echo ""

# DNS File
DNS_FILE="dns_list.txt"
if [[ ! -f $DNS_FILE ]]; then
    echo "Missing dns_list.txt. Please place it in the same folder."
    exit 1
fi

# Main Menu
while true; do
    echo -e "\nChoose an option:"
    echo "1. 🎮 DNS for Gaming"
    echo "2. 📥 DNS for Downloading"
    echo "3. 💎 Premium DNS (NEW)"
    echo "4. 📶 Ping a DNS (NEW)"
    echo "5. 🔍 Search Game (NEW)"
    echo "0. Exit"
    read -p "Enter choice: " choice

    case $choice in
        1)
            echo -e "\n🎮 Available Games:"
            mapfile -t games < <(awk -F',' '$5=="Gaming"{print $1}' "$DNS_FILE" | sort -u)
            i=1
            for game in "${games[@]}"; do
                if [[ "$game" == "Arena Breakout" ]]; then
                    echo -e "$i. \e[36m$game (NEW)\e[0m"
                else
                    echo "$i. $game"
                fi
                ((i++))
            done
            read -p "Select game: " game_index
            game="${games[$((game_index-1))]}"

            echo -e "\n🌍 Choose Country:"
            mapfile -t countries < <(awk -F',' -v g="$game" '$1==g{print $2}' "$DNS_FILE" | sort -u)
            i=1
            for c in "${countries[@]}"; do echo "$i. $c"; ((i++)); done
            read -p "Select country: " country_index
            country="${countries[$((country_index-1))]}"

            dns=$(awk -F',' -v g="$game" -v c="$country" '$1==g && $2==c{print $3" "$4}' "$DNS_FILE" | shuf -n1)
            echo -e "\nRecommended DNS for $game ($country):"
            echo "Primary DNS:  $(echo $dns | cut -d' ' -f1)"
            echo "Secondary DNS: $(echo $dns | cut -d' ' -f2)"
            read -p "Press Enter to return..."
            ;;

        2)
            echo -e "\n🌍 Choose Country:"
            mapfile -t dl_countries < <(awk -F',' '$5=="Download"{print $2}' "$DNS_FILE" | sort -u)
            i=1
            for c in "${dl_countries[@]}"; do echo "$i. $c"; ((i++)); done
            read -p "Select country: " country_index
            country="${dl_countries[$((country_index-1))]}"

            dns=$(awk -F',' -v c="$country" '$2==c && $5=="Download"{print $3" "$4}' "$DNS_FILE" | shuf -n1)
            echo -e "\nRecommended DNS for Downloads ($country):"
            echo "Primary DNS:  $(echo $dns | cut -d' ' -f1)"
            echo "Secondary DNS: $(echo $dns | cut -d' ' -f2)"
            read -p "Press Enter to return..."
            ;;

        3)
            echo -e "\n💎 Premium DNS:"
            dns=$(awk -F',' '$5=="Premium"{print $3" "$4}' "$DNS_FILE" | shuf -n1)
            echo "Primary DNS:  $(echo $dns | cut -d' ' -f1)"
            echo "Secondary DNS: $(echo $dns | cut -d' ' -f2)"
            read -p "Press Enter to return..."
            ;;

        4)
            read -p "Enter DNS to ping: " pingdns
            echo -e "\nPinging $pingdns..."
            ping -c 1 $pingdns | grep "time=" || echo "Ping failed."
            read -p "Press Enter to return..."
            ;;

        5)
            read -p "Enter game name to search: " search_game
            found=$(awk -F',' -v g="$search_game" '$1==g{print $0}' "$DNS_FILE")
            if [[ -z "$found" ]]; then
                echo -e "\e[33mGame not found.\e[0m"
                read -p "Press Enter to return..."
            else
                echo -e "\n🌍 Choose Country:"
                mapfile -t countries < <(awk -F',' -v g="$search_game" '$1==g{print $2}' "$DNS_FILE" | sort -u)
                i=1
                for c in "${countries[@]}"; do echo "$i. $c"; ((i++)); done
                read -p "Select country: " cidx
                country="${countries[$((cidx-1))]}"
                dns=$(awk -F',' -v g="$search_game" -v c="$country" '$1==g && $2==c{print $3" "$4}' "$DNS_FILE" | shuf -n1)
                echo -e "\nRecommended DNS for $search_game ($country):"
                echo "Primary DNS:  $(echo $dns | cut -d' ' -f1)"
                echo "Secondary DNS: $(echo $dns | cut -d' ' -f2)"
                read -p "Press Enter to return..."
            fi
            ;;

        0) exit ;;
        *) echo "Invalid option." ;;
    esac
done
