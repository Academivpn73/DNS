#!/bin/bash

# Auto install dependencies
for pkg in curl lolcat figlet; do
  if ! command -v $pkg &>/dev/null; then
    echo "Installing $pkg..."
    apt update &>/dev/null && apt install -y $pkg &>/dev/null
  fi
done

# Function: Title with color and animation
function show_title() {
  colors=(31 32 33 34 35 36)
  color=${colors[$RANDOM % ${#colors[@]}]}
  clear
  echo -e "\033[1;${color}m"
  figlet -f slant "DNS Gamer Pro" | lolcat
  echo -e "\033[0m"
  echo -e "\033[1;30m--------------------------------------------\033[0m"
  echo -e "\033[1;37m Telegram: @Academi_vpn   Admin: @MahdiAGM0"
  echo -e "           Version: \033[1;36m1.2.3\033[0m"
  echo -e "\033[1;30m--------------------------------------------\033[0m"
}

# Function: Typing effect
function typer() {
  text="$1"
  for ((i=0; i<${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.0015
  done
  echo ""
}

# Sample DNS maps (fill more as needed)
declare -A dns_iran=(
  ["Call of Duty Mobile"]="1.1.1.1,1.0.0.1"
  ["PUBG Mobile"]="8.8.8.8,8.8.4.4"
  ["Arena Breakout"]="9.9.9.9,149.112.112.112"
)
declare -A dns_uae=(
  ["Call of Duty Mobile"]="94.140.14.14,94.140.15.15"
  ["Arena Breakout"]="1.1.1.2,1.0.0.2"
)
declare -A dns_turkey=(
  ["PUBG Mobile"]="76.76.2.0,76.76.10.0"
)
declare -A dns_other=(
  ["Arena Breakout"]="185.228.168.168,185.228.169.168"
)

# Function: Ping DNS
function show_dns() {
  dns1="$1"
  dns2="$2"
  echo -e "\nPrimary DNS: \033[1m$dns1\033[0m"
  ping -c 1 -W 1 $dns1 | grep "time=" || echo "Ping failed"
  echo
  echo -e "Secondary DNS: \033[1m$dns2\033[0m"
  ping -c 1 -W 1 $dns2 | grep "time=" || echo "Ping failed"
  echo
}

# Function: Show games
function show_games() {
  echo -e "\nSelect a game:"
  for i in {1..50}; do
    if [ $i -ge 46 ]; then
      echo -e "$i) \033[1;34mGame $i [New]\033[0m"
    else
      echo "$i) Game $i"
    fi
  done
  echo "51) \033[1;32m← Back\033[0m"
}

# Function: Get game name by number
function get_game_name() {
  case $1 in
    1) echo "Call of Duty Mobile" ;;
    2) echo "PUBG Mobile" ;;
    3) echo "Free Fire" ;;
    4) echo "Clash Royale" ;;
    5) echo "Clash of Clans" ;;
    6) echo "Brawl Stars" ;;
    7) echo "Mobile Legends" ;;
    8) echo "Wild Rift" ;;
    9) echo "Genshin Impact" ;;
    10) echo "Apex Legends Mobile" ;;
    11) echo "Fortnite" ;;
    12) echo "League of Legends Mobile" ;;
    13) echo "Valorant Mobile" ;;
    14) echo "Minecraft PE" ;;
    15) echo "Diablo Immortal" ;;
    16) echo "Among Us" ;;
    17) echo "Roblox" ;;
    18) echo "FIFA Mobile" ;;
    19) echo "eFootball 2024" ;;
    20) echo "Asphalt 9" ;;
    21) echo "Dead by Daylight" ;;
    22) echo "Standoff 2" ;;
    23) echo "Modern Combat" ;;
    24) echo "War Robots" ;;
    25) echo "Arena Breakout" ;;
    26) echo "Game 26" ;;
    27) echo "Game 27" ;;
    28) echo "Game 28" ;;
    29) echo "Game 29" ;;
    30) echo "Game 30" ;;
    31) echo "Game 31" ;;
    32) echo "Game 32" ;;
    33) echo "Game 33" ;;
    34) echo "Game 34" ;;
    35) echo "Game 35" ;;
    36) echo "Game 36" ;;
    37) echo "Game 37" ;;
    38) echo "Game 38" ;;
    39) echo "Game 39" ;;
    40) echo "Game 40" ;;
    41) echo "Game 41" ;;
    42) echo "Game 42" ;;
    43) echo "Game 43" ;;
    44) echo "Game 44" ;;
    45) echo "Game 45" ;;
    46) echo "Game 46" ;;
    47) echo "Game 47" ;;
    48) echo "Game 48" ;;
    49) echo "Game 49" ;;
    50) echo "Game 50" ;;
    *) echo "" ;;
  esac
}

# Main menu
function main_menu() {
  while true; do
    show_title
    typer "1) Get Gaming DNS"
    typer "2) Get Download DNS (Anti-Filter)"
    typer "3) Search DNS by Game"
    typer "4) Premium DNS (Ultra Fast)"
    typer "5) Check Online Ping"
    typer "6) Exit"
    echo
    read -p "Choose an option: " opt

    case $opt in
      1) gaming_dns ;;
      2) download_dns ;;
      3) search_dns ;;
      4) premium_dns ;;
      5) ping_check ;;
      6) exit 0 ;;
      *) echo "Invalid choice"; sleep 1 ;;
    esac
  done
}

# Function: Gaming DNS
function gaming_dns() {
  show_title
  show_games
  read -p "Enter game number: " gnum
  if [[ "$gnum" == "51" ]]; then return; fi
  game=$(get_game_name $gnum)
  if [ -z "$game" ]; then echo "Invalid game"; sleep 1; return; fi

  echo -e "\nSelect Region:"
  echo "1) Iran"
  echo "2) UAE"
  echo "3) Turkey"
  echo "4) Other"
  echo "5) ← Back"
  read -p "Choose country: " cntry

  case $cntry in
    1) dns="${dns_iran[$game]}" ;;
    2) dns="${dns_uae[$game]}" ;;
    3) dns="${dns_turkey[$game]}" ;;
    4) dns="${dns_other[$game]}" ;;
    5) return ;;
    *) echo "Invalid"; read -p "Press Enter..."; return ;;
  esac

  if [[ -z "$dns" ]]; then
    echo -e "\n\033[1;31mDNS not found. Showing random high-performance DNS:\033[0m"
    list=("1.1.1.1,1.0.0.1" "8.8.8.8,8.8.4.4" "9.9.9.9,149.112.112.112")
    dns="${list[$RANDOM % ${#list[@]}]}"
  fi

  IFS=',' read -r dns1 dns2 <<< "$dns"
  echo -e "\nRecommended DNS for \033[1m$game\033[0m:"
  show_dns "$dns1" "$dns2"
  read -p "Press Enter to return..." && return
}

# Function: Download DNS
function download_dns() {
  show_title
  echo -e "\nChoose Country:"
  echo "1) Iran"
  echo "2) UAE"
  echo "3) Turkey"
  echo "4) Other"
  echo "5) ← Back"
  read -p "Country: " dc
  dns=("1.1.1.1,1.0.0.1" "8.8.8.8,8.8.4.4" "9.9.9.9,149.112.112.112")
  picked="${dns[$RANDOM % ${#dns[@]}]}"
  IFS=',' read -r dns1 dns2 <<< "$picked"
  echo -e "\nTop Download DNS:"
  show_dns "$dns1" "$dns2"
  read -p "Press Enter to return..." && return
}

# Function: Premium DNS
function premium_dns() {
  show_title
  echo -e "\n\033[1;33mPREMIUM DNS (Ultra Low Ping <40ms)\033[0m"
  dns=("94.140.14.14,94.140.15.15" "1.1.1.1,1.0.0.1" "8.8.8.8,8.8.4.4")
  picked="${dns[$RANDOM % ${#dns[@]}]}"
  IFS=',' read -r dns1 dns2 <<< "$picked"
  show_dns "$dns1" "$dns2"
  read -p "Press Enter to return..." && return
}

# Function: Search DNS
function search_dns() {
  show_title
  read -p "Enter game name: " search
  dns="${dns_iran[$search]}"
  if [[ -n "$dns" ]]; then
    IFS=',' read -r dns1 dns2 <<< "$dns"
    echo -e "\nDNS for $search:"
    show_dns "$dns1" "$dns2"
  else
    echo -e "\n\033[1;31mGame not found!\033[0m"
  fi
  read -p "Press Enter to return..." && return
}

# Function: Ping
function ping_check() {
  show_title
  read -p "Enter DNS IP to ping: " ip
  echo -e "\nPinging $ip ..."
  ping -c 3 $ip
  read -p "Press Enter to return..." && return
}

# Start the script
main_menu
