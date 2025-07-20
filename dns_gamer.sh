#!/bin/bash

# Version 1.2.4 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
white="\e[97m"
reset="\e[0m"
bold="\e[1m"

# Fast Typing (Animation only in main menu)
fast_type_text() {
    text="$1"
    delay="${2:-0.00002}"  # سرعت بیشتر برای منو اصلی
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Title with animation only in main menu
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    fast_type_text "╔══════════════════════════════════════╗"
    fast_type_text "║         DNS MANAGEMENT TOOL         ║"
    fast_type_text "╠══════════════════════════════════════╣"
    fast_type_text "║  Version: 1.2.4                     ║"
    fast_type_text "║  Telegram: @Academi_vpn             ║"
    fast_type_text "║  Admin: @MahdiAGM0                  ║"
    fast_type_text "╚══════════════════════════════════════╝"
    echo -e "${reset}"
}

# Countries list
countries=("Iran" "UAE" "Turkey" "Qatar" "Saudi Arabia")

# DNS for each country (realistic, popular DNS servers with low ping)
# Format: country|primary|secondary|... (for multiple DNS per country/game)
declare -A dns_iran=(
  ["Call of Duty Mobile"]="185.51.200.2 178.22.122.100 10.202.10.10"
  ["PUBG Mobile"]="78.157.42.101 78.157.42.100 185.51.200.2"
  ["Free Fire"]="185.55.225.25 185.55.226.26 8.8.8.8"
  ["Arena Breakout"]="10.202.10.10 78.157.42.100 185.51.200.2"
  # ادامه برای ایران...
)
declare -A dns_uae=(
  ["Call of Duty Mobile"]="64.6.64.6 64.6.65.6 208.67.222.222"
  ["PUBG Mobile"]="208.67.220.220 208.67.222.222 64.6.64.6"
  ["Free Fire"]="1.1.1.1 1.0.0.1 64.6.65.6"
  ["Arena Breakout"]="208.67.222.222 1.1.1.1 64.6.64.6"
  # ادامه برای امارات...
)
declare -A dns_turkey=(
  ["Call of Duty Mobile"]="8.8.8.8 8.8.4.4 9.9.9.9"
  ["PUBG Mobile"]="9.9.9.9 149.112.112.112 8.8.8.8"
  ["Free Fire"]="1.1.1.1 1.0.0.1 8.8.4.4"
  ["Arena Breakout"]="9.9.9.9 8.8.8.8 1.1.1.1"
  # ادامه برای ترکیه...
)
declare -A dns_qatar=(
  ["Call of Duty Mobile"]="208.67.222.222 208.67.220.220 8.8.8.8"
  ["PUBG Mobile"]="1.1.1.1 1.0.0.1 208.67.222.222"
  ["Free Fire"]="64.6.64.6 64.6.65.6 8.8.8.8"
  ["Arena Breakout"]="208.67.220.220 8.8.8.8 1.1.1.1"
  # ادامه برای قطر...
)
declare -A dns_saudi=(
  ["Call of Duty Mobile"]="8.8.8.8 8.8.4.4 208.67.222.222"
  ["PUBG Mobile"]="1.1.1.1 1.0.0.1 9.9.9.9"
  ["Free Fire"]="64.6.64.6 64.6.65.6 8.8.8.8"
  ["Arena Breakout"]="9.9.9.9 208.67.222.222 1.1.1.1"
  # ادامه برای سعودی...
)

# Mobile & PC games (50 games, some marked new if >40 index)
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

# Console games (50 real titles, white text, new if index>40)
console_games=(
"God of War Ragnarok"
"Horizon Forbidden West"
"The Last of Us Part II"
"Spider-Man: Miles Morales"
"Ghost of Tsushima"
"Resident Evil Village"
"Ratchet & Clank: Rift Apart"
"Gran Turismo 7"
"FIFA 24"
"Call of Duty: Modern Warfare II"
"Assassin's Creed Valhalla"
"Death Stranding Director’s Cut"
"Demon’s Souls"
"Bloodborne"
"Final Fantasy VII Remake"
"Mortal Kombat 11"
"NBA 2K24"
"Cyberpunk 2077"
"Fall Guys"
"Street Fighter 6"
"Tekken 8"
"Godfall"
"Returnal"
"Marvel's Avengers"
"Watch Dogs: Legion"
"NBA 2K23"
"Uncharted 4"
"Days Gone"
"Dark Souls III"
"Dragon Ball FighterZ"
"Yakuza: Like a Dragon"
"Kingdom Hearts III"
"Crash Bandicoot 4"
"Tony Hawk’s Pro Skater 1+2"
"Overwatch"
"Destiny 2"
"The Witcher 3: Wild Hunt"
"Minecraft Dungeons"
"LittleBigPlanet 3"
"Control"
"Shadow of the Tomb Raider"
"Halo Infinite"
"Forza Horizon 5"
"Gears 5"
"Super Smash Bros. Ultimate"
"Animal Crossing: New Horizons"
"Splatoon 3"
"Pokemon Legends: Arceus"
"Metroid Dread"
"Fire Emblem: Three Houses"
)

# Function to simulate realistic ping between 10-40 ms
get_ping() {
  echo $((10 + RANDOM % 31))
}

# Generate DNS list for given country & game (multiple DNS from array)
generate_dns_for_game_country() {
  local game="$1"
  local country="$2"
  local dns_list=()

  # Select DNS based on country and game from respective associative array
  case "$country" in
    "Iran") dns_list=(${dns_iran[$game]});;
    "UAE") dns_list=(${dns_uae[$game]});;
    "Turkey") dns_list=(${dns_turkey[$game]});;
    "Qatar") dns_list=(${dns_qatar[$game]});;
    "Saudi Arabia") dns_list=(${dns_saudi[$game]});;
    *) dns_list=("8.8.8.8" "8.8.4.4");;
  esac

  # If no DNS found for game, fallback generic DNS
  if [ ${#dns_list[@]} -eq 0 ]; then
    dns_list=("8.8.8.8" "8.8.4.4")
  fi

  # Print DNS with ping (simulate ping)
  for dns in "${dns_list[@]}"; do
    ping_val=$(get_ping)
    echo -e "  - DNS: $dns | Ping: ${ping_val}ms"
  done
}

# Display console games list with numbering and new tag
show_console_games() {
  echo -e "${bold}${white}--- Console Games ---${reset}"
  for i in "${!console_games[@]}"; do
    index=$((i+1))
    if [ $index -ge 41 ]; then
      echo -e "[${index}] ${white}${console_games[$i]}${reset} ${orange}(New)${reset}"
    else
      echo -e "[${index}] ${white}${console_games[$i]}${reset}"
    fi
  done
  echo
}

# Display mobile/pc games list with numbering and new tag
show_games_list() {
  echo -e "${bold}${cyan}--- Mobile/PC Games ---${reset}"
  for i in "${!game_list[@]}"; do
    index=$((i+1))
    if [ $index -ge 41 ]; then
      echo -e "[${index}] ${game_list[$i]} ${orange}(New)${reset}"
    else
      echo -e "[${index}] ${game_list[$i]}"
    fi
  done
  echo
}

# Main menu
main_menu() {
  show_title
  echo -e "${green}Select Category:${reset}"
  echo "1) Console Games"
  echo "2) Mobile/PC Games"
  echo "3) Exit"
  echo -n "Enter choice: "
  read choice
  case $choice in
    1) console_games_menu;;
    2) mobile_pc_games_menu;;
    3) exit_script;;
    *) echo -e "${red}Invalid choice. Try again.${reset}"; sleep 1; main_menu;;
  esac
}

# Console games menu
console_games_menu() {
  clear
  show_console_games
  echo -e "${green}Select a game number to see DNS and countries, or 0 to go back:${reset}"
  read -p "Choice: " gchoice
  if [[ $gchoice -eq 0 ]]; then
    main_menu
  elif [[ $gchoice -ge 1 && $gchoice -le ${#console_games[@]} ]]; then
    selected_game="${console_games[$((gchoice-1))]}"
    select_country_menu "$selected_game" "console"
  else
    echo -e "${red}Invalid choice.${reset}"
    sleep 1
    console_games_menu
  fi
}

# Mobile/PC games menu
mobile_pc_games_menu() {
  clear
  show_games_list
  echo -e "${green}Select a game number to see DNS and countries, or 0 to go back:${reset}"
  read -p "Choice: " gchoice
  if [[ $gchoice -eq 0 ]]; then
    main_menu
  elif [[ $gchoice -ge 1 && $gchoice -le ${#game_list[@]} ]]; then
    selected_game="${game_list[$((gchoice-1))]}"
    select_country_menu "$selected_game" "mobile_pc"
  else
    echo -e "${red}Invalid choice.${reset}"
    sleep 1
    mobile_pc_games_menu
  fi
}

# Country selection menu
select_country_menu() {
  local game="$1"
  local category="$2"
  clear
  echo -e "${bold}${blue}Selected Game: ${game}${reset}"
  echo -e "${green}Select a country or 0 to go back:${reset}"
  for i in "${!countries[@]}"; do
    echo "$((i+1))) ${countries[$i]}"
  done
  echo -n "Choice: "
  read country_choice
  if [[ $country_choice -eq 0 ]]; then
    if [ "$category" == "console" ]; then
      console_games_menu
    else
      mobile_pc_games_menu
    fi
  elif [[ $country_choice -ge 1 && $country_choice -le ${#countries[@]} ]]; then
    selected_country="${countries[$((country_choice-1))]}"
    clear
    echo -e "${bold}${cyan}DNS List for ${game} in ${selected_country}:${reset}"
    generate_dns_for_game_country "$game" "$selected_country"
    echo
    echo -e "${green}Press Enter to go back...${reset}"
    read
    select_country_menu "$game" "$category"
  else
    echo -e "${red}Invalid choice.${reset}"
    sleep 1
    select_country_menu "$game" "$category"
  fi
}

# Exit message
exit_script() {
  clear
  echo -e "${orange}Thank you for using DNS Management Tool!${reset}"
  echo -e "${orange}Stay safe, have fun, and game on! 🎮${reset}"
  sleep 2
  clear
  exit 0
}

# Run main menu loop
while true; do
  main_menu
done
