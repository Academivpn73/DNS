#!/bin/bash

# ==========[ Colors & Helpers ]============
colors=(
  '\033[0;31m' # Red
  '\033[0;32m' # Green
  '\033[0;33m' # Yellow
  '\033[0;34m' # Blue
  '\033[0;35m' # Magenta
  '\033[0;36m' # Cyan
)

RESET='\033[0m'

rand_color() {
  echo -ne "${colors[$RANDOM % ${#colors[@]}]}"
}

type_text() {
  local text="$1"
  local color="${2:-$RESET}"
  for ((i=0; i<${#text}; i++)); do
    echo -ne "${color}${text:$i:1}${RESET}"
    sleep 0.005
  done
  echo
}

slow_scroll_list() {
  local list=("$@")
  for item in "${list[@]}"; do
    type_text "$item" "$(rand_color)"
    sleep 0.04
  done
}

# ==========[ DNS DATA ]============
gaming_dns=(
  "1.1.1.1"
  "8.8.8.8"
  "8.8.4.4"
  "9.9.9.9"
  "94.140.14.14"
  "1.0.0.1"
  "208.67.222.222"
  "208.67.220.220"
  "76.76.19.19"
  "76.223.122.150"
  "4.2.2.1"
  "4.2.2.2"
  "4.2.2.3"
  "185.228.168.9"
  "37.235.1.174"
)

download_dns=(
  "1.1.1.2"
  "9.9.9.11"
  "208.67.222.123"
  "8.26.56.26"
  "64.6.64.6"
  "77.88.8.8"
  "156.154.70.1"
  "91.239.100.100"
  "89.233.43.71"
  "185.228.168.10"
  "94.140.14.15"
  "45.90.28.0"
  "76.76.2.0"
  "185.213.26.187"
  "94.130.180.225"
)

# ==========[ Title ]============
show_title() {
  clear
  echo -e "$(rand_color)╔══════════════════════════════════════╗${RESET}"
  type_text "║        DNS MANAGEMENT SCRIPT       ║" "$(rand_color)"
  echo -e "$(rand_color)╠══════════════════════════════════════╣${RESET}"
  type_text "║  Telegram: @Academi_vpn             ║" "$(rand_color)"
  type_text "║  Admin   : @MahdiAGM0               ║" "$(rand_color)"
  type_text "║  Version : 1.2.0                    ║" "$(rand_color)"
  echo -e "$(rand_color)╚══════════════════════════════════════╝${RESET}"
  echo
}

# ==========[ Game List ]============
game_list=(
  "Call of Duty (PC/Mobile/Console)"
  "Fortnite (PC/Console)"
  "PUBG (Mobile/PC)"
  "Apex Legends (PC/Console)"
  "Valorant (PC)"
  "League of Legends (PC)"
  "Dota 2 (PC)"
  "Overwatch 2 (PC/Console)"
  "Minecraft (PC/Console)"
  "GTA Online (PC/Console)"
  "CS:GO (PC)"
  "Battlefield V (PC/Console)"
  "FIFA 24 (PC/Console)"
  "eFootball 2024 (Mobile/Console)"
  "Rainbow Six Siege (PC/Console)"
  "Warframe (PC/Console)"
  "Roblox (PC/Mobile)"
  "Rocket League (PC/Console)"
  "Paladins (PC)"
  "Smite (PC)"
  "Black Desert Online (PC)"
  "Destiny 2 (PC)"
  "World of Tanks (PC)"
  "Lost Ark (PC)"
  "The Division 2 (PC)"
  "Tarkov (PC)"
  "War Thunder (PC)"
  "Brawlhalla (PC/Console)"
  "Arena of Valor (Mobile)"
  "Mobile Legends (Mobile)"
  "Free Fire (Mobile)"
  "Clash Royale (Mobile)"
  "Clash of Clans (Mobile)"
  "Honkai Impact (Mobile)"
  "Genshin Impact (Mobile/PC)"
  "Asphalt 9 (Mobile)"
  "Real Racing 3 (Mobile)"
  "Wild Rift (Mobile)"
  "Arena Breakout (Mobile)"
)

# ==========[ Main Menu ]============
main_menu() {
  echo
  type_text "[1] Gaming DNS 🎮" "$(rand_color)"
  type_text "[2] Download DNS ⬇️" "$(rand_color)"
  type_text "[0] Exit ❌" "$(rand_color)"
  echo -ne "$(rand_color)Choose an option: $RESET"
  read opt
  case $opt in
    1) gaming_menu ;;
    2) download_menu ;;
    0) exit_script ;;
    *) echo -e "${colors[0]}Invalid option...$RESET" && sleep 1 && main_menu ;;
  esac
}

# ==========[ Gaming DNS ]============
gaming_menu() {
  clear
  show_title
  echo -e "$(rand_color)[🎮 Game List]${RESET}"
  slow_scroll_list "${game_list[@]}"
  echo -e "\n$(rand_color)Fetching 15 optimized DNS for gaming...$RESET"
  sleep 1
  for i in {0..14}; do
    dns=${gaming_dns[$i]}
    ping=$(ping -c 1 -W 1 "$dns" | grep 'time=' | cut -d'=' -f4 | cut -d' ' -f1)
    [[ -z "$ping" ]] && ping="N/A"
    type_text "DNS $((i+1)): $dns  (Ping: ${ping} ms)" "$(rand_color)"
    sleep 0.03
  done
  echo
  read -p "Press Enter to return to menu..." && clear && show_title && main_menu
}

# ==========[ Download DNS ]============
download_menu() {
  clear
  show_title
  echo -e "$(rand_color)Fetching 15 high-speed DNS for downloading...$RESET"
  sleep 1
  for i in {0..14}; do
    dns=${download_dns[$i]}
    ping=$(ping -c 1 -W 1 "$dns" | grep 'time=' | cut -d'=' -f4 | cut -d' ' -f1)
    [[ -z "$ping" ]] && ping="N/A"
    type_text "DNS $((i+1)): $dns  (Ping: ${ping} ms)" "$(rand_color)"
    sleep 0.03
  done
  echo
  read -p "Press Enter to return to menu..." && clear && show_title && main_menu
}

# ==========[ Exit ]============
exit_script() {
  echo -e "\n\033[1;33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\033[0m"
  exit
}

# ==========[ Run ]============
show_title
main_menu
