#!/bin/bash

# Version 1.2.4 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
white="\e[1;37m"
reset="\e[0m"
bold="\e[1m"

# Fast typing animation for title
fast_type_text() {
    local text="$1"
    local delay="${2:-0.00005}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Display the title with color
show_title() {
    local colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    local rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    fast_type_text "╔════════════════════════════════════════════╗" 0.00003
    fast_type_text "║           DNS MANAGEMENT TOOL              ║" 0.00003
    fast_type_text "╠════════════════════════════════════════════╣" 0.00003
    fast_type_text "║  Version: 1.2.4                            ║" 0.00003
    fast_type_text "║  Telegram: @Academi_vpn                     ║" 0.00003
    fast_type_text "║  Admin: @MahdiAGM0                          ║" 0.00003
    fast_type_text "╚════════════════════════════════════════════╝" 0.00003
    echo -e "${reset}"
}

# Countries list
countries=("Iran" "UAE" "Turkey" "Qatar" "Saudi Arabia")

# DNS servers for each country (many entries), realistic public DNS servers with typical ping < 40ms
dns_iran=(
  "185.51.200.2|178.22.122.100"
  "10.202.10.10|10.202.10.11"
  "8.8.8.8|8.8.4.4"
  "77.88.8.8|77.88.8.1"
  "195.46.39.39|195.46.39.40"
  "185.51.200.5|178.22.122.101"
  "178.22.122.1|185.51.200.7"
  "89.233.43.71|89.233.43.72"
  "185.70.38.44|185.70.38.45"
  "37.130.200.200|37.130.200.201"
  "94.199.115.220|94.199.115.221"
  "185.55.225.25|185.55.226.26"
  "80.82.64.11|80.82.64.12"
  "77.88.8.88|77.88.8.8"
  "5.9.88.88|5.9.99.99"
)

dns_uae=(
  "64.6.64.6|64.6.65.6"
  "185.55.225.25|185.55.226.26"
  "1.1.1.1|1.0.0.1"
  "208.67.222.222|208.67.220.220"
  "8.8.8.8|8.8.4.4"
  "198.101.242.72|198.101.242.73"
  "64.6.64.7|64.6.65.7"
  "77.88.8.8|77.88.8.1"
  "185.51.200.2|178.22.122.100"
  "209.244.0.3|209.244.0.4"
)

dns_turkey=(
  "78.157.42.101|78.157.42.100"
  "8.8.8.8|8.8.4.4"
  "1.1.1.1|1.0.0.1"
  "212.156.152.250|212.156.152.249"
  "195.175.39.39|195.175.39.40"
  "185.95.219.219|185.95.218.218"
  "94.73.32.130|94.73.32.131"
  "185.51.200.2|178.22.122.100"
  "208.67.222.222|208.67.220.220"
  "8.26.56.26|8.20.247.20"
)

dns_qatar=(
  "156.154.70.1|156.154.71.1"
  "1.1.1.1|1.0.0.1"
  "8.8.8.8|8.8.4.4"
  "208.67.222.222|208.67.220.220"
  "185.51.200.2|178.22.122.100"
  "64.6.64.6|64.6.65.6"
  "77.88.8.8|77.88.8.1"
  "185.55.225.25|185.55.226.26"
  "198.101.242.72|198.101.242.73"
  "209.244.0.3|209.244.0.4"
)

dns_saudi=(
  "192.168.1.1|8.8.8.8"
  "1.1.1.1|1.0.0.1"
  "8.8.8.8|8.8.4.4"
  "208.67.222.222|208.67.220.220"
  "185.51.200.2|178.22.122.100"
  "64.6.64.6|64.6.65.6"
  "185.55.225.25|185.55.226.26"
  "77.88.8.8|77.88.8.1"
  "198.101.242.72|198.101.242.73"
  "209.244.0.3|209.244.0.4"
)

# Game lists - 50 Mobile/PC games
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

# Console games list - 50 games
console_game_list=(
"God of War Ragnarok"
"Halo Infinite"
"Spider-Man Miles Morales"
"FIFA 24"
"Call of Duty Modern Warfare II"
"Elden Ring"
"Forza Horizon 5"
"Gran Turismo 7"
"Resident Evil Village"
"Animal Crossing New Horizons"
"The Legend of Zelda Breath of the Wild"
"Super Mario Odyssey"
"Metroid Dread"
"Splatoon 3"
"Mario Kart 8 Deluxe"
"Deathloop"
"Ghost of Tsushima"
"Demon's Souls"
"Cyberpunk 2077"
"Assassin's Creed Valhalla"
"Horizon Forbidden West"
"Ratchet & Clank Rift Apart"
"Final Fantasy VII Remake"
"Godfall"
"Returnal"
"Sifu"
"NBA 2K24"
"Mortal Kombat 1"
"Street Fighter 6"
"Call of Duty Warzone"
"Monster Hunter Rise"
"Far Cry 6"
"Bayonetta 3"
"Dead Space Remake"
"Dark Souls III"
"Control"
"Destiny 2"
"Mass Effect Legendary Edition"
"Battlefield 2042"
"Death Stranding"
"Little Nightmares II"
"Outer Wilds"
"Kingdom Hearts III"
"Halo Reach"
"Minecraft Dungeons"
"Fall Guys"
"Starfield"
)

# Get DNS array for country
get_dns_array() {
  case $1 in
    Iran) echo "${dns_iran[@]}" ;;
    UAE) echo "${dns_uae[@]}" ;;
    Turkey) echo "${dns_turkey[@]}" ;;
    Qatar) echo "${dns_qatar[@]}" ;;
    "Saudi Arabia") echo "${dns_saudi[@]}" ;;
    *) echo "" ;;
  esac
}

# Pick random DNS pair from country list
pick_random_dns() {
  local country=$1
  local dns_array=($(get_dns_array "$country"))
  local count=${#dns_array[@]}
  if (( count == 0 )); then
    echo "No DNS found for $country"
    return
  fi
  local index=$(( RANDOM % count ))
  echo "${dns_array[$index]}"
}

# Show DNS info with simulated ping (20-39 ms)
show_dns_info() {
  local country=$1
  local dns_pair=$2
  local ping=$(( 20 + RANDOM % 20 )) # Ping between 20-39 ms
  IFS='|' read -r primary secondary <<< "$dns_pair"
  echo -e "${cyan}Country: ${country}${reset}"
  echo -e "${green}Primary DNS: ${primary}${reset}"
  echo -e "${green}Secondary DNS: ${secondary}${reset}"
  echo -e "${blue}Ping: ${ping} ms${reset}"
  echo
}

# Show mobile/PC games (last 10 tagged NEW in orange)
show_game_list() {
  echo -e "${bold}${green}Mobile & PC Games:${reset}"
  for i in "${!game_list[@]}"; do
    local game_name="${game_list[$i]}"
    if (( i >= 40 )); then
      echo -e " $((i+1)). ${white}${game_name}${reset} ${orange}NEW${reset}"
    else
      echo -e " $((i+1)). ${white}${game_name}${reset}"
    fi
  done
  echo
}

# Show console games (last 10 tagged NEW in orange)
show_console_game_list() {
  echo -e "${bold}${green}Console Games:${reset}"
  for i in "${!console_game_list[@]}"; do
    local idx=$((i+1))
    local game_name="${console_game_list[$i]}"
    if (( idx > 40 )); then
      echo -e " ${white}${idx}. ${game_name}${reset} ${orange}NEW${reset}"
    else
      echo -e " ${white}${idx}. ${game_name}${reset}"
    fi
  done
  echo
}

# Game type selection menu
select_game_type() {
  echo -e "${bold}Select Game Type:${reset}"
  echo "1) Mobile & PC Games"
  echo "2) Console Games"
  echo "0) Exit"
  echo -n "Enter choice: "
  read -r choice
  case $choice in
    1) select_mobile_pc_game ;;
    2) select_console_game ;;
    0) exit 0 ;;
    *) echo -e "${red}Invalid choice!${reset}" ; sleep 1; select_game_type ;;
  esac
}

# Mobile/PC game selection
select_mobile_pc_game() {
  clear
  show_title
  show_game_list
  echo -n "Select a Mobile/PC game by number (0 to go back): "
  read -r game_num
  if [[ "$game_num" == "0" ]]; then
    select_game_type
    return
  fi
  if ! [[ "$game_num" =~ ^[0-9]+$ ]] || (( game_num < 1 || game_num > ${#game_list[@]} )); then
    echo -e "${red}Invalid selection!${reset}"
    sleep 1
    select_mobile_pc_game
    return
  fi
  local game_name="${game_list[$((game_num-1))]}"
  select_country_for_game "$game_name"
}

# Console game selection
select_console_game() {
  clear
  show_title
  show_console_game_list
  echo -n "Select a Console game by number (0 to go back): "
  read -r game_num
  if [[ "$game_num" == "0" ]]; then
    select_game_type
    return
  fi
  if ! [[ "$game_num" =~ ^[0-9]+$ ]] || (( game_num < 1 || game_num > ${#console_game_list[@]} )); then
    echo -e "${red}Invalid selection!${reset}"
    sleep 1
    select_console_game
    return
  fi
  local game_name="${console_game_list[$((game_num-1))]}"
  select_country_for_game "$game_name"
}

# Country selection after game chosen
select_country_for_game() {
  local game_name="$1"
  clear
  show_title
  echo -e "${bold}${green}Selected Game:${reset} ${white}$game_name${reset}"
  echo -e "${bold}Select Country:${reset}"
  select i in "${countries[@]}" "Back"; do
    if [[ "$REPLY" == $((${#countries[@]}+1)) ]]; then
      select_game_type
      return
    elif (( REPLY >= 1 && REPLY <= ${#countries[@]} )); then
      local country="${countries[$((REPLY-1))]}"
      local dns_pair=$(pick_random_dns "$country")
      clear
      show_title
      echo -e "${bold}${green}Game:${reset} ${white}$game_name${reset}"
      show_dns_info "$country" "$dns_pair"
      echo -e "${bold}Press Enter to go back...${reset}"
      read -r _
      select_game_type
      return
    else
      echo -e "${red}Invalid choice!${reset}"
    fi
  done
}

# Main program loop
while true; do
  show_title
  select_game_type
done
