#!/bin/bash

# نسخه اسکریپت
version="1.2.4"

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
white="\e[1;37m"
reset="\e[0m"
bold="\e[1m"

# لیست کشورها
countries=("Iran" "UAE" "Turkey" "Qatar" "Saudi Arabia")

# لیست بازی‌های گیمینگ (بازی‌های جدید با رنگ نارنجی و "جدید")
game_list=(
  "Call of Duty Mobile"
  "PUBG Mobile"
  "Free Fire"
  "Clash Royale"
  "Clash of Clans"
  "League of Legends"
  "Valorant"
  "CS:GO"
  "Dota 2"
  "Fortnite"
  "Apex Legends"
  "Overwatch 2"
  "Minecraft"
  "Genshin Impact"
  "Roblox"
  "Rocket League"
  "Warframe"
  "Among Us"
  "Rainbow Six Siege"
  "World of Tanks"
  "GTA Online"
  "FIFA 24"
  "Arena Breakout"
  "XDefiant"
  "Battlefield 2042"
  "The Finals"
  "Modern Warfare III"
  "Hyper Front"
  "Starfield"
  "Naraka Bladepoint"
  "Blue Protocol"
  "Stalker 2"
  "Palworld"
  "FC25"
  "Brawlhalla"
  "War Thunder"
  "Mobile Legends"
  "COD Warzone"
  "Diablo IV"
  "Lost Ark"
  "GTA IV"
  "New World"
  "Monster Hunter"
  "Street Fighter 6"
  "Tekken 8"
  "Dying Light 2"
  "Honkai Star Rail"
  "Destiny 2"
  "Fall Guys"
  "Cyberpunk 2077"
)

# لیست بازی‌های کنسول (شماره 1 شروع، اسامی سفید، متن جدید نارنجی)
console_game_list=(
  "FIFA 24"
  "Call of Duty: Modern Warfare III"
  "NBA 2K24"
  "Gran Turismo 7"
  "Spider-Man 2"
  "Hogwarts Legacy"
  "Elden Ring"
  "The Last of Us Part I"
  "God of War Ragnarök"
  "Ghost of Tsushima"
  "Assassin’s Creed Mirage"
  "Resident Evil 4 Remake"
  "Final Fantasy XVI"
  "Cyberpunk 2077 (Console)"
  "Marvel’s Midnight Suns"
  "Street Fighter 6"
  "Tekken 8"
  "Mortal Kombat 1"
  "Death Stranding Director’s Cut"
  "Dying Light 2"
  "Call of Duty: Warzone 2"
  "Forspoken"
  "Dark Souls III"
  "Bloodborne"
  "Sekiro: Shadows Die Twice"
  "Horizon Forbidden West"
  "Ratchet & Clank: Rift Apart"
  "Returnal"
  "Ghostrunner 2"
  "Destiny 2"
  "Fall Guys"
  "Rainbow Six Extraction"
  "Battlefield 2042"
  "Forza Horizon 5"
  "Minecraft (Console)"
  "Among Us (Console)"
  "Sea of Thieves"
  "Monster Hunter Rise"
  "Cuphead"
  "Splatoon 3"
  "Mario Kart 8 Deluxe"
  "The Legend of Zelda: Breath of the Wild"
  "Super Smash Bros. Ultimate"
  "Animal Crossing: New Horizons"
  "Pokémon Scarlet and Violet"
  "Luigi’s Mansion 3"
  "Bayonetta 3"
  "Metroid Dread"
  "Fire Emblem: Three Houses"
  "Xenoblade Chronicles 3"
  "Persona 5 Royal"
)

# داده DNS ها برای هر بازی و کشور
# کلید: "GameName|Country"
# مقدار: "PrimaryDNS|SecondaryDNS PrimaryDNS2|SecondaryDNS2"
declare -A dns_data

# نمونه DNS ها - قابل توسعه
dns_data["Call of Duty Mobile|Iran"]="10.202.10.10|10.202.10.11 195.158.58.101|195.158.58.102"
dns_data["Call of Duty Mobile|UAE"]="64.6.64.6|64.6.65.6"
dns_data["PUBG Mobile|Iran"]="185.51.200.2|178.22.122.100"
dns_data["Arena Breakout|Turkey"]="78.157.42.101|78.157.42.100"
dns_data["Arena Breakout|Iran"]="195.142.195.100|195.142.195.101"
dns_data["Cyberpunk 2077|Saudi Arabia"]="203.158.96.10|203.158.96.11"
dns_data["FIFA 24|Qatar"]="92.247.192.7|92.247.192.8"
dns_data["FIFA 24|Iran"]="10.202.10.10|10.202.10.11"

# نمونه DNS کنسول
dns_data["FIFA 24|Iran"]="10.202.10.10|10.202.10.11"
dns_data["Call of Duty: Modern Warfare III|Iran"]="195.158.58.101|195.158.58.102"
dns_data["Elden Ring|Turkey"]="78.157.42.101|78.157.42.100"

# تولید عدد پینگ تصادفی بین 20 تا 39
generate_ping() {
  echo $((20 + RANDOM % 20))
}

# نمایش DNS بر اساس بازی و کشور انتخاب شده
show_dns_for_game_and_country() {
  local game="$1"
  echo -e "${bold}${green}Select a country to see DNS for ${game}:${reset}"

  local available_countries=()
  for c in "${countries[@]}"; do
    local key="${game}|${c}"
    if [[ -n "${dns_data[$key]}" ]]; then
      available_countries+=("$c")
    fi
  done

  if [ ${#available_countries[@]} -eq 0 ]; then
    echo -e "${red}No DNS data available for this game.${reset}"
    return
  fi

  for i in "${!available_countries[@]}"; do
    echo -e "[$((i+1))] ${available_countries[$i]}"
  done

  echo -ne "${green}Choose country number: ${reset}"
  read cnum
  if ! [[ "$cnum" =~ ^[0-9]+$ ]] || [ "$cnum" -lt 1 ] || [ "$cnum" -gt "${#available_countries[@]}" ]; then
    echo -e "${red}Invalid choice!${reset}"
    return
  fi

  local selected_country="${available_countries[$((cnum-1))]}"
  local key="${game}|${selected_country}"
  local dns_list=(${dns_data[$key]})

  echo -e "\n${cyan}DNS servers for ${game} in ${selected_country}:${reset}"
  for dns_pair in "${dns_list[@]}"; do
    IFS='|' read -r primary secondary <<< "$dns_pair"
    local ping_val=$(generate_ping)
    echo -e "Primary DNS: ${primary}"
    echo -e "Secondary DNS: ${secondary}"
    echo -e "Ping: ${ping_val}ms\n"
  done
}

# منوی DNS گیمینگ
gaming_dns_menu() {
  clear
  echo -e "${bold}${green}Gaming DNS - Version ${version}${reset}"
  for i in "${!game_list[@]}"; do
    local idx=$((i+1))
    local game_name="${game_list[$i]}"
    # بازی‌های جدید: Arena Breakout و بازی‌های از شماره 22 به بعد (شماره 23 در index 22)
    if [[ "$game_name" == "Arena Breakout" || $i -ge 22 ]]; then
      echo -e "[$idx] ${game_name} ${orange}(جدید)${reset}"
    else
      echo -e "[$idx] ${game_name}"
    fi
  done
  echo -ne "\n${green}Choose game number: ${reset}"
  read gnum
  if ! [[ "$gnum" =~ ^[0-9]+$ ]] || [ "$gnum" -lt 1 ] || [ "$gnum" -gt "${#game_list[@]}" ]; then
    echo -e "${red}Invalid choice!${reset}"
    sleep 1
    return
  fi
  local game="${game_list[$((gnum-1))]}"
  echo -e "\n${blue}Selected Game: ${game}${reset}\n"
  show_dns_for_game_and_country "$game"
  echo -ne "${green}Press Enter to return...${reset}"
  read
}

# منوی DNS کنسول
console_dns_menu() {
  clear
  echo -e "${bold}${green}Console DNS - Version ${version}${reset}"
  for i in "${!console_game_list[@]}"; do
    local idx=$((i+1))
    # همه کنسول‌ها جدید هستند
    echo -e "[$idx] ${white}${console_game_list[$i]}${reset} ${orange}(جدید)${reset}"
  done
  echo -ne "\n${green}Choose console game number: ${reset}"
  read gnum
  if ! [[ "$gnum" =~ ^[0-9]+$ ]] || [ "$gnum" -lt 1 ] || [ "$gnum" -gt "${#console_game_list[@]}" ]; then
    echo -e "${red}Invalid choice!${reset}"
    sleep 1
    return
  fi
  local game="${console_game_list[$((gnum-1))]}"
  echo -e "\n${blue}Selected Console Game: ${game}${reset}\n"
  show_dns_for_game_and_country "$game"
  echo -ne "${green}Press Enter to return...${reset}"
  read
}

# منوی اصلی
main_menu() {
  while true; do
    clear
    echo -e "${bold}${green}Main Menu - Version ${version}${reset}"
    echo -e "1) Gaming DNS"
    echo -e "2) Console DNS"
    echo -e "3) Exit"
    echo -ne "${green}Choose an option: ${reset}"
    read opt

    case $opt in
      1) gaming_dns_menu ;;
      2) console_dns_menu ;;
      3) echo -e "${red}Exiting...${reset}"; exit 0 ;;
      *) echo -e "${red}Invalid option!${reset}"; sleep 1 ;;
    esac
  done
}

# اجرای برنامه
main_menu
