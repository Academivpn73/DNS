#!/bin/bash

# Check and install required tools silently
for tool in curl ping; do
  command -v $tool &> /dev/null || { echo "Installing $tool..."; apt update -y &>/dev/null; apt install -y $tool &>/dev/null; }
done

# Optional visual tools
has_figlet=false
has_lolcat=false
command -v figlet &>/dev/null && has_figlet=true
command -v lolcat &>/dev/null && has_lolcat=true

# Colors
colors=(31 32 33 34 35 36)
get_color() {
  echo "${colors[$RANDOM % ${#colors[@]}]}"
}

# Typing animation
typing() {
  speed=0.008
  text="$1"
  for ((i=0; i<${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep $speed
  done
  echo
}

# Title section
draw_title() {
  clear
  color=$(get_color)
  echo -e "\033[1;${color}m"
  if $has_figlet && $has_lolcat; then
    figlet "DNS Gamer Pro" | lolcat
  else
    typing "===== DNS Gamer Pro ====="
  fi
  echo -e "\033[0m"

  box="+------------------------------------------+"
  echo -e "\033[1;${color}m$box"
  echo -e "| Telegram: @Academi_vpn                   |"
  echo -e "| Admin:    @MahdiAGM0                     |"
  echo -e "| Version:  1.2.3                          |"
  echo -e "$box\033[0m"
  echo
}

# Simulated premium DNS pool
dns_pool=(
"1.1.1.1,1.0.0.1"
"8.8.8.8,8.8.4.4"
"9.9.9.9,149.112.112.112"
"94.140.14.14,94.140.15.15"
"76.76.2.0,76.76.10.0"
"208.67.222.222,208.67.220.220"
"185.228.168.168,185.228.169.168"
"1.1.1.2,1.0.0.2"
"8.26.56.26,8.20.247.20"
"64.6.64.6,64.6.65.6"
)

get_random_dns() {
  random_index=$((RANDOM % ${#dns_pool[@]}))
  echo "${dns_pool[$random_index]}"
}

ping_dns() {
  ip="$1"
  ping -c 1 -W 1 "$ip" | grep "time=" | awk -F"time=" '{print $2}' | cut -d' ' -f1
}

show_dns_result() {
  IFS=',' read -r d1 d2 <<< "$(get_random_dns)"
  ping1=$(ping_dns $d1)
  [ -z "$ping1" ] && ping1="Fail"
  echo -e "\n$d1\n$d2\nPing: $ping1 ms"
}

# Game list
games=(
"Call of Duty Mobile"
"PUBG Mobile"
"Arena Breakout [NEW]"
"Free Fire"
"Genshin Impact [NEW]"
"League of Legends: Wild Rift"
"Mobile Legends"
"Fortnite"
"Clash Royale"
"Clash of Clans"
"Among Us"
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

# Start menu
while true; do
  draw_title
  echo "📌 1) Gaming DNS"
  echo "📥 2) Download DNS"
  echo "💎 3) Premium DNS [NEW]"
  echo "🎮 4) Search Game [NEW]"
  echo "📶 5) Ping a DNS  [NEW]"
  echo "🚪 6) Exit"
  echo
  read -p "Choose an option: " opt

  case $opt in
    1)
      draw_title
      echo "🎮 Gaming DNS"
      for i in "${!games[@]}"; do
        echo "$((i+1)). ${games[$i]}"
      done
      read -p $'\nChoose game number: ' gindex
      [ -z "${games[$((gindex-1))]}" ] && continue
      echo
      select c in "${countries[@]}"; do
        echo -e "\n🌐 $c - DNS for ${games[$((gindex-1))]}:"
        show_dns_result
        break
      done
      read -p $'\nPress Enter to return...'
      ;;
    2)
      draw_title
      echo "📥 Download DNS"
      select c in "${countries[@]}"; do
        echo -e "\n🌐 $c - Download Optimized DNS:"
        show_dns_result
        break
      done
      read -p $'\nPress Enter to return...'
      ;;
    3)
      draw_title
      echo "💎 Premium Ultra Fast DNS"
      show_dns_result
      read -p $'\nPress Enter to return...'
      ;;
    4)
      draw_title
      read -p "🔎 Enter game name: " gname
      found=false
      for g in "${games[@]}"; do
        clean_g=$(echo "$g" | sed 's/ \[NEW\]//g')
        if [[ "${clean_g,,}" == *"${gname,,}"* ]]; then
          echo -e "\nGame found: $clean_g"
          select c in "${countries[@]}"; do
            echo -e "\n🌐 $c - DNS for $clean_g:"
            show_dns_result
            break
          done
          found=true
          break
        fi
      done
      if ! $found; then
        echo -e "\033[1;33m⚠️ Game not found in list.\033[0m"
      fi
      read -p $'\nPress Enter to return...'
      ;;
    5)
      draw_title
      read -p "📶 Enter DNS IP to ping: " userdns
      echo -e "\nPinging $userdns..."
      ping -c 4 "$userdns"
      read -p $'\nPress Enter to return...'
      ;;
    6)
      echo -e "\n👋 Bye!"
      exit 0
      ;;
    *)
      echo "❌ Invalid option."
      sleep 1
      ;;
  esac
done
