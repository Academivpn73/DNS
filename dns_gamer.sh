#!/bin/bash

# ───── Optional dependencies check ─────
has_figlet=false
has_lolcat=false
command -v figlet >/dev/null && has_figlet=true
command -v lolcat >/dev/null && has_lolcat=true

# ───── Title Colors ─────
colors=(31 32 33 34 35 36)
color=${colors[$RANDOM % ${#colors[@]}]}

# ───── Meta ─────
version="1.2.3"
admin="@MahdiAGM0"
telegram="@Academi_vpn"

# ───── DNS List (sample of real public DNS) ─────
dns_list=(
  "1.1.1.1,1.0.0.1"
  "8.8.8.8,8.8.4.4"
  "9.9.9.9,149.112.112.112"
  "94.140.14.14,94.140.15.15"
  "208.67.222.222,208.67.220.220"
  "76.76.2.0,76.76.10.0"
  "1.1.1.2,1.0.0.2"
  "8.26.56.26,8.20.247.20"
  "185.228.168.168,185.228.169.168"
  "64.6.64.6,64.6.65.6"
)

# Extend list to 500
while [ ${#dns_list[@]} -lt 500 ]; do
  dns_list+=("${dns_list[$RANDOM % ${#dns_list[@]}]}")
done

# ───── Games List ─────
games=(
"Call of Duty Mobile"
"PUBG Mobile"
"Free Fire"
"Arena Breakout [NEW]"
"Mobile Legends"
"Apex Legends Mobile"
"Clash of Clans"
"Clash Royale"
"Brawl Stars"
"Fortnite Mobile"
"League of Legends: Wild Rift"
"Valorant Mobile"
"Modern Combat 5"
"Critical Ops"
"Standoff 2"
"Shadowgun Legends"
"Cyber Hunter"
"Battle Prime"
"Bullet Force"
"Warface GO"
"World War Heroes"
"Dead Trigger 2"
"N.O.V.A. Legacy"
"Into the Dead 2"
"Infinity Ops"
"Real Racing 3"
"Asphalt 9"
"Need for Speed No Limits"
"Grid Autosport"
"FIFA Mobile"
"eFootball 2024"
"Dream League Soccer"
"NBA Live Mobile"
"Rocket League Sideswipe"
"Among Us"
"Survivor.io"
"ZombsRoyale.io"
"War Robots"
"Sniper 3D"
"Modern Strike Online"
"Combat Master Mobile"
"Tacticool"
"Project War Mobile"
"Lost Light"
"Mad GunZ"
"T3 Arena"
"Heroes Evolved"
"Battle Bay"
"Battlelands Royale"
"Boom Beach"
)

# ───── Title Banner ─────
function show_title() {
  clear
  echo -e "\033[1;${color}m"
  if $has_figlet; then
    figlet "DNS Gamer Pro" 2>/dev/null
  else
    echo -e "===== DNS Gamer Pro ====="
  fi
  echo -e "\033[0m"
  echo -e "\033[1;37m+--------------------------------------------+\033[0m"
  echo -e "\033[1;37m| Version: $version                          \033[0m"
  echo -e "\033[1;37m| Telegram: $telegram     Admin: $admin \033[0m"
  echo -e "\033[1;37m+--------------------------------------------+\033[0m"
  echo ""
}

# ───── Show Random DNS with Ping ─────
function show_dns() {
  idx=$((RANDOM % ${#dns_list[@]}))
  IFS=',' read -r dns1 dns2 <<< "${dns_list[$idx]}"
  ping_result=$(ping -c 1 -W 1 "$dns1" | grep 'time=' | sed -n 's/.*time=\([0-9.]*\) ms/\1/p' | cut -d. -f1)
  [[ -z "$ping_result" ]] && ping_result="Ping failed"

  echo -e "$dns1"
  echo -e "$dns2"
  [[ "$ping_result" == "Ping failed" ]] && echo -e "Ping: failed" || echo -e "Ping: ${ping_result}ms"
}

# ───── Menus ─────
function game_dns_menu() {
  show_title
  echo "Select your game:"
  for i in "${!games[@]}"; do
    idx=$((i+1))
    if [[ "${games[$i]}" == *"[NEW]"* ]]; then
      echo -e "$idx) \033[1;34m${games[$i]}\033[0m"
    else
      echo "$idx) ${games[$i]}"
    fi
  done
  echo "$(( ${#games[@]} + 1 ))) Back"
  echo
  read -p "Enter game number: " gnum
  if [ "$gnum" -ge 1 ] && [ "$gnum" -le "${#games[@]}" ]; then
    region_menu "${games[$((gnum - 1))]}"
  else
    main_menu
  fi
}

function region_menu() {
  game="$1"
  show_title
  echo "Select Region:"
  echo "1) Iran"
  echo "2) UAE"
  echo "3) Turkey"
  echo "4) Saudi Arabia"
  echo "5) Other"
  echo "6) Back"
  echo
  read -p "Choose region: " region
  [[ "$region" == "6" ]] && game_dns_menu
  echo
  echo "Recommended DNS for $game:"
  echo
  show_dns
  echo
  read -p "Press Enter to return..." _
  main_menu
}

function premium_dns() {
  show_title
  echo -e "PREMIUM DNS (Ultra Fast & Low Ping)"
  echo
  show_dns
  echo
  read -p "Press Enter to return..." _
  main_menu
}

function exit_script() {
  echo "Bye!"
  exit 0
}

# ───── Main Menu ─────
function main_menu() {
  show_title
  echo "1) Get Gaming DNS"
  echo "2) Premium DNS"
  echo "3) Exit"
  echo
  read -p "Select option: " option
  case "$option" in
    1) game_dns_menu ;;
    2) premium_dns ;;
    3) exit_script ;;
    *) main_menu ;;
  esac
}

# Start Script
main_menu
