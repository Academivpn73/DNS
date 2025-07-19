#!/bin/bash

# Install required packages silently
for pkg in curl; do
  if ! command -v $pkg &>/dev/null; then
    echo "Installing $pkg..."
    apt update &>/dev/null && apt install -y $pkg &>/dev/null
  fi
done

has_figlet=false
has_lolcat=false
if command -v figlet &>/dev/null; then has_figlet=true; fi
if command -v lolcat &>/dev/null; then has_lolcat=true; fi

# Colors and clear screen
colors=(31 32 33 34 35 36)
color=${colors[$RANDOM % ${#colors[@]}]}
clear

# Animated Title
function animated_title() {
  echo -e "\033[1;${color}m"
  text="DNS Gamer Pro"
  if $has_figlet; then
    figlet -f slant "$text" | ($has_lolcat && lolcat || cat)
  else
    for ((i=0;i<${#text};i++)); do
      echo -n "${text:$i:1}"
      sleep 0.05
    done
    echo ""
  fi
  echo -e "\033[0m"
  echo -e "\033[1;30m+------------------------------------------+\033[0m"
  echo -e "\033[1;37m| Telegram: @Academi_vpn  Admin: @MahdiAGM0 |\033[0m"
  echo -e "\033[1;37m| Version: 1.2.3                            |\033[0m"
  echo -e "\033[1;30m+------------------------------------------+\033[0m"
}

# Typing effect
function typer() {
  text="$1"
  for ((i = 0; i < ${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.0015
  done
  echo ""
}

# Sample DNS per region/game
declare -A dns_iran dns_uae dns_turkey dns_other
dns_iran["Arena Breakout"]="178.22.122.100,185.51.200.2"
dns_uae["Arena Breakout"]="94.200.200.200,94.200.200.201"
dns_turkey["Arena Breakout"]="195.175.39.49,195.175.39.50"
dns_other["Arena Breakout"]="8.8.8.8,1.1.1.1"

# Game list
games=(
"PUBG Mobile"
"Call of Duty Mobile"
"Free Fire"
"Arena Breakout [New]"
"Apex Legends Mobile"
"Clash of Clans"
"Clash Royale"
"Brawl Stars"
"Mobile Legends"
"League of Legends: Wild Rift"
"FIFA Mobile"
"eFootball"
"Among Us"
"Genshin Impact"
"Fortnite"
"Roblox"
"Subway Surfers"
"8 Ball Pool"
"Asphalt 9"
"Shadow Fight 4"
"Critical Ops"
"Modern Combat 5"
"Zooba"
"War Robots"
"Sniper 3D"
"Dream League Soccer"
"Plants vs Zombies"
"Pixel Gun 3D"
"Mini Militia"
"Dead Trigger 2"
"Real Racing 3"
"CSR Racing 2"
"Marvel Contest of Champions"
"Injustice 2"
"Real Steel"
"UNO!"
"Pokémon Unite"
"Dragon Ball Legends"
"Dragon Raja"
"Diablo Immortal"
"Bullet Echo"
"Battle Prime"
"State of Survival"
"Rise of Kingdoms"
"Evony"
"Summoners War"
"Hero Wars"
"Archero"
"Tacticool"
"Warface: Global Operations"
)

# Function to show DNS + ping
function show_dns() {
  dns1="$1"
  dns2="$2"
  echo -e "\nPrimary DNS: $dns1"
  ping -c 1 -W 1 $dns1 | grep "time=" || echo "Ping failed"
  echo -e "\nSecondary DNS: $dns2"
  ping -c 1 -W 1 $dns2 | grep "time=" || echo "Ping failed"
  echo ""
}

# Main menu function
function main_menu() {
  clear
  animated_title
  typer "1) Get Gaming DNS"
  typer "2) Get Download DNS (Anti-Filter)"
  typer "3) Search DNS by Game"
  typer "4) Premium DNS (Ultra Fast)"
  typer "5) Check Online Ping"
  typer "6) Exit"
  read -p $'\nChoose an option: ' opt

  case $opt in
    1) gaming_dns ;;
    2) download_dns ;;
    3) search_game ;;
    4) premium_dns ;;
    5) ping_dns ;;
    6) echo -e "\nGoodbye!\n"; exit 0 ;;
    *) echo -e "\nInvalid option"; read -p "Press Enter..."; main_menu ;;
  esac
}

# Option 1
function gaming_dns() {
  clear
  animated_title
  echo -e "\nSelect Game:"
  for i in "${!games[@]}"; do
    name="${games[$i]}"
    if [[ "$name" == *"[New]"* ]]; then
      echo -e "$((i+1))) \033[1;34m$name\033[0m"
    else
      echo "$((i+1))) $name"
    fi
  done
  echo "$(( ${#games[@]} + 1 ))) Back to Main Menu"
  read -p $'\nEnter game number: ' gnum

  if [[ $gnum -eq $(( ${#games[@]} + 1 )) ]]; then
    main_menu
    return
  fi

  game="${games[$((gnum-1))]}"

  echo -e "\nSelect Region:"
  echo "1) Iran"
  echo "2) UAE"
  echo "3) Turkey"
  echo "4) Other"
  echo "5) Back to Main Menu"
  read -p $'\nChoose country: ' cntry

  case $cntry in
    1) dns="${dns_iran[$game]}" ;;
    2) dns="${dns_uae[$game]}" ;;
    3) dns="${dns_turkey[$game]}" ;;
    4) dns="${dns_other[$game]}" ;;
    5) main_menu; return ;;
    *) echo "Invalid"; read -p "Press Enter..."; gaming_dns; return ;;
  esac

  IFS=',' read -r dns1 dns2 <<< "$dns"
  echo -e "\nRecommended DNS for \033[1m$game\033[0m:"
  show_dns "$dns1" "$dns2"
  read -p "Press Enter to return..." && main_menu
}

# Option 2
function download_dns() {
  clear
  animated_title
  echo -e "\nDownload DNS (High Speed Anti-Filter)"
  list=("8.8.8.8,8.8.4.4" "1.1.1.1,1.0.0.1" "9.9.9.9,149.112.112.112")
  rnd=$((RANDOM % ${#list[@]}))
  IFS=',' read -r d1 d2 <<< "${list[$rnd]}"
  show_dns "$d1" "$d2"
  read -p "Press Enter to return..." && main_menu
}

# Option 3
function search_game() {
  clear
  animated_title
  read -p "Enter game name to search: " search
  match=false
  for g in "${games[@]}"; do
    if [[ "${g,,}" == *"${search,,}"* ]]; then
      echo -e "\nGame Found: $g"
      match=true
      break
    fi
  done
  $match || echo -e "\n\033[1;31mNo matching game found.\033[0m"
  read -p "Press Enter to return..." && main_menu
}

# Option 4
function premium_dns() {
  clear
  animated_title
  echo -e "\n\033[1;33mPREMIUM DNS (Ultra Fast, <40ms)\033[0m"
  fast_dns=("1.1.1.1,1.0.0.1" "8.8.8.8,8.8.4.4" "9.9.9.9,149.112.112.112")
  rnd=$((RANDOM % ${#fast_dns[@]}))
  IFS=',' read -r f1 f2 <<< "${fast_dns[$rnd]}"
  show_dns "$f1" "$f2"
  read -p "Press Enter to return..." && main_menu
}

# Option 5
function ping_dns() {
  clear
  animated_title
  read -p "Enter DNS to ping: " ip
  echo -e "\nPinging $ip..."
  ping -c 4 "$ip"
  read -p "Press Enter to return..." && main_menu
}

# Start
main_menu
