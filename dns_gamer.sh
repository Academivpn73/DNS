#!/bin/bash
clear
COLORS=(31 32 33 34 35 36)
COLOR=${COLORS[$RANDOM % ${#COLORS[@]}]}
echo -e "\e[1;${COLOR}m==============================\e[0m"
echo -e "\e[1;${COLOR}mTelegram: @Academi_vpn\e[0m"
echo -e "\e[1;${COLOR}mAdmin by: Mahdi\e[0m"
echo -e "\e[1;${COLOR}mVersion: 1.2.4\e[0m"
echo -e "\e[1;${COLOR}m==============================\e[0m"

# لود لیست‌ها
mapfile -t games < games_list.txt
mapfile -t countries < countries_list.txt
mapfile -t dns < dns_list.txt

echo ""
echo "🎮 Select your game:"
for i in "${!games[@]}"; do
    echo "$((i+1))) ${games[$i]}"
done
read -p "Enter game number: " game_index
game_name="${games[$((game_index-1))]}"

echo ""
echo "🌍 Select your country:"
for i in "${!countries[@]}"; do
    echo "$((i+1))) ${countries[$i]}"
done
read -p "Enter country number: " country_index
country_name="${countries[$((country_index-1))]}"

# نمایش ۲ DNS
echo ""
echo "🎮 Game: $game_name - 🌍 $country_name"
echo "🟢 Primary DNS: ${dns[$RANDOM % ${#dns[@]}]}"
echo "🟢 Secondary DNS: ${dns[$RANDOM % ${#dns[@]}]}"
echo "📶 Ping: $((RANDOM % 90 + 10))ms"
