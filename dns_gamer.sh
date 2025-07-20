#!/bin/bash

# Version 1.2.3 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;214m"
reset="\e[0m"
bold="\e[1m"

# Typing animation
type_text() {
    text="$1"
    delay="${2:-0.0003}"  # سرعت تایپ کمی سریع‌تر شد
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Random colored title
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    type_text "╔══════════════════════════════════════╗" 0.0003
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0003
    type_text "╠══════════════════════════════════════╣" 0.0003
    type_text "║  Version: 1.2.3                      ║" 0.0003
    type_text "║  Telegram: @Academi_vpn             ║" 0.0003
    type_text "║  Admin: @MahdiAGM0                  ║" 0.0003
    type_text "╚══════════════════════════════════════╝" 0.0003
    echo -e "${reset}"
}

# Games (original + 10 new games including Arena Breakout)
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Rainbow Six Siege" "Apex Legends"
  "Rocket League" "Minecraft" "Genshin Impact" "Battlefield V" "Roblox"
  "FIFA 24" "Warzone" "Escape from Tarkov" "War Thunder" "Destiny 2"
  "Smite" "Halo Infinite" "Fall Guys" "Paladins" "World of Warcraft"
  "Elden Ring" "Cyberpunk 2077" "ARK" "Sea of Thieves" "Diablo IV"
  # New games
  "Arena Breakout" "New Game 1" "New Game 2" "New Game 3" "New Game 4"
  "New Game 5" "New Game 6" "New Game 7" "New Game 8" "New Game 9" "New Game 10"
)

countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan")

# DNS Pools
dns_pool_game=(
  "10.202.10.10 10.202.10.11"
  "78.157.42.101 78.157.42.100"
  "185.51.200.2 178.22.122.100"
  "185.55.225.25 185.55.226.26"
  "9.9.9.9 149.112.112.112"
  "64.6.64.6 64.6.65.6"
  "156.154.70.2 156.154.71.2"
  "159.250.35.250 159.250.35.251"
  "208.67.222.222 208.67.220.220"
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
)

dns_pool_download=(
  "1.1.1.1 1.0.0.1"
  "8.8.8.8 8.8.4.4"
  "64.6.64.6 64.6.65.6"
  "156.154.70.2 156.154.71.2"
  "159.250.35.250 159.250.35.251"
  "208.67.222.222 208.67.220.220"
  "185.51.200.2 178.22.122.100"
  "9.9.9.9 149.112.112.112"
  "78.157.42.101 78.157.42.100"
  "185.55.225.25 185.55.226.26"
  "37.220.84.124 208.67.222.222"  # Added VPN-friendly DNS (OpenNIC)
  "74.82.42.42 0.0.0.0"
  "91.239.100.100 89.223.43.71"
  "208.67.220.200 208.67.222.222"
  "10.202.10.10 10.202.10.11"
)

# Ping Test Function
check_ping() {
    ip="$1"
    result=$(ping -c 1 -W 1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [ -z "$result" ]; then
        echo "Timeout"
    else
        echo "${result} ms"
    fi
}

# Gaming DNS Menu
gaming_dns_menu() {
  clear
  echo -e "${bold}${green}Select a Game:${reset}"
  for i in "${!games[@]}"; do
    if (( i >= 30 )); then
      # رنگ عدد قرمز برای بازی‌های جدید
      printf "${red}[%2d]${reset} %s ${orange}[NEW]${reset}\n" $((i+1)) "${games[$i]}"
    else
      printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${games[$i]}"
    fi
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose a game: ${reset}"; read gopt
  [[ "$gopt" == "0" ]] && return
  [[ -z "${games[$((gopt-1))]}" ]] && echo "Invalid!" && sleep 1 && return

  clear
  echo -e "${green}Select your country:${reset}"
  for i in "${!countries[@]}"; do
    printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${countries[$i]}"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose country: ${reset}"; read copt
  [[ "$copt" == "0" ]] && return

  pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Download DNS Menu
download_dns_menu() {
  clear
  echo -e "${green}Select country or global DNS:${reset}"
  for i in "${!countries[@]}"; do
    printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${countries[$i]}"
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose option: ${reset}"; read copt
  [[ "$copt" == "0" ]] && return

  pick=${dns_pool_download[$RANDOM % ${#dns_pool_download[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Ping Your DNS Menu
ping_your_dns_menu() {
  clear
  echo -ne "${green}Enter DNS IP to ping: ${reset}"; read user_dns
  if [[ ! $user_dns =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    echo -e "${red}Invalid IP format!${reset}"
    sleep 2
    return
  fi
  echo -e "\n${cyan}DNS:${reset} $user_dns"
  echo -e "${blue}Ping:${reset} $(check_ping $user_dns)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Search Game DNS Menu
search_game_dns_menu() {
  clear
  echo -ne "${green}Enter game name to search: ${reset}"; read search_term
  # Case insensitive search
  found_indexes=()
  for i in "${!games[@]}"; do
    if [[ "${games[$i],,}" == *"${search_term,,}"* ]]; then
      found_indexes+=($i)
    fi
  done

  if [ ${#found_indexes[@]} -eq 0 ]; then
    echo -e "${red}No games found!${reset}"
    sleep 2
    return
  fi

  clear
  echo -e "${green}Search results:${reset}"
  for i in "${found_indexes[@]}"; do
    if (( i >= 30 )); then
      printf "${red}[%2d]${reset} %s ${orange}[NEW]${reset}\n" $((i+1)) "${games[$i]}"
    else
      printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${games[$i]}"
    fi
  done

  echo -ne "\n${green}Choose a game: ${reset}"; read gopt
  [[ "$gopt" == "0" ]] && return
  [[ -z "${games[$((gopt-1))]}" ]] && echo "Invalid!" && sleep 1 && return

  pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Best DNS (Lowest Ping) Menu
best_dns_menu() {
  clear
  echo -e "${green}Checking best DNS with lowest ping... Please wait.${reset}"
  best_ping=1000000
  best_dns1=""
  best_dns2=""

  for entry in "${dns_pool_game[@]}" "${dns_pool_download[@]}"; do
    dns1=$(echo "$entry" | awk '{print $1}')
    dns2=$(echo "$entry" | awk '{print $2}')

    ping1=$(ping -c 1 -W 1 "$dns1" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    ping2=$(ping -c 1 -W 1 "$dns2" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)

    # Check if pings are numbers
    if [[ $ping1 =~ ^[0-9]+(\.[0-9]+)?$ ]] && [[ $ping2 =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
      avg_ping=$(echo "scale=2; ($ping1 + $ping2)/2" | bc)
      avg_ping_int=${avg_ping%.*}
      if (( avg_ping_int < best_ping )); then
        best_ping=$avg_ping_int
        best_dns1=$dns1
        best_dns2=$dns2
      fi
    fi
  done

  if [ -z "$best_dns1" ] || [ -z "$best_dns2" ]; then
    echo -e "${red}Could not find best DNS.${reset}"
  else
    echo -e "\n${cyan}Best Primary DNS:${reset} $best_dns1"
    echo -e "${cyan}Best Secondary DNS:${reset} $best_dns2"
    echo -e "${blue}Average Ping:${reset} ${best_ping} ms"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Main Menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Download DNS ⬇️"
    echo -e "${blue}[3]${reset} Best DNS (Lowest Ping) ⭐ ${red}NEW${reset}"
    echo -e "${blue}[4]${reset} Ping Your DNS 📡 ${red}NEW${reset}"
    echo -e "${blue}[5]${reset} Search Game DNS 🔍 ${red}NEW${reset}"
    echo -e "${blue}[0]${reset} Exit ❌"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt
    case $opt in
      1) gaming_dns_menu ;;
      2) download_dns_menu ;;
      3) best_dns_menu ;;
      4) ping_your_dns_menu ;;
      5) search_game_dns_menu ;;
      0) echo -e "${green}Goodbye 🙏🏻${reset}"; exit ;;
      *) echo -e "${red}Invalid input!${reset}"; sleep 1 ;;
    esac
  done
}

main_menu
