
#!/bin/bash

GAMES_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/games_list.txt"
COUNTRIES_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/countries_list.txt"
DNS_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_data.txt"
PREMIUM_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/premium_dns.txt"

clear

# دریافت آنلاین فایل‌ها
curl -fsSL "$GAMES_URL" -o games_list.txt || { echo "❌ Failed to load games list."; exit 1; }
curl -fsSL "$COUNTRIES_URL" -o countries_list.txt || { echo "❌ Failed to load countries list."; exit 1; }
curl -fsSL "$DNS_URL" -o dns_data.txt || { echo "❌ Failed to load DNS data."; exit 1; }
curl -fsSL "$PREMIUM_URL" -o premium_dns.txt || { echo "❌ Failed to load Premium DNS list."; exit 1; }

echo "📋 Select your game:"
cat games_list.txt

echo ""
echo "🌍 Select your country:"
cat countries_list.txt

echo ""
read -p "Enter game number: " game_num
read -p "Enter country number: " country_num

game_name=$(sed -n "${game_num}p" games_list.txt | sed 's/^[0-9]*) *//')
country_name=$(sed -n "${country_num}p" countries_list.txt | sed 's/^[0-9]*) *//')

echo ""
echo "🔍 DNS for $game_name - $country_name:"
grep -A2 "$game_name - $country_name" dns_data.txt || echo "❌ DNS not found for this game/country."

echo ""
echo "🌟 Premium DNS List:"
cat premium_dns.txt
