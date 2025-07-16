#!/bin/bash

Auto install required tools

for pkg in curl ping figlet lolcat; do if ! command -v $pkg &> /dev/null; then echo "Installing missing package: $pkg..." sudo apt-get install -y $pkg >/dev/null 2>&1 || sudo yum install -y $pkg >/dev/null 2>&1 fi done

clear

Title design

figlet "Mahdi DNS" | lolcat sleep 0.2 echo -e "\e[36mTelegram: \e[33m@Academi_vpn" echo -e "\e[36mAdmin:    \e[33m@MahdiAGM0" echo -e "\e[31mVersion:  1.0.9\e[0m" echo "" sleep 1

Game list

declare -A games=( ["Call of Duty Mobile"]="Mobile" ["PUBG Mobile"]="Mobile" ["Free Fire"]="Mobile" ["Clash Royale"]="Mobile" ["Clash of Clans"]="Mobile" ["Brawl Stars"]="Mobile" ["Mobile Legends"]="Mobile" ["Arena of Valor"]="Mobile" ["League of Legends: Wild Rift"]="Mobile" ["FIFA Mobile"]="Mobile" ["Apex Legends Mobile"]="Mobile" ["Roblox"]="Mobile" ["Among Us"]="Mobile"

["Valorant"]="PC" ["CS:GO"]="PC" ["Dota 2"]="PC" ["League of Legends"]="PC" ["Overwatch 2"]="PC" ["Minecraft"]="PC" ["Apex Legends"]="PC" ["Team Fortress 2"]="PC" ["Escape from Tarkov"]="PC" ["Warframe"]="PC" ["Paladins"]="PC" ["Genshin Impact"]="PC" ["Rust"]="PC"

["Fortnite"]="Console" ["Call of Duty Warzone"]="Console" ["FIFA 24"]="Console" ["eFootball 2024"]="Console" ["NBA 2K24"]="Console" ["Rainbow Six Siege"]="Console" ["Destiny 2"]="Console" ["Rocket League"]="Console" ["Battlefield 2042"]="Console" ["The Division 2"]="Console" ["Madden NFL 24"]="Console" ["Hogwarts Legacy"]="Console" ["GTA Online"]="Console" )

Countries (sample - Middle East focused)

countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Qatar" "Kuwait" "Bahrain" "Oman" "Iraq" "Jordan" "Egypt" "Lebanon" "Syria" "Israel" "Pakistan" "India" "Afghanistan" "Azerbaijan" "Armenia" "Georgia")

Fake DNS (replace with real performant gaming/download DNS later)

declare -A dns_data for country in "${countries[@]}"; do for i in {1..15}; do rand_ip="$(shuf -i 1-255 -n 1).$(shuf -i 1-255 -n 1).$(shuf -i 1-255 -n 1).$(shuf -i 1-255 -n 1)" dns_data["$country,$i"]="$rand_ip" done done

Function to test ping

ping_test() { ping -c 1 -W 1 $1 | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1 }

Main Menu

while true; do clear echo -e "\e[32m===== Main Menu =====\e[0m" echo -e "\e[36m1. Gaming DNS" echo -e "2. Download DNS" echo -e "0. Exit\e[0m" echo -n "Select an option: " read option

case $option in 1) clear echo -e "\e[33mAvailable Games:\e[0m" index=1 for game in "${!games[@]}"; do echo -e "\e[36m$index. $game [${games[$game]}]\e[0m" game_list[$index]="$game" ((index++)) done echo -n "Choose a game number: " read game_index selected_game=${game_list[$game_index]}

echo -e "\n\e[35mAvailable Countries:\e[0m"
  for i in "${!countries[@]}"; do
    color=$((31 + i % 6))
    echo -e "\e[${color}m$((i+1)). ${countries[$i]}\e[0m"
  done
  echo -n "Choose country number: "
  read country_index
  selected_country=${countries[$((country_index-1))]}

  echo -e "\n\e[33m--- DNS List for $selected_game ($selected_country) ---\e[0m"
  for i in {1..15}; do
    dns_ip=${dns_data["$selected_country,$i"]}
    ping_res=$(ping_test $dns_ip)
    echo -e "\e[36mDNS $i: $dns_ip (Ping: ${ping_res:-N/A} ms)\e[0m"
  done
  read -p $'\nPress Enter to return...'
  ;;

2)
  clear
  echo -e "\e[35mDownload DNS - Select Country:\e[0m"
  for i in "${!countries[@]}"; do
    color=$((31 + i % 6))
    echo -e "\e[${color}m$((i+1)). ${countries[$i]}\e[0m"
  done
  echo -n "Choose country number: "
  read country_index
  selected_country=${countries[$((country_index-1))]}

  echo -e "\n\e[33m--- Download DNS for $selected_country ---\e[0m"
  for i in {1..15}; do
    dns_ip=${dns_data["$selected_country,$i"]}
    ping_res=$(ping_test $dns_ip)
    echo -e "\e[36mDNS $i: $dns_ip (Ping: ${ping_res:-N/A} ms)\e[0m"
  done
  read -p $'\nPress Enter to return...'
  ;;

0)
  echo -e "\n\e[33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\e[0m"
  exit 0
  ;;

*)
  echo "Invalid option. Try again."
  sleep 1
  ;;

esac done

