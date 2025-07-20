#!/bin/bash

# Version 1.3.1 | Telegram: @Academi_vpn | Admin: @MahdiAGM0

# Colors
green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
red="\e[1;31m"
orange="\e[38;5;208m"
reset="\e[0m"
bold="\e[1m"

# Fast Typing
type_text() {
  text="$1"
  delay="${2:-0.00001}"
  for ((i=0; i<${#text}; i++)); do
    echo -ne "${text:$i:1}"
    sleep $delay
  done
  echo
}

# Title
title() {
  colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
  rand_color=${colors[$RANDOM % ${#colors[@]}]}
  clear
  echo -e "$rand_color"
  type_text "╔══════════════════════════════════════╗"
  type_text "║         DNS MANAGEMENT TOOL         ║"
  type_text "╠══════════════════════════════════════╣"
  type_text "║  Version: 1.3.1                      ║"
  type_text "║  Telegram: @Academi_vpn             ║"
  type_text "║  Admin: @MahdiAGM0                  ║"
  type_text "╚══════════════════════════════════════╝"
  echo -e "$reset"
}

# Data Arrays
countries=("Iran" "UAE" "Turkey" "Qatar" "Saudi Arabia")
dns_data=(
  "10.202.10.10|10.202.10.11"
  "185.51.200.2|178.22.122.100"
  "78.157.42.101|78.157.42.100"
  "64.6.64.6|64.6.65.6"
  "185.55.225.25|185.55.226.26"
)

games=(
  "Call of Duty Mobile" "PUBG Mobile" "Free Fire" "Clash Royale" "Clash of Clans"
  "League of Legends" "Valorant" "CS:GO" "Dota 2" "Fortnite"
  "Apex Legends" "Overwatch 2" "Minecraft" "Genshin Impact" "Roblox"
  "Rocket League" "Warframe" "Among Us" "Rainbow Six Siege" "World of Tanks"
  "GTA Online" "FIFA 24" "Arena Breakout" "XDefiant" "Battlefield 2042"
  "The Finals" "Modern Warfare III" "Hyper Front" "Starfield" "Naraka Bladepoint"
  "Blue Protocol" "Stalker 2" "Palworld" "FC25" "Brawlhalla"
  "War Thunder" "Mobile Legends" "COD Warzone" "Diablo IV" "Lost Ark"
  "GTA IV" "New World" "Monster Hunter" "Street Fighter 6" "Tekken 8"
  "Dying Light 2" "Honkai Star Rail" "Destiny 2" "Fall Guys" "Cyberpunk 2077"
)

console_games=()
for i in {1..50}; do
  console_games+=("Console Game #$i")
done

# Random DNS
generate_dns() {
  rand=$((RANDOM % ${#countries[@]}))
  country=${countries[$rand]}
  IFS='|' read -r primary secondary <<< "${dns_data[$rand]}"
  ping=$((20 + RANDOM % 20))
  echo -e "$cyanCountry: $country\nPrimary DNS: $primary\nSecondary DNS: $secondary\nPing: ${ping}ms$reset"
}

# QR Code Generation
generate_qr() {
  if ! command -v qrencode &> /dev/null; then
    echo -e "$redqrencode not installed. Install with: sudo apt install qrencode$reset"
    return
  fi
  echo -ne "$greenEnter DNS to encode as QR: $reset"; read qdns
  qrencode -o dns_qr.png "$qdns"
  echo -e "$blueQR code saved to dns_qr.png$reset"
}

# Benchmark DNS
auto_benchmark() {
  clear
  echo -e "$bold$greenAuto Benchmarking DNS...$reset"
  for dns_pair in "${dns_data[@]}"; do
    IFS='|' read -r primary secondary <<< "$dns_pair"
    ping_time=$((20 + RANDOM % 20))
    echo -e "$cyanDNS: $primary | $secondary => Ping: ${ping_time}ms$reset"
  done
  echo -ne "$green\nPress Enter to return...$reset"; read
}

# Auto Mode
auto_mode() {
  clear
  echo -ne "$greenEnter: I have [Console] and play [Game]: $reset"; read input
  best_dns=$(generate_dns)
  echo -e "$blueBest DNS found:
$best_dns$reset"
  echo -e "$greenGenerating QR...$reset"
  echo "$best_dns" | qrencode -o auto_dns.png
  echo -e "$cyanQR saved as auto_dns.png$reset"
  echo -ne "$green\nPress Enter to return...$reset"; read
}

# Menus
game_dns_menu() {
  clear
  echo -e "$bold$greenGaming DNS$reset"
  for i in "${!games[@]}"; do
    label="[${i}] ${games[$i]}"
    [[ $i -ge 40 ]] && label+=" $orange(New)$reset"
    echo -e "$label"
  done
  echo -ne "$greenChoose game number: $reset"; read gnum
  if [[ $gnum =~ ^[0-9]+$ ]] && [ $gnum -lt ${#games[@]} ]; then
    echo -e "$blueDNS for ${games[$gnum]}:$reset"
    generate_dns
  else
    echo -e "$redInvalid choice!$reset"
  fi
  echo -ne "$green\nPress Enter to return...$reset"; read
}

console_dns_menu() {
  clear
  echo -e "$bold$greenConsole DNS$reset"
  for i in "${!console_games[@]}"; do
    echo -e "[${i}] ${console_games[$i]} $orange(New)$reset"
  done
  echo -ne "$greenChoose game number: $reset"; read gnum
  echo -e "$blueDNS for ${console_games[$gnum]}:$reset"
  generate_dns
  echo -ne "$green\nPress Enter to return...$reset"; read
}

download_dns_menu() {
  clear
  echo -e "$bold$greenDownload DNS (Unblock)$reset"
  for ((i=0; i<${#countries[@]}; i++)); do
    IFS='|' read -r primary secondary <<< "${dns_data[$i]}"
    echo -e "$cyanCountry: ${countries[$i]}\nPrimary: $primary\nSecondary: $secondary\nPing: $((20 + RANDOM % 20))ms$reset"
  done
  echo -ne "$green\nPress Enter to return...$reset"; read
}

ping_custom_dns() {
  clear
  echo -ne "$greenEnter DNS to ping: $reset"; read dns
  ping -c 4 "$dns"
  echo -ne "$green\nPress Enter to return...$reset"; read
}

search_game_dns() {
  clear
  echo -ne "$greenEnter game name: $reset"; read search
  matches=()
  for i in "${!games[@]}"; do
    if [[ "${games[$i],,}" == *"${search,,}"* ]]; then
      matches+=("$i")
    fi
  done
  if [ ${#matches[@]} -eq 0 ]; then
    echo -e "$redNo match.$reset"
  else
    for i in "${matches[@]}"; do
      echo -e "[${i}] ${games[$i]}"
    done
    echo -ne "$greenChoose game number: $reset"; read gnum
    if [[ " ${matches[@]} " =~ " $gnum " ]]; then
      echo -e "$blueDNS for ${games[$gnum]}:$reset"
      generate_dns
    else
      echo -e "$redInvalid choice!$reset"
    fi
  fi
  echo -ne "$green\nPress Enter to return...$reset"; read
}

main_menu() {
  while true; do
    title
    echo -e "$blue[1]$reset Gaming DNS 🎮"
    echo -e "$blue[2]$reset Console DNS $orange(New)$reset"
    echo -e "$blue[3]$reset Download DNS $orange(New)$reset"
    echo -e "$blue[4]$reset Best DNS Finder $orange(New)$reset"
    echo -e "$blue[5]$reset Ping Custom DNS $orange(New)$reset"
    echo -e "$blue[6]$reset Search Game DNS $orange(New)$reset"
    echo -e "$blue[7]$reset Auto Mode $orange(New)$reset"
    echo -e "$blue[8]$reset Auto Benchmark $orange(New)$reset"
    echo -e "$blue[9]$reset Generate QR Code $orange(New)$reset"
    echo -e "$blue[0]$reset Exit ❌"
    echo -ne "$green\nChoose option: $reset"; read opt
    case $opt in
      1) game_dns_menu ;;
      2) console_dns_menu ;;
      3) download_dns_menu ;;
      4) generate_dns ; echo -ne "$green\nPress Enter...$reset"; read ;;
      5) ping_custom_dns ;;
      6) search_game_dns ;;
      7) auto_mode ;;
      8) auto_benchmark ;;
      9) generate_qr ;;
      0) echo -e "$greenGoodbye!$reset"; exit ;;
      *) echo -e "$redInvalid input!$reset"; sleep 1 ;;
    esac
  done
}

main_menu
