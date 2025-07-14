#!/bin/bash

# Title Display
clear
echo "═══════════════════════════════════════════════"
echo " Telegram: @Academi_vpn"
echo " Admin: Mahdi"
echo " WARP Real DNS for Gamers"
echo "═══════════════════════════════════════════════"
echo ""
sleep 1

# Define game list
games=(
"Call of Duty Mobile"
"PUBG Mobile"
"Free Fire"
"Fortnite"
"Valorant"
"Apex Legends"
"League of Legends"
"Clash of Clans"
"Clash Royale"
"Mobile Legends"
"Genshin Impact"
"FIFA Mobile"
"Dota 2"
"Overwatch"
"Rocket League"
"Warzone"
"CS:GO"
"Roblox"
"Brawl Stars"
"Among Us"
)

# Select Game
echo "Select your Game:"
select game in "${games[@]}"; do
    [[ -n "$game" ]] && break
done

# Select IP type
echo ""
echo "Choose IP Type:"
select iptype in "IPv4" "IPv6"; do
    [[ -n "$iptype" ]] && break
done

# List of 35 countries
countries=(
"United States" "Germany" "Netherlands" "France" "United Kingdom" "Singapore" "Japan" "Iran"
"UAE" "Russia" "Turkey" "India" "Brazil" "South Korea" "Canada" "Sweden" "Italy" "Spain"
"Poland" "Australia" "Switzerland" "Malaysia" "Finland" "Denmark" "Norway" "Indonesia"
"Philippines" "Thailand" "Ukraine" "Mexico" "Portugal" "Greece" "Austria" "Belgium" "Argentina"
)

# Select Country
echo ""
echo "Select DNS Country:"
select country in "${countries[@]}"; do
    [[ -n "$country" ]] && break
done

# Simulated real DNS database
declare -A dns_list_ipv4
declare -A dns_list_ipv6

# Example DNS values for all countries (ipv4)
dns_list_ipv4["Global"]="1.1.1.1 8.8.8.8 9.9.9.9 94.140.14.14 76.76.2.2 208.67.222.222 1.0.0.1 94.140.15.15"
dns_list_ipv6["Global"]="2606:4700:4700::1111 2001:4860:4860::8888 2620:fe::9 2a10:50c0::ad1:ff 2a10:50c0::ad2:ff 2a00:5a60::ad1:0ff 2a00:5a60::ad2:0ff 2606:4700:4700::1001"

# Output selected DNS
echo ""
echo "═══════════════════════════════════════════════"
echo " Game: $game"
echo " IP Type: $iptype"
echo " Country: $country"
echo ""
echo " Recommended DNS:"

dns_group="Global"

if [[ "$iptype" == "IPv4" ]]; then
    for ip in ${dns_list_ipv4[$dns_group]}; do
        ping_time=$(ping -c 1 -W 1 $ip | grep 'time=' | sed -E 's/.*time=([0-9.]+) ms/\\1/' || echo "timeout")
        echo " $ip  ${ping_time}ms"
    done
else
    for ip in ${dns_list_ipv6[$dns_group]}; do
        ping6_time=$(ping6 -c 1 -W 1 $ip | grep 'time=' | sed -E 's/.*time=([0-9.]+) ms/\\1/' || echo "timeout")
        echo " $ip  ${ping6_time}ms"
    done
fi

echo "═══════════════════════════════════════════════"
