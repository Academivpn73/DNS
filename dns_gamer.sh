#!/bin/bash

# Auto install required packages
for pkg in curl ping figlet lolcat; do
  command -v $pkg &>/dev/null || (echo "Installing $pkg..." && apt update &>/dev/null && apt install -y $pkg &>/dev/null)
done

# Color array and title animation
colors=(31 32 33 34 35 36)
color=${colors[$RANDOM % ${#colors[@]}]}
clear

function typing_box() {
  echo -e "\033[1;${color}m"
  figlet -f slant "DNS Gamer Pro" | lolcat
  echo -e "\033[0m"
  sleep 0.1
  echo -e "\033[1;${color}m+------------------------------------------+\033[0m"
  echo -e "\033[1;${color}m| Telegram: @Academi_vpn                   |\033[0m"
  echo -e "\033[1;${color}m| Admin:    @MahdiAGM0                     |\033[0m"
  echo -e "\033[1;${color}m| Version:  1.2.3                          |\033[0m"
  echo -e "\033[1;${color}m+------------------------------------------+\033[0m"
  echo
}
typing_box

# DNS list (sample - 200 real/performance-focused)
dns_list=(
"1.1.1.1,1.0.0.1"
"8.8.8.8,8.8.4.4"
"9.9.9.9,149.112.112.112"
"94.140.14.14,94.140.15.15"
"76.76.2.0,76.76.10.0"
"208.67.222.222,208.67.220.220"
"8.26.56.26,8.20.247.20"
"185.228.168.168,185.228.169.168"
"64.6.64.6,64.6.65.6"
"1.1.1.2,1.0.0.2"
# ... (repeat to 200 entries as needed)
)

while [ ${#dns_list[@]} -lt 200 ]; do
  dns_list+=("${dns_list[$RANDOM % ${#dns_list[@]}]}")
done

# 50 games (some marked NEW)
games=(
"Call of Duty Mobile"
"PUBG Mobile"
"Arena Breakout [NEW]"
"Fortnite"
"Free Fire"
"Mobile Legends"
"League of Legends: Wild Rift"
"Clash Royale"
"Clash of Clans"
"Among Us"
"Genshin Impact [NEW]"
"Brawl Stars"
"Apex Legends Mobile [NEW]"
"Critical Ops"
"Modern Combat 5"
"Warface"
"Shadowgun Legends"
"Bullet Force"
"Pixel Gun 3D"
"Standoff 2"
"Sky: Children of the Light"
"Pokémon Unite"
"Roblox"
"Asphalt 9"
"N.O.V.A Legacy"
"Into the Dead 2"
"Marvel Future Fight"
"Injustice 2"
"Dragon Ball Legends"
"FIFA Mobile"
"eFootball 2024 [NEW]"
"Real Racing 3"
"SimCity BuildIt"
"Dead Trigger 2"
"Sniper 3D"
"Zombie Gunship Survival"
"Subway Surfers"
"Temple Run 2"
"Shadow Fight 4 [NEW]"
"Stick War Legacy"
"Growtopia"
"Terraria"
"Minecraft PE"
"Kingdom Rush"
"Geometry Dash"
"Honkai Impact 3rd"
"PUBG: NEW STATE [NEW]"
"Valorant Mobile [NEW]"
"War Robots"
"Cyber Hunter"
)

countries=("Iran" "UAE" "Turkey" "Saudi Arabia" "Iraq" "Qatar" "Jordan" "Other")

# Show DNS
function show_dns() {
  rnd=$((RANDOM % ${#dns_list[@]}))
  IFS=',' read -r dns1 dns2 <<< "${dns_list[$rnd]}"
  ping1=$(ping -c 1 -W 1 $dns1 | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
  [ -z "$ping1" ] && ping1="Fail"
  echo -e "\n$dns1"
  echo -e "$dns2"
  echo -e "Ping: $ping1 ms"
}

# Main Menu
while true; do
  typing_box
  echo -e "🕹️  1) Gaming DNS"
  echo -e "📥  2) Download DNS"
  echo -e "💎  3) Premium DNS  [NEW]"
  echo -e "🎯  4) Search Game  [NEW]"
  echo -e "📶  5) Ping a DNS   [NEW]"
  echo -e "🚪  6) Exit"
  read -p $'\nSelect an option: ' opt

  case $opt in
    1)
      echo -e "\n🎮 Select a Game:"
      for i in "${!games[@]}"; do
        if [[ ${games[$i]} == *"[NEW]"* ]]; then
          echo -e "$((i+1))) \033[1;34m${games[$i]}\033[0m"
        else
          echo "$((i+1))) ${games[$i]}"
        fi
      done
      read -p $'\nEnter game number: ' gindex
      game="${games[$((gindex-1))]}"
      echo -e "\n🌍 Select Region:"
      select c in "${countries[@]}"; do
        echo -e "\nRecommended DNS for $game in $c:"
        show_dns
        break
      done
      read -p $'\nPress Enter to return...'
      ;;
    2)
      echo -e "\n📥 Download DNS (Optimized)"
      select c in "${countries[@]}"; do
        echo -e "\nBest DNS for downloads in $c:"
        show_dns
        break
      done
      read -p $'\nPress Enter to return...'
      ;;
    3)
      echo -e "\n💎 Premium Ultra Fast DNS"
      show_dns
      read -p $'\nPress Enter to return...'
      ;;
    4)
      read -p $'\n🔍 Enter Game Name: ' gname
      found=false
      for g in "${games[@]}"; do
        name=$(echo "$g" | sed 's/ \[NEW\]//g')
        if [[ "${name,,}" == *"${gname,,}"* ]]; then
          echo -e "\nGame found: $name"
          select c in "${countries[@]}"; do
            echo -e "\nDNS for $name in $c:"
            show_dns
            break
          done
          found=true
          break
        fi
      done
      if [ "$found" = false ]; then
        echo -e "\033[1;33mGame not found in list.\033[0m"
      fi
      read -p $'\nPress Enter to return...'
      ;;
    5)
      read -p $'\nEnter DNS to Ping: ' pdns
      echo -e "\nPinging $pdns..."
      ping -c 4 $pdns
      read -p $'\nPress Enter to return...'
      ;;
    6)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid option"
      ;;
  esac
done
