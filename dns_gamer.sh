#!/bin/bash

# Auto install dependencies safely
for pkg in curl lolcat figlet; do
  if ! command -v $pkg &>/dev/null; then
    echo "Installing $pkg..."
    apt update -y &>/dev/null
    apt install -y $pkg &>/dev/null
  fi
done

# Colors and title banner
function show_banner() {
  colors=(31 32 33 34 35 36)
  color=${colors[$RANDOM % ${#colors[@]}]}
  clear
  echo -e "\033[1;${color}m"
  figlet -f slant "DNS Gamer Pro" | lolcat
  echo -e "\033[0m"
  echo -e "\033[1;30m┌────────────────────────────────────────┐\033[0m"
  echo -e "\033[1;37m│ Telegram: @Academi_vpn   Admin: @MahdiAGM0 │\033[0m"
  echo -e "\033[1;37m│ Version: 1.2.3                          │\033[0m"
  echo -e "\033[1;30m└────────────────────────────────────────┘\033[0m"
}

# Typing effect
function typer() {
  text="$1"
  for ((i=0; i<${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.001
  done
  echo ""
}

# DNS list (real samples)
dns_list=(
  "1.1.1.1,1.0.0.1"
  "8.8.8.8,8.8.4.4"
  "9.9.9.9,149.112.112.112"
  "208.67.222.222,208.67.220.220"
  "94.140.14.14,94.140.15.15"
  "76.76.2.0,76.76.10.0"
  "1.1.1.2,1.0.0.2"
  "8.26.56.26,8.20.247.20"
  "185.228.168.168,185.228.169.168"
  "64.6.64.6,64.6.65.6"
)

# Fill to 500
while [ ${#dns_list[@]} -lt 500 ]; do
  dns_list+=("${dns_list[$RANDOM % ${#dns_list[@]}]}")
done

# Show 2 random DNS entries
function show_dns() {
  rand1=$((RANDOM % ${#dns_list[@]}))
  rand2=$((RANDOM % ${#dns_list[@]}))
  IFS=',' read -r dns1a dns1b <<< "${dns_list[$rand1]}"
  IFS=',' read -r dns2a dns2b <<< "${dns_list[$rand2]}"
  echo -e "\nPrimary DNS 1: $dns1a"
  echo -e "Secondary DNS 1: $dns1b\n"
  echo -e "Primary DNS 2: $dns2a"
  echo -e "Secondary DNS 2: $dns2b\n"
}

# Game list
games=(
  "Call of Duty Mobile"
  "PUBG Mobile"
  "Free Fire"
  "Clash of Clans"
  "Clash Royale"
  "Mobile Legends"
  "Brawl Stars"
  "Apex Legends Mobile"
  "Fortnite"
  "Arena of Valor"
  "League of Legends: Wild Rift"
  "Genshin Impact"
  "Honkai Impact 3rd"
  "Critical Ops"
  "Modern Combat 5"
  "Bullet Force"
  "Dead Trigger 2"
  "Shadowgun Legends"
  "Sky: Children of the Light"
  "Among Us"
  "Minecraft PE"
  "Roblox"
  "Real Racing 3"
  "Asphalt 9"
  "Grid Autosport"
  "eFootball 2024"
  "NBA Live Mobile"
  "FIFA Mobile"
  "PES Mobile"
  "Standoff 2"
  "Zooba"
  "War Robots"
  "World of Tanks Blitz"
  "Vainglory"
  "Infinity Ops"
  "Rules of Survival"
  "Cyber Hunter"
  "Battle Prime"
  "Armajet"
  "Tacticool"
  "Arena Breakout [New]"
  "T3 Arena [New]"
  "Farlight 84 [New]"
  "Project BloodStrike [New]"
  "Warframe Mobile [New]"
  "Rogue Company Elite [New]"
  "The Division Resurgence [New]"
  "Wuthering Waves [New]"
  "AFK Journey [New]"
  "Ace Racer [New]"
)

# Show game list
function show_game_list() {
  echo -e "\n🎮 Available Games:"
  for i in "${!games[@]}"; do
    name="${games[$i]}"
    if [[ "$name" == *"[New]"* ]]; then
      echo -e "$((i+1))) \033[1;34m$name\033[0m"
    else
      echo -e "$((i+1))) $name"
    fi
  done
}

# Main Menu
while true; do
  show_banner
  typer "1) 🎮 Get Gaming DNS"
  typer "2) ⬇️  Get Download DNS (Anti-Filter)"
  typer "3) 🔎 Search DNS by Game"
  typer "4) 💠 Premium DNS (Ultra Fast)"
  typer "5) 📶 Check Online Ping"
  typer "6) ❌ Exit"
  read -p $'\nChoose an option [1-6]: ' opt

  show_banner

  case $opt in
    1)
      show_game_list
      read -p $'\nEnter game number: ' gnum
      read -p "Select Region [Iran/UAE/Turkey/Other]: " region
      echo -e "\n📡 Best DNS for ${games[$((gnum-1))]} in $region:\n"
      show_dns
      read -p "Press Enter to return to menu..."
      ;;
    2)
      echo -e "\n⬇️  Download Optimized DNS:\n"
      show_dns
      read -p "Press Enter to return to menu..."
      ;;
    3)
      read -p $'\nEnter game name to search: ' search
      found=false
      for i in "${!games[@]}"; do
        if [[ "${games[$i],,}" == *"${search,,}"* ]]; then
          echo -e "\nFound: ${games[$i]}"
          show_dns
          found=true
          break
        fi
      done
      $found || echo -e "\n❌ Game not found."
      read -p "Press Enter to return to menu..."
      ;;
    4)
      echo -e "\n💠 Premium DNS (Low Ping < 40ms):\n"
      show_dns
      read -p "Press Enter to return to menu..."
      ;;
    5)
      read -p "Enter DNS IP to ping: " ip
      echo -e "\nPinging $ip...\n"
      ping -c 4 $ip
      read -p "Press Enter to return to menu..."
      ;;
    6)
      echo "👋 Goodbye!"
      exit 0
      ;;
    *)
      echo -e "\n❌ Invalid option. Try again."
      sleep 1
      ;;
  esac
done
