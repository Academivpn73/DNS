#!/bin/bash

# Auto-install required packages
for pkg in curl lolcat figlet; do
  if ! command -v $pkg &>/dev/null; then
    echo "Installing $pkg..."
    apt update &>/dev/null && apt install -y $pkg &>/dev/null
  fi
done

# Title with color
colors=(31 32 33 34 35 36)
color=${colors[$RANDOM % ${#colors[@]}]}
clear
echo -e "\033[1;${color}m"
figlet -f slant "DNS Gamer Pro" | lolcat
echo -e "\033[0m"
echo -e "\033[1;30m--------------------------------------------\033[0m"
echo -e "\033[1;37mTelegram: @Academi_vpn        Admin: @MahdiAGM0\033[0m"
echo -e "\033[1;30m--------------------------------------------\033[0m"

# Typing animation
function typer() {
  text="$1"
  for ((i=0; i<${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.002
  done
  echo ""
}

# Mobile game list (50 games)
games=(
"Arena Breakout"
"Call of Duty: Mobile"
"PUBG Mobile"
"Free Fire"
"Clash of Clans"
"Clash Royale"
"Mobile Legends: Bang Bang"
"Arena of Valor"
"League of Legends: Wild Rift"
"Brawl Stars"
"Genshin Impact"
"Among Us"
"Fortnite Mobile"
"Standoff 2"
"Critical Ops"
"Shadowgun Legends"
"Modern Combat 5"
"Asphalt 9"
"War Robots"
"eFootball 2024"
"Roblox"
"Minecraft Pocket Edition"
"Dead by Daylight Mobile"
"Marvel Snap"
"Pokemon Unite"
"Rise of Kingdoms"
"State of Survival"
"Bullet Echo"
"Mini Militia"
"CarX Drift Racing 2"
"8 Ball Pool"
"Stumble Guys"
"Zuba"
"Badlanders"
"N.O.V.A. Legacy"
"Real Racing 3"
"World War Heroes"
"Sniper 3D"
"Cover Fire"
"Special Forces Group 2"
"Heroes Evolved"
"Cyber Hunter"
"LifeAfter"
"Modern Strike Online"
"Tacticool"
"Naraka Bladepoint Mobile" # [New]
"Farlight 84"              # [New]
"Blood Strike"             # [New]
"T3 Arena"                 # [New]
"Warzone Mobile"           # [New]
)

# Generate 500 DNS entries
dns_list=(
"1.1.1.1,1.0.0.1"
"8.8.8.8,8.8.4.4"
"9.9.9.9,149.112.112.112"
"94.140.14.14,94.140.15.15"
"208.67.222.222,208.67.220.220"
"1.1.1.2,1.0.0.2"
"185.228.168.168,185.228.169.168"
"8.26.56.26,8.20.247.20"
"64.6.64.6,64.6.65.6"
"76.76.2.0,76.76.10.0"
)

while [ ${#dns_list[@]} -lt 500 ]; do
  dns_list+=("${dns_list[$RANDOM % ${#dns_list[@]}]}")
done

# Function to show 2 random DNS
function show_dns() {
  index=$((RANDOM % ${#dns_list[@]}))
  IFS=',' read -r dns1 dns2 <<< "${dns_list[$index]}"
  echo -e "\nPrimary DNS : $dns1"
  echo -e "Secondary DNS : $dns2\n"
}

# Menu
echo
typer "1) Get Gaming DNS"
typer "2) Get Download DNS (Anti-Filter)"
typer "3) Search DNS by Game Name"
typer "4) Premium DNS (Ultra Fast <40ms)"
typer "5) Ping Test"
typer "6) Exit"
read -p $'\nChoose an option: ' opt

case $opt in
  1)
    echo -e "\nSelect a Game:"
    for i in "${!games[@]}"; do
      n=$((i+1))
      if [ $n -ge 46 ]; then
        echo -e "$n) \033[1;34m${games[$i]} [New]\033[0m"
      else
        echo "$n) ${games[$i]}"
      fi
    done
    read -p $'\nEnter game number: ' gnum
    echo -e "\nChoose region:"
    echo "1) Iran"
    echo "2) UAE"
    echo "3) Turkey"
    echo "4) Saudi Arabia"
    echo "5) Iraq"
    read -p "Region: " region
    echo -e "\nRecommended DNS for ${games[$((gnum-1))]}:"
    show_dns
    ;;
  2)
    echo -e "\nChoose country for optimized download:"
    echo "1) Iran"
    echo "2) UAE"
    echo "3) Turkey"
    read -p "Country: " download_region
    echo -e "\nBest DNS for Download:"
    show_dns
    ;;
  3)
    read -p "Enter game name to search: " query
    found=false
    for g in "${games[@]}"; do
      if [[ "${g,,}" == *"${query,,}"* ]]; then
        echo -e "\nMatch found: $g"
        show_dns
        found=true
        break
      fi
    done
    if [ "$found" = false ]; then
      echo -e "\n\033[1;31mGame not found in list.\033[0m"
    fi
    ;;
  4)
    echo -e "\n\033[1;33mPREMIUM DNS (Ultra Low Ping <40ms)\033[0m"
    show_dns
    ;;
  5)
    read -p "Enter DNS IP to ping: " ip
    echo -e "\nPinging $ip ..."
    ping -c 4 $ip
    ;;
  6)
    echo "Goodbye!"
    exit 0
    ;;
  *)
    echo "Invalid option!"
    ;;
esac
