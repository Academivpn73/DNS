#!/bin/bash

# ───────────── Auto Install Dependencies ─────────────
for pkg in curl lolcat figlet; do
  if ! command -v $pkg &>/dev/null; then
    echo "Installing $pkg..."
    apt update -y &>/dev/null && apt install -y $pkg &>/dev/null
  fi
done

# ───────────── Variables ─────────────
version="1.2.3"
telegram="@Academi_vpn"
admin="@MahdiAGM0"

games=(
  "Call of Duty Mobile"
  "PUBG Mobile"
  "Free Fire"
  "Arena Breakout [NEW]"
  "Clash Royale"
  "Clash of Clans"
  "Mobile Legends"
  "Genshin Impact"
  "Fortnite"
  "Apex Legends Mobile"
  "FIFA Mobile"
  "Wild Rift"
  "Pokemon Unite"
  "Brawl Stars"
  "Among Us"
  "Roblox"
  "Minecraft"
  "Valorant Mobile"
  "Rocket League Sideswipe"
  "League of Legends"
  "Battle Prime"
  "Warface GO"
  "Modern Combat Versus"
  "Critical Ops"
  "T3 Arena"
  "Badlanders"
  "Shadowgun War Games"
  "Cyber Hunter"
  "Bullet Echo"
  "Zula Mobile"
  "Heroes Evolved"
  "War Robots"
  "Infinity Ops"
  "Sky: Children of the Light"
  "Chrono Legacy"
  "Modern Strike Online"
  "N.O.V.A. Legacy"
  "Dead Trigger 2"
  "Sniper 3D"
  "Into the Dead 2"
  "MaskGun"
  "Guns of Boom"
  "World War Heroes"
  "Gods of Boom"
  "Iron Blade"
  "Dead Effect 2"
  "Standoff 2"
  "Battlelands Royale"
  "Modern Warplanes"
  "Payback 2"
)

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

while [ ${#dns_list[@]} -lt 500 ]; do
  dns_list+=("${dns_list[$RANDOM % ${#dns_list[@]}]}")
done

# ───────────── Colorful Title ─────────────
function show_title() {
  colors=(31 32 33 34 35 36)
  color=${colors[$RANDOM % ${#colors[@]}]}
  clear
  echo -e "\033[1;${color}m"
  figlet -f slant "DNS Gamer Pro" | lolcat
  echo -e "\033[0m"
  echo -e "\033[1;30m+------------------------------------------+\033[0m"
  echo -e "\033[1;37m| Telegram: $telegram       Admin: $admin\033[0m"
  echo -e "\033[1;37m| Version: $version                               \033[0m"
  echo -e "\033[1;30m+------------------------------------------+\033[0m"
}

# ───────────── Typing Effect ─────────────
function typer() {
  text="$1"
  for ((i = 0; i < ${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.002
  done
  echo ""
}

# ───────────── Show DNS ─────────────
function show_dns() {
  random_index=$((RANDOM % ${#dns_list[@]}))
  IFS=',' read -r dns1 dns2 <<<"${dns_list[$random_index]}"
  echo -e "\nPrimary DNS: $dns1"
  ping -c 1 -W 1 "$dns1" | grep "time=" || echo "Ping failed"
  echo -e "\nSecondary DNS: $dns2"
  ping -c 1 -W 1 "$dns2" | grep "time=" || echo "Ping failed"
  echo
  read -p "Press Enter to return..." _
}

# ───────────── Game Selection ─────────────
function game_list() {
  for i in "${!games[@]}"; do
    index=$((i + 1))
    if [[ "${games[$i]}" == *"[NEW]"* ]]; then
      echo -e "$index) \033[1;34m${games[$i]}\033[0m"
    else
      echo "$index) ${games[$i]}"
    fi
  done
  echo "$((i + 2))) Back"
}

# ───────────── Region Selection ─────────────
function region_menu() {
  echo -e "\nSelect Region:"
  echo "1) Iran"
  echo "2) UAE"
  echo "3) Turkey"
  echo "4) Saudi Arabia"
  echo "5) Iraq"
  echo "6) Back"
  read -p "Choose country: " rgn
  if [[ $rgn == 6 ]]; then
    main_menu
  fi
}

# ───────────── Main Menu ─────────────
function main_menu() {
  show_title
  typer "1) Get Gaming DNS"
  typer "2) Get Download DNS (Anti-Filter)"
  typer "3) Search DNS by Game"
  typer "4) Premium DNS (Ultra Fast)"
  typer "5) Check Online Ping"
  typer "6) Exit"
  read -p $'\nChoose an option: ' opt

  case $opt in
  1)
    show_title
    echo -e "\nSelect Game:"
    game_list
    read -p "Enter game number: " gnum
    [[ $gnum -gt ${#games[@]} ]] && main_menu
    region_menu
    echo -e "\nRecommended DNS for ${games[$((gnum - 1))]}:"
    show_dns
    main_menu
    ;;
  2)
    show_title
    region_menu
    echo -e "\nBest Download DNS for selected region:"
    show_dns
    main_menu
    ;;
  3)
    show_title
    read -p "Enter game name: " gname
    found="false"
    for i in "${games[@]}"; do
      if [[ "${i,,}" == *"${gname,,}"* ]]; then
        echo -e "\nGame found: $i"
        region_menu
        show_dns
        found="true"
        break
      fi
    done
    [[ $found == "false" ]] && echo -e "\nGame not found."
    read -p "Press Enter to return..." _
    main_menu
    ;;
  4)
    show_title
    echo -e "\n\033[1;33mPREMIUM DNS (Ultra Fast, <40ms)\033[0m"
    show_dns
    main_menu
    ;;
  5)
    show_title
    read -p "Enter DNS to ping: " pdns
    ping -c 4 "$pdns"
    read -p "Press Enter to return..." _
    main_menu
    ;;
  6)
    echo -e "\nGoodbye!"
    exit 0
    ;;
  *)
    echo "Invalid option."
    main_menu
    ;;
  esac
}

main_menu
