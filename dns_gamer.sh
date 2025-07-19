#!/bin/bash

# Dependencies
dependencies=(curl ping)
for dep in "${dependencies[@]}"; do
  command -v $dep >/dev/null 2>&1 || { echo >&2 "Please install $dep."; exit 1; }
done

# Color list
colors=(31 32 33 34 35 36)

# Typing animation
typer() {
  text="$1"
  for ((i = 0; i < ${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.0008
  done
  echo
}

# Header with optional figlet/lolcat
print_header() {
  clear
  color=${colors[$RANDOM % ${#colors[@]}]}
  if command -v figlet >/dev/null 2>&1 && command -v lolcat >/dev/null 2>&1; then
    echo -e "\033[1;${color}m"
    figlet -f slant "DNS Gamer Pro" | lolcat
    echo -e "\033[0m"
  else
    echo -e "\033[1;${color}m===== DNS Gamer Pro =====\033[0m"
  fi

  echo -e "\033[1;${color}m+------------------------------------------+\033[0m"
  echo -e "\033[1;${color}m| Telegram: @Academi_vpn                   |\033[0m"
  echo -e "\033[1;${color}m| Admin:    @MahdiAGM0                     |\033[0m"
  echo -e "\033[1;${color}m| Version:  1.2.3                          |\033[0m"
  echo -e "\033[1;${color}m+------------------------------------------+\033[0m"
  echo
}

# Show DNS with ping
show_dns() {
  dns="$1"
  ping_time=$(ping -c 1 -W 1 $dns 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
  if [[ -z "$ping_time" ]]; then
    ping_time="Ping failed"
  else
    ping_time="${ping_time}ms"
  fi
  echo -e "\n\033[1;37m$dns\033[0m"
  echo -e "Ping: \033[1;32m$ping_time\033[0m"
}

# DNS data
gaming_dns=("1.1.1.1" "9.9.9.9" "94.140.14.14" "76.76.2.0" "185.51.200.2")
download_dns=("178.22.122.100" "10.202.10.202" "185.51.200.2" "1.0.0.1")
premium_dns=("45.90.28.0" "94.140.14.14" "8.8.4.4" "1.1.1.1" "208.67.222.222")

games=(
"Call of Duty Mobile"
"Arena Breakout (New)"
"PUBG Mobile"
"Free Fire"
"Mobile Legends"
"Brawl Stars"
"Clash Royale"
"Clash of Clans"
"Fortnite Mobile"
"War Robots"
"League of Legends Wild Rift"
"Apex Legends Mobile"
"Among Us"
"FIFA Mobile"
"eFootball 2024 (New)"
"Honkai Impact"
"Genshin Impact"
"Marvel Future Fight"
"Modern Combat 5"
"Shadowgun Legends"
"World of Tanks Blitz"
"Asphalt 9"
"Roblox"
"Zooba"
"Critical Ops"
"Cyber Hunter"
"Dead by Daylight Mobile"
"Dragon Ball Legends"
"Garena AOV"
"Hero Hunters"
"Last Day on Earth"
"Mobile Suit Gundam"
"Minecraft PE"
"Omega Legends"
"Pixel Gun 3D"
"Rogue Company Mobile"
"Sky Children of the Light"
"Standoff 2"
"Tacticool"
"Teamfight Tactics"
"Tower of Fantasy (New)"
"Vainglory"
"Warface Mobile"
"Wild Rift"
"ZombsRoyale"
"World War Heroes"
"Modern Strike"
"Battle Prime"
"Creative Destruction"
)

countries=("Iran" "UAE" "Turkey" "Saudi Arabia" "Iraq")

# Main menu
while true; do
  print_header
  typer "📌 Select an option:"
  typer "1️⃣  Gaming DNS"
  typer "2️⃣  Download DNS (Anti-Filter)"
  typer "3️⃣  Search Game DNS 🔍 (New)"
  typer "4️⃣  Premium DNS 💎 (New)"
  typer "5️⃣  Ping DNS 📶 (New)"
  typer "6️⃣  Exit ❌"
  read -p $'\nEnter choice: ' choice

  case $choice in
    1)
      print_header
      typer "🎮 Gaming DNS:"
      show_dns "${gaming_dns[$RANDOM % ${#gaming_dns[@]}]}"
      read -p $'\nPress Enter to return...'
      ;;
    2)
      print_header
      typer "📥 Download DNS:"
      show_dns "${download_dns[$RANDOM % ${#download_dns[@]}]}"
      read -p $'\nPress Enter to return...'
      ;;
    3)
      print_header
      read -p "Enter game name: " search
      found=false
      for g in "${games[@]}"; do
        if [[ "${g,,}" == *"${search,,}"* ]]; then
          found=true
          echo -e "\n✅ Game found: \033[1;36m$g\033[0m"
          echo "Select Region:"
          select reg in "${countries[@]}"; do
            echo -e "\n🎯 Best DNS for $g in $reg:"
            show_dns "${gaming_dns[$RANDOM % ${#gaming_dns[@]}]}"
            break
          done
        fi
      done
      if [ "$found" = false ]; then
        echo -e "\n\033[1;33m⚠️ Game not found.\033[0m"
      fi
      read -p $'\nPress Enter to return...'
      ;;
    4)
      print_header
      typer "💎 Premium DNS:"
      show_dns "${premium_dns[$RANDOM % ${#premium_dns[@]}]}"
      read -p $'\nPress Enter to return...'
      ;;
    5)
      print_header
      read -p "Enter DNS to ping: " userdns
      show_dns "$userdns"
      read -p $'\nPress Enter to return...'
      ;;
    6)
      typer "Goodbye! 👋"
      exit 0
      ;;
    *)
      echo -e "\nInvalid choice!"
      sleep 1
      ;;
  esac
done
