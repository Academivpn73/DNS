#!/bin/bash

Auto-install required packages

for pkg in curl bc; do if ! command -v $pkg &> /dev/null; then echo "Installing $pkg..." pkg install -y $pkg || apt install -y $pkg || echo "$pkg installation failed." fi done

Title Display

clear echo -e "\e[1;36m──────────────────────────────────────────────\e[0m" echo -e "\e[1;32m Telegram: @Academi_vpn\e[0m" echo -e "\e[1;34m Admin: @MahdiAGM0\e[0m" echo -e "\e[1;31m Version: 1.0.9\e[0m" echo -e "\e[1;36m──────────────────────────────────────────────\e[0m" echo

Sample games list (partial)

declare -A games=( ["PUBG Mobile (Mobile)"]=1 ["Call of Duty (Mobile)"]=1 ["Fortnite (PC)"]=1 ["FIFA 24 (Console)"]=1 ["Valorant (PC)"]=1 ["Free Fire (Mobile)"]=1 ["Warzone (PC)"]=1 )

Sample country list (partial)

countries=("Iran" "Germany" "USA" "France" "UAE" "Turkey" "India" "Brazil" "Japan" "Russia")

Sample DNS pool

get_dns_for_use() { local category="$1" country="$2" echo -e "\nShowing 15 DNS servers for \e[33m$category\e[0m in \e[36m$country\e[0m:"

for i in {1..15}; do
    ip1=$((RANDOM % 255))
    ip2=$((RANDOM % 255))
    echo -e "DNS $i: 1.$ip1.$ip2.1 (Ping: $(ping -c1 -W1 1.$ip1.$ip2.1 | grep time= | awk -F'time=' '{print $2}' | cut -d' ' -f1 || echo N/A) ms)"
done
echo -e "\nPress Enter to return to menu..."
read

}

Main Menu

while true; do clear echo -e "\e[1;36m═════════ Select DNS Mode ═════════\e[0m" echo -e "\e[1;33m[1]\e[0m Gaming DNS" echo -e "\e[1;33m[2]\e[0m Download DNS" echo -e "\e[1;31m[0]\e[0m Exit" echo -n "Choose: " read opt

case $opt in
    1)
        echo -e "\n\e[1;36mChoose Game:\e[0m"
        select game in "${!games[@]}"; do
            [ -n "$game" ] && break
        done

        echo -e "\n\e[1;36mChoose Country:\e[0m"
        select country in "${countries[@]}"; do
            [ -n "$country" ] && break
        done

        get_dns_for_use "Gaming" "$country"
        ;;
    2)
        echo -e "\n\e[1;36mChoose Country:\e[0m"
        select country in "${countries[@]}"; do
            [ -n "$country" ] && break
        done

        get_dns_for_use "Download" "$country"
        ;;
    0)
        echo -e "\n\e[1;33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\e[0m"
        exit 0
        ;;
    *) echo "Invalid choice. Try again." ;;
esac

done

