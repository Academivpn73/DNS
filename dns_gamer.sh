#!/bin/bash

# Version 1.2.3 | Telegram: @Academi_vpn | Admin By: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
reset="\e[0m"
bold="\e[1m"
orange="\e[38;5;214m"
grey="\e[90m"

# Typing animation (faster)
type_text() {
    text="$1"
    delay="${2:-0.0002}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Random colored title (faster)
show_title() {
    colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    rand_color=${colors[$RANDOM % ${#colors[@]}]}
    clear
    echo -e "${rand_color}"
    type_text "╔══════════════════════════════════════╗" 0.0002
    type_text " ║         DNS MANAGEMENT TOOL        ║" 0.0002
    type_text "╠══════════════════════════════════════╣" 0.0002
    type_text " ║  Version: 1.2.3                    ║" 0.0002
    type_text " ║  Telegram: @Academi_vpn            ║" 0.0002
    type_text " ║  Admin By: @MahdiAGM0              ║" 0.0002
    type_text "╚══════════════════════════════════════╝" 0.0002
    echo -e "${reset}"
}

# Games list: 30 real games + 1 new named game + 9 'New Game'
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Rainbow Six Siege" "Apex Legends"
  "Rocket League" "Minecraft" "Genshin Impact" "Battlefield V" "Roblox"
  "FIFA 24" "Warzone" "Escape from Tarkov" "War Thunder" "Destiny 2"
  "Smite" "Halo Infinite" "Fall Guys" "Paladins" "World of Warcraft"
  "Elden Ring" "Cyberpunk 2077" "ARK" "Sea of Thieves" "Diablo IV"
  "Arena Breakout"
  "New Game" "New Game" "New Game" "New Game" "New Game"
  "New Game" "New Game" "New Game" "New Game" "New Game"
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
  "37.220.84.124 208.67.222.222"
  "74.82.42.42 0.0.0.0"
  "91.239.100.100 89.223.43.71"
  "208.67.220.200 208.67.222.222"
  "10.202.10.10 10.202.10.11"
  "8.8.8.8 208.67.222.222"  # Added for VPN/anti-censorship
)

# Ping Test Function (average of 3 pings)
check_ping() {
    ip="$1"
    total=0
    count=3
    for i in $(seq 1 $count); do
        result=$(ping -c 1 -W 1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
        if [[ -z "$result" ]]; then
            echo "Timeout"
            return
        fi
        total=$(echo "$total + $result" | bc)
    done
    avg=$(echo "scale=2; $total / $count" | bc)
    echo "${avg} ms"
}

# Gaming DNS Menu
gaming_dns_menu() {
  clear
  echo -e "${bold}${green}Select a Game:${reset}"
  for i in "${!games[@]}"; do
    if (( i >= 30 )); then
      printf "${grey}${blue}[%2d]${reset} %s ${orange}NEW${reset}\n" $((i+1)) "${games[i]}"
    else
      printf "${blue}[%2d]${reset} %s\n" $((i+1)) "${games[i]}"
    fi
  done
  echo -e "${blue}[0]${reset} Back"
  echo -ne "\n${green}Choose a game: ${reset}"; read gopt
  [[ "$gopt" == "0" ]] && return
  [[ -z "${games[$((gopt-1))]}" ]] && echo -e "${red}Invalid!${reset}" && sleep 1 && return

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

# Best DNS Menu (find lowest average ping pair)
best_dns_menu() {
  clear
  echo -e "${bold}${green}Finding best DNS pair with lowest ping...${reset}"
  best_dns=""
  best_avg=1000000
  # Combine all dns pools
  all_dns=("${dns_pool_game[@]}" "${dns_pool_download[@]}")
  # Remove duplicates
  all_dns_unique=($(echo "${all_dns[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

  # We test each DNS pair from original pools (to keep pairs intact)
  for pair in "${dns_pool_game[@]}" "${dns_pool_download[@]}"; do
    dns1=$(echo "$pair" | awk '{print $1}')
    dns2=$(echo "$pair" | awk '{print $2}')
    ping1=$(check_ping $dns1)
    ping2=$(check_ping $dns2)
    # if timeout, skip
    if [[ "$ping1" == "Timeout" ]] || [[ "$ping2" == "Timeout" ]]; then
      continue
    fi
    avg1=$(echo $ping1 | awk '{print $1}')
    avg2=$(echo $ping2 | awk '{print $1}')
    avg_ping=$(echo "scale=2; ($avg1 + $avg2) / 2" | bc)
    avg_ping_num=$(echo $avg_ping | cut -d'.' -f1)
    if (( avg_ping_num < best_avg )); then
      best_avg=$avg_ping_num
      best_dns="$dns1 $dns2"
    fi
  done

  if [[ -z "$best_dns" ]]; then
    echo -e "${red}No reachable DNS found.${reset}"
  else
    dns1=$(echo $best_dns | awk '{print $1}')
    dns2=$(echo $best_dns | awk '{print $2}')
    echo -e "${green}Best DNS Pair:${reset}"
    echo -e "Primary: $dns1"
    echo -e "Secondary: $dns2"
    echo -e "Ping 1: $(check_ping $dns1)"
    echo -e "Ping 2: $(check_ping $dns2)"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Ping DNS Menu (user inputs DNS, script pings it)
ping_dns_menu() {
  clear
  echo -ne "${green}Enter DNS IP to ping:${reset} "
  read user_dns
  if [[ -z "$user_dns" ]]; then
    echo -e "${red}No DNS entered!${reset}"
    sleep 1
    return
  fi
  ping_result=$(check_ping $user_dns)
  echo -e "\nDNS: $user_dns"
  echo -e "Ping: $ping_result"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Search Game DNS (simulate getting DNS by game name)
search_game_dns() {
  clear
  echo -ne "${green}Enter Game name to search DNS:${reset} "
  read game_name
  if [[ -z "$game_name" ]]; then
    echo -e "${red}No game name entered!${reset}"
    sleep 1
    return
  fi

  # For demo, search games array for match ignoring case
  found_index=-1
  for i in "${!games[@]}"; do
    if [[ "${games[$i],,}" == *"${game_name,,}"* ]]; then
      found_index=$i
      break
    fi
  done

  if (( found_index == -1 )); then
    echo -e "${red}Game not found.${reset}"
  else
    pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
    dns1=$(echo "$pick" | awk '{print $1}')
    dns2=$(echo "$pick" | awk '{print $2}')
    echo -e "\nGame: ${games[$found_index]}"
    echo -e "Primary DNS: $dns1"
    echo -e "Secondary DNS: $dns2"
    echo -e "Ping 1: $(check_ping $dns1)"
    echo -e "Ping 2: $(check_ping $dns2)"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

# Main Menu
main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS"
    echo -e "${red}[NEW]${reset} ${blue}[2]${reset} Ping DNS"
    echo -e "${blue}[3]${reset} Download DNS"
    echo -e "${red}[NEW]${reset} ${blue}[4]${reset} Search Game DNS"
    echo -e "${red}[NEW]${reset} ${blue}[5]${reset} Best DNS"
    echo -e "${blue}[0]${reset} Exit"
    echo -ne "\n${green}Choose an option: ${reset}"; read opt

    case $opt in
      1) gaming_dns_menu ;;
      2) ping_dns_menu ;;
      3) download_dns_menu ;;
      4) search_game_dns ;;
      5) best_dns_menu ;;
      0) clear; exit 0 ;;
      *) echo -e "${red}Invalid option!${reset}" && sleep 1 ;;
    esac
  done
}

main_menu
