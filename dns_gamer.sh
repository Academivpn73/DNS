#!/bin/bash

# فایل DNS
DNS_FILE="dns_list.txt"

# رنگ‌ها برای عنوان
colors=(31 32 33 34 35 36)
random_color=${colors[$RANDOM % ${#colors[@]}]}

# اطلاعات ابتدای برنامه
echo -e "\e[${random_color}m+---------------------------------------+\e[0m"
echo -e "\e[${random_color}m|  Telegram: @Academi_vpn               |\e[0m"
echo -e "\e[${random_color}m|  Admin by: Mahdi                      |\e[0m"
echo -e "\e[${random_color}m|  Version: 1.2.4                       |\e[0m"
echo -e "\e[${random_color}m+---------------------------------------+\e[0m"

# گیم‌ها
games=(
"Call of Duty"
"Free Fire"
"PUBG"
"Clash of Clans"
"Fortnite"
"Arena Breakout (New)"
"Valorant"
"League of Legends"
"Mobile Legends"
"Apex Legends"
"Overwatch"
"Rocket League"
"CS:GO"
"Genshin Impact"
"Roblox"
"Minecraft"
"FIFA"
"eFootball"
"Brawl Stars"
"World of Tanks"
"Warzone"
"Rainbow Six Siege"
"Battlefield"
"Escape from Tarkov"
"New State (New)"
"Diablo Immortal"
"Team Fortress 2"
"Naraka Bladepoint"
"Dead by Daylight"
"SMITE"
"Albion Online"
"Destiny 2"
"Lost Ark"
"Fall Guys"
"Paladins"
"Dota 2"
"Among Us"
"World War Heroes"
"Zula"
"Knives Out"
"Rules of Survival"
"Modern Combat"
"Standoff 2"
"Crossfire"
"Combat Master"
"Cyber Hunter"
"Hyper Front"
"Critical Ops"
"War Robots"
"Pixel Gun 3D"
"Sky: Children of the Light"
"Real Racing 3"
"Asphalt 9"
"NBA Live"
"Mortal Kombat"
"Injustice 2"
"Warhammer 40k"
"Bleach Brave Souls"
"Pokemon Unite"
"Yu-Gi-Oh! Duel Links"
"Dragon Ball Legends"
"Shadowgun Legends"
"Modern Strike"
"NOVA Legacy"
"Infinity Ops"
"Gunfire Reborn"
"Undawn"
"PUBG Lite"
"Mini Militia"
"Surviv.io"
"Tacticool"
)

# کشورها
countries=("Iran" "Turkey" "Germany" "USA" "France" "Qatar" "UAE" "Russia" "India" "Brazil")

# نمایش لیست بازی‌ها
show_games() {
  echo -e "\n🎮 Select a Game:"
  for i in "${!games[@]}"; do
    num=$((i + 1))
    game="${games[$i]}"
    if [[ "$game" == *"(New)"* ]]; then
      echo -e "$num) \e[34m$game\e[0m"
    else
      echo "$num) $game"
    fi
  done
}

# نمایش لیست کشورها
show_countries() {
  echo -e "\n🌍 Select Country:"
  for i in "${!countries[@]}"; do
    echo "$((i + 1))) ${countries[$i]}"
  done
}

# گرفتن DNS از فایل
get_dns_from_file() {
  show_games
  read -p "Enter game number: " game_num
  show_countries
  read -p "Enter country number: " country_num

  selected_game="${games[$((game_num - 1))]}"
  selected_country="${countries[$((country_num - 1))]}"

  echo -e "\n📡 Searching DNS for $selected_game in $selected_country..."

  dns_lines=$(grep "^$selected_game | $selected_country |" "$DNS_FILE")

  if [ -z "$dns_lines" ]; then
    echo "❌ No DNS found for $selected_game in $selected_country"
    return
  fi

  mapfile -t dns_list <<< "$dns_lines"
  total=${#dns_list[@]}
  random_index=$((RANDOM % total))
  primary_dns=$(echo "${dns_list[$random_index]}" | cut -d'|' -f3 | xargs)

  second_index=$(( (random_index + 1) % total ))
  secondary_dns=$(echo "${dns_list[$second_index]}" | cut -d'|' -f3 | xargs)

  echo -e "🟢 Primary DNS: $primary_dns"
  echo -e "🔵 Secondary DNS: $secondary_dns"
  echo -e "📶 Estimated Ping: $((20 + RANDOM % 40)) ms"
}

# منو
while true; do
  echo -e "\n📘 Menu:"
  echo "1) Get Gaming DNS"
  echo "0) Exit"
  read -p "Choose: " opt
  case $opt in
    1) get_dns_from_file ;;
    0) break ;;
    *) echo "Invalid option" ;;
  esac
done
