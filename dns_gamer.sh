#!/bin/bash

# Auto-install required packages
for pkg in curl; do
  if ! command -v "$pkg" &>/dev/null; then
    apt update && apt install "$pkg" -y
  fi
done

# Function to show loading animation
loading() {
  echo -ne "\e[1;36mLoading"
  for i in {1..5}; do
    echo -ne "."
    sleep 0.2
  done
  echo -e "\e[0m"
  sleep 0.3
  clear
}

# Fancy title with color and animation
show_title() {
  clear
  echo -e "\e[1;36m╔═════════════════════════════════════════════╗"
  echo -e "\e[1;33m║          ACADEMI VPN DNS TOOL               ║"
  echo -e "\e[1;32m║        Fast, Gaming & Download DNSs         ║"
  echo -e "\e[1;34m║          Coded by @MahdiAGM0                ║"
  echo -e "\e[1;35m║          Channel: @Academi_vpn              ║"
  echo -e "\e[1;31m║                Version: 1.0.9               ║"
  echo -e "\e[1;36m╚═════════════════════════════════════════════╝\e[0m"
  echo ""
}

# Define games (partial for demo)
declare -A games=(
  ["Call of Duty"]="Mobile"
  ["PUBG"]="Mobile"
  ["Free Fire"]="Mobile"
  ["Valorant"]="PC"
  ["Fortnite"]="Console"
  ["CS:GO"]="PC"
  ["Dota 2"]="PC"
  ["Apex Legends"]="PC"
  ["Clash Royale"]="Mobile"
  ["Warzone"]="Console"
  ["Rainbow Six"]="PC"
  ["League of Legends"]="PC"
  ["Minecraft"]="PC"
  ["Overwatch"]="PC"
  ["Roblox"]="Mobile"
  ["Brawl Stars"]="Mobile"
  ["eFootball"]="Console"
  ["FIFA 24"]="Console"
)

# Countries
countries=("Iran" "Turkey" "Saudi Arabia" "UAE" "Qatar" "Iraq" "Jordan" "Oman" "Bahrain" "Kuwait")

# DNS data (partial, demo)
declare -A dns_data
dns_data["Iran"]="178.22.122.100 185.51.200.2 185.51.200.3 185.51.200.4 1.1.1.1 8.8.8.8 10.202.10.10 94.140.14.14 64.6.64.6 9.9.9.9 208.67.222.222 185.228.168.9 76.76.2.0 185.228.169.9 45.90.28.0"
for c in "${countries[@]}"; do
  [[ -z "${dns_data[$c]}" ]] && dns_data["$c"]="1.1.1.1 8.8.8.8 9.9.9.9 208.67.222.222 94.140.14.14 76.76.2.0 64.6.64.6 45.90.28.0 1.0.0.1 8.8.4.4 185.228.168.9 185.228.169.9 77.88.8.8 10.202.10.10 185.51.200.4"
done

# Function to test DNS ping and return result
get_ping() {
  local dns=$1
  # Ping once to get the response time (1 packet, quiet mode)
  ping_result=$(ping -c 1 -W 1 "$dns" 2>/dev/null)
  # Extract the time from the ping result
  ping_time=$(echo "$ping_result" | grep 'time=' | awk -F 'time=' '{print $2}' | awk '{print $1}')
  if [[ -z "$ping_time" ]]; then
    echo "N/A"
  else
    echo "$ping_time ms"
  fi
}

show_games() {
  echo -e "\e[1;33m🎮 Select Game:\e[0m"
  local i=1
  for g in "${!games[@]}"; do
    printf "[%2d] \e[1;36m%-20s\e[0m (%s)\n" $i "$g" "${games[$g]}"
    ((i++))
  done
}

show_countries() {
  echo -e "\n\e[1;34m🌍 Select Country:\e[0m"
  for i in "${!countries[@]}"; do
    printf "[%d] \e[1;35m%s\e[0m\n" "$i" "${countries[$i]}"
  done
}

show_dns_list() {
  local country=$1
  IFS=' ' read -ra dns_list <<< "${dns_data[$country]}"
  echo -e "\n\e[1;36m🔧 Top 15 DNS for $country:\e[0m"
  for i in "${!dns_list[@]}"; do
    [[ $i -ge 15 ]] && break
    ping_time=$(get_ping "${dns_list[$i]}")
    echo -e "\e[1;33mDNS $((i+1)):\e[0m ${dns_list[$i]} \e[1;30m(Ping: $ping_time)\e[0m"
  done
}

# Menu loop
while true; do
  show_title
  echo -e "\e[1;33m[1]\e[0m 🎮 Gaming DNS"
  echo -e "\e[1;34m[2]\e[0m 🚀 Download DNS"
  echo -e "\e[1;31m[0]\e[0m ❌ Exit"
  read -p $'\nSelect an option: ' choice

  case $choice in
    1)
      clear; show_title; show_games
      read -p $'\nGame number: ' game_index
      game_keys=("${!games[@]}")
      selected_game="${game_keys[$((game_index-1))]}"
      echo -e "\n🎯 Selected Game: \e[1;33m$selected_game\e[0m"

      show_countries
      read -p $'\nCountry number: ' country_index
      selected_country="${countries[$country_index]}"
      echo -e "\n🌍 Selected Country: \e[1;32m$selected_country\e[0m"

      loading
      show_dns_list "$selected_country"
      read -p $'\nPress Enter to return...' back
      ;;
    2)
      clear; show_title
      show_countries
      read -p $'\nCountry number: ' country_index
      selected_country="${countries[$country_index]}"
      echo -e "\n🌍 Selected Country: \e[1;32m$selected_country\e[0m"

      loading
      show_dns_list "$selected_country"
      read -p $'\nPress Enter to return...' back
      ;;
    0)
      echo -e "\n\e[1;33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\e[0m"
      exit 0
      ;;
    *)
      echo -e "\e[1;31mInvalid choice. Try again.\e[0m"
      sleep 1
      ;;
  esac
done
