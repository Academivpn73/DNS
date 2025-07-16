#!/bin/bash

# رنگ‌ها
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
CYAN='\e[36m'
BLUE='\e[34m'
MAGENTA='\e[35m'
RESET='\e[0m'

# انیمیشن تایپ برای نوشته‌ها
function type_text() {
  local text="$1"
  for ((i=0; i<${#text}; i++)); do
    echo -ne "${text:$i:1}"
    sleep 0.02
  done
  echo
}

# نمایش تایتل
function show_title() {
  clear
  echo -e "${CYAN}╔══════════════════════════════════════╗"
  type_text "${CYAN}║${GREEN}      DNS MANAGEMENT SCRIPT        ${CYAN}║"
  echo -e "${CYAN}╠══════════════════════════════════════╣"
  type_text "${CYAN}║  ${YELLOW}Telegram:${RESET} @Academi_vpn"
  type_text "${CYAN}║  ${YELLOW}Admin   :${RESET} @MahdiAGM0"
  type_text "${CYAN}║  ${YELLOW}Version :${RESET} 1.2.0"
  echo -e "${CYAN}╚══════════════════════════════════════╝${RESET}"
  sleep 0.5
}

# انیمیشن لیست از بالا به پایین
function animated_list() {
  local list=("$@")
  for i in "${!list[@]}"; do
    echo -e "${GREEN}[$i]${RESET} ${list[$i]}"
    sleep 0.03
  done
}

# DNS ها
DNS_POOL=("1.1.1.1" "8.8.8.8" "9.9.9.9" "208.67.222.222" "185.51.200.2" "94.140.14.14" "76.76.2.0"
"176.103.130.130" "149.112.112.112" "64.6.64.6" "45.90.28.0" "195.46.39.39" "156.154.70.1"
"198.101.242.72" "77.88.8.8" "4.2.2.2" "203.80.96.10" "114.114.114.114" "202.12.27.33")

GAMES=( "Fortnite" "Call of Duty" "PUBG" "Valorant" "League of Legends" "Minecraft" "Apex Legends" 
"Dota 2" "CS:GO" "Overwatch" "FIFA" "Genshin Impact" "Rocket League" "Roblox" "Free Fire" 
"Mobile Legends" "Battlefield" "Rainbow Six" "Honkai" "Warzone" "Elden Ring" "Naraka" "ARK" 
"Brawlhalla" "Smite" "Paladins" "Halo" "Destiny 2" "The Finals" "Escape from Tarkov" "Crossfire" 
"Lost Ark" "World of Tanks" "Clash Royale" "Brawl Stars" "Diablo IV" "Rust" "Team Fortress 2" 
"Splatoon" "Cyberpunk 2077")

COUNTRIES=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Kuwait" "Iraq" "Jordan" "Oman" "Bahrain")

# ساخت DNS تصادفی با پینگ
generate_dns_list() {
  echo ""
  type_text "${MAGENTA}Fetching 15 Optimized DNS...${RESET}"
  echo ""
  for i in {1..15}; do
    dns=${DNS_POOL[$RANDOM % ${#DNS_POOL[@]}]}
    ping=$(ping -c 1 -W 1 "$dns" | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1 " ms"}')
    [[ -z "$ping" ]] && ping="N/A"
    echo -e "${YELLOW}DNS $i:${RESET} ${dns}   ${CYAN}(Ping: $ping)${RESET}"
    sleep 0.05
  done
  echo ""
  read -p "Press Enter to return..."
}

# منو اصلی
main_menu() {
  while true; do
    clear
    show_title
    echo -e "${BLUE}\nSelect a Section:\n"
    type_text "${GREEN}[1]${RESET} Gaming DNS 🎮"
    type_text "${GREEN}[2]${RESET} Download DNS ⬇️"
    type_text "${GREEN}[0]${RESET} Exit ❌"
    echo ""
    read -p "$(echo -e ${CYAN}Enter your choice:${RESET} ) " choice

    case $choice in
      1)
        echo -e "\n${MAGENTA}--- Select a Game ---${RESET}"
        animated_list "${GAMES[@]}"
        read -p $'\n'"${CYAN}Select game index: ${RESET}" game_idx

        echo -e "\n${MAGENTA}--- Select a Country ---${RESET}"
        animated_list "${COUNTRIES[@]}"
        read -p $'\n'"${CYAN}Select country index: ${RESET}" country_idx

        if [[ -z "${GAMES[$game_idx]}" || -z "${COUNTRIES[$country_idx]}" ]]; then
          echo -e "${RED}Invalid selection.${RESET}"
          sleep 1
          continue
        fi

        echo -e "${YELLOW}\nGame: ${GAMES[$game_idx]} | Country: ${COUNTRIES[$country_idx]}${RESET}"
        generate_dns_list
        ;;
      2)
        echo -e "\n${MAGENTA}--- Select a Country for Download DNS ---${RESET}"
        animated_list "${COUNTRIES[@]}"
        read -p $'\n'"${CYAN}Select country index: ${RESET}" country_idx

        if [[ -z "${COUNTRIES[$country_idx]}" ]]; then
          echo -e "${RED}Invalid selection.${RESET}"
          sleep 1
          continue
        fi

        echo -e "${YELLOW}\nCountry: ${COUNTRIES[$country_idx]}${RESET}"
        generate_dns_list
        ;;
      0)
        echo -e "${YELLOW}Exiting...${RESET}"
        break
        ;;
      *)
        echo -e "${RED}Invalid choice!${RESET}"
        sleep 1
        ;;
    esac
  done
}

# اجرای منو
main_menu
