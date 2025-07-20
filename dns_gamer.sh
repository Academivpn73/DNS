#!/bin/bash

# Version 1.2.3 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;214m"
gray="\e[1;30m"
reset="\e[0m"
bold="\e[1m"

# Typing animation
type_text() {
    text="$1"
    delay="${2:-0.0003}"  # animation speed a bit faster
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
    type_text "╔══════════════════════════════════════╗" 0.0002
    type_text "║         DNS MANAGEMENT TOOL         ║" 0.0002
    type_text "╠══════════════════════════════════════╣" 0.0002
    type_text "║  Version: 1.2.3                      ║" 0.0002
    type_text "║  Telegram: @Academi_vpn             ║" 0.0002
    type_text "║  Admin: @MahdiAGM0                  ║" 0.0002
    type_text "╚══════════════════════════════════════╝" 0.0002
    echo -e "${reset}"
}

# Games (with 10 new, new games names in gray + "NEW" in orange)
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Rainbow Six Siege" "Apex Legends"
  "Rocket League" "Minecraft" "Genshin Impact" "Battlefield V" "Roblox"
  "FIFA 24" "Warzone" "Escape from Tarkov" "War Thunder" "Destiny 2"
  "Smite" "Halo Infinite" "Fall Guys" "Paladins" "World of Warcraft"
  "Elden Ring" "Cyberpunk 2077" "ARK" "Sea of Thieves" "Diablo IV"
  "\e[90mArena Breakout\e[0m \e[38;5;214mNEW\e[0m"
  "\e[90mNew Game 1\e[0m \e[38;5;214mNEW\e[0m"
  "\e[90mNew Game 2\e[0m \e[38;5;214mNEW\e[0m"
  "\e[90mNew Game 3\e[0m \e[38;5;214mNEW\e[0m"
  "\e[90mNew Game 4\e[0m \e[38;5;214mNEW\e[0m"
  "\e[90mNew Game 5\e[0m \e[38;5;214mNEW\e[0m"
  "\e[90mNew Game 6\e[0m \e[38;5;214mNEW\e[0m"
  "\e[90mNew Game 7\e[0m \e[38;5;214mNEW\e[0m"
  "\e[90mNew Game 8\e[0m \e[38;5;214mNEW\e[0m"
  "\e[90mNew Game 9\e[0m \e[38;5;214mNEW\e[0m"
)

countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Iraq" "Jordan")

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
  # Add VPN DNS here to help bypass restrictions (example)
  "208.67.222.222 208.67.220.220"
  "1.1.1.1 9.9.9.9"
)

check_ping() {
    ip="$1"
    result=$(ping -c 1 -W 1 "$ip" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [ -z "$result" ]; then
        echo "Timeout"
    else
        echo "${result} ms"
    fi
}

gaming_dns_menu() {
  clear
  echo -e "${bold}${green}Select a Game:${reset}"
  for i in "${!games[@]}"; do
    printf "${blue}[%2d]${reset} %b\n" $((i+1)) "${games[$i]}"
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

ping_dns_menu() {
  clear
  echo -ne "${green}Enter DNS IP to ping: ${reset}"; read user_dns
  if [[ -z "$user_dns" ]]; then
    echo -e "${red}No DNS entered!${reset}"
    sleep 1
    return
  fi
  echo -e "${blue}Pinging DNS $user_dns ...${reset}"
  ping_result=$(ping -c 1 -W 1 "$user_dns" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
  if [[ -z "$ping_result" ]]; then
    echo -e "${red}Ping Timeout or DNS unreachable.${reset}"
  else
    echo -e "${cyan}DNS:${reset} $user_dns"
    echo -e "${cyan}Ping:${reset} $ping_result ms"
  fi
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

search_game_dns_menu() {
  clear
  echo -ne "${green}Enter game name to search DNS: ${reset}"; read game_search
  if [[ -z "$game_search" ]]; then
    echo -e "${red}No input entered!${reset}"
    sleep 1
    return
  fi

  # Find matching games
  matches=()
  for i in "${!games[@]}"; do
    game_name=$(echo -e "${games[$i]}" | sed 's/\x1b\[[0-9;]*m//g')  # Remove color codes
    if [[ "${game_name,,}" == *"${game_search,,}"* ]]; then
      matches+=("$i")
    fi
  done

  if [ ${#matches[@]} -eq 0 ]; then
    echo -e "${red}No games found matching \"$game_search\".${reset}"
    sleep 2
    return
  fi

  # Show matched games
  echo -e "${green}Found games:${reset}"
  for idx in "${matches[@]}"; do
    printf "${blue}[%2d]${reset} %b\n" $((idx+1)) "${games[$idx]}"
  done
  echo -ne "\n${green}Choose game number: ${reset}"; read gopt
  if [[ "$gopt" == "0" || -z "${games[$((gopt-1))]}" ]]; then
    echo "Back"
    return
  fi

  pick=${dns_pool_game[$RANDOM % ${#dns_pool_game[@]}]}
  dns1=$(echo "$pick" | awk '{print $1}')
  dns2=$(echo "$pick" | awk '{print $2}')

  echo -e "\n${cyan}Primary DNS:${reset} $dns1"
  echo -e "${cyan}Secondary DNS:${reset} $dns2"
  echo -e "${blue}Ping 1:${reset} $(check_ping $dns1)"
  echo -e "${blue}Ping 2:${reset} $(check_ping $dns2)"
  echo -e "\n${green}Press Enter to return...${reset}"; read
}

best_dns_menu() {
  clear
  echo -e "${green}Checking best DNS with lowest average ping... Please wait.${reset}"

  best_ping=1000000
  best_dns1=""
  best_dns2=""

  # Combine all DNS pools
  all_dns_pools=("${dns_pool_game[@]}" "${dns_pool_download[@]}")

  for entry in "${all_dns_pools[@]}"; do
    dns1=$(echo "$entry" | awk '{print $1}')
    dns2=$(echo "$entry" | awk '{print $2}')

    # Ping each DNS 3 times and calculate average for dns1
    ping_sum1=0
    count1=0
    for i in {1..3}; do
      p=$(ping -c 1 -W 1 "$dns1" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
      if [[ $p =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        ping_sum1=$(echo "$ping_sum1 + $p" | bc)
        ((count1++))
      fi
      sleep 0.2
    done

    # Ping each DNS 3 times and calculate average for dns2
    ping_sum2=0
    count2=0
    for i in {1..3}; do
      p=$(ping -c 1 -W 1 "$dns2" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
      if [[ $p =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        ping_sum2=$(echo "$ping_sum2 + $p" | bc)
        ((count2++))
      fi
      sleep 0.2
    done

    if (( count1 > 0 && count2 > 0 )); then
      avg1=$(echo "scale=2; $ping_sum1 / $count1" | bc)
      avg2=$(echo "scale=2; $ping_sum2 / $count2" | bc)
      avg_ping=$(echo "scale=2; ($avg1 + $avg2) / 2" | bc)
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

main_menu() {
  while true; do
    show_title
    echo -e "${blue}[1]${reset} Gaming DNS 🎮"
    echo -e "${blue}[2]${reset} Download DNS ⬇️"
    echo -e "${red}[3]${reset} Best DNS (LOWEST PING) \e[31mNEW\e[0m"
    echo -e "${red}[4]${reset} Ping DNS \e[31mNEW\e[0m"
    echo -e "${red}[5]${reset} Search Game DNS \e[31mNEW\e[0m"
    echo -e "${blue}[0]${reset} Exit"
    echo -ne "\n${green}Choose an option: ${reset}"
    read opt
    case $opt in
      1) gaming_dns_menu ;;
      2) download_dns_menu ;;
      3) best_dns_menu ;;
      4) ping_dns_menu ;;
      5) search_game_dns_menu ;;
      0) echo -e "${green}Bye!${reset}" ; exit 0 ;;
      *) echo -e "${red}Invalid option!${reset}" ; sleep 1 ;;
    esac
  done
}

main_menu
