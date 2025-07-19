#!/bin/bash

# --- URLs to fetch data ---
GAMES_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/games_list.txt"
COUNTRIES_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/countries.txt"
DNS_DATA_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_data.txt"

# --- Random color for title ---
colors=(31 32 33 34 35 36 91 92 93 94 95 96)
RANDOM_COLOR=${colors[$RANDOM % ${#colors[@]}]}

# --- Title with random color ---
title() {
  clear
  echo -e "\033[1;${RANDOM_COLOR}m"
  echo "╔═══════════════════════════════════════════╗"
  echo "║      🔰 DNS Management Script v1.2.3       ║"
  echo "║      💬 Telegram: @Academi_vpn             ║"
  echo "║      👤 Admin: @MahdiAGM0                  ║"
  echo "╚═══════════════════════════════════════════╝"
  echo -e "\033[0m"
}

# --- Typing animation ---
type_effect() {
  text="$1"
  for ((i=0; i<${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.01
  done
  echo ""
}

# --- Fetch and cache file temporarily ---
fetch_file() {
  curl -fsSL "$1"
}

# --- Ping function ---
ping_dns() {
  ping -c 1 -W 1 "$1" | grep "time=" | awk -F"time=" '{print $2}' | cut -d' ' -f1
}

# --- Show Games ---
list_games() {
  fetch_file "$GAMES_URL"
}

# --- Show Countries ---
list_countries() {
  fetch_file "$COUNTRIES_URL"
}

# --- Get DNS by game & country ---
get_dns_by_game_country() {
  game="$1"
  country="$2"
  line=$(fetch_file "$DNS_DATA_URL" | grep -i "^$game|$country|" | shuf -n 1)

  if [[ -n "$line" ]]; then
    IFS='|' read -r g c dns1 dns2 <<< "$line"
    ping1=$(ping_dns "$dns1")
    ping2=$(ping_dns "$dns2")
    avg_ping=$(echo "($ping1 + $ping2) / 2" | bc)

    echo ""
    echo "🎮 Game: $g - 🌍 $c"
    echo "DNS 1: $dns1"
    echo "DNS 2: $dns2"
    echo "Ping: ${avg_ping}ms"
  else
    echo "❌ DNS not found for this game/country"
  fi
}

# --- Premium DNS ---
premium_dns() {
  title
  echo "🏆 Premium DNS (random):"
  line=$(fetch_file "$DNS_DATA_URL" | shuf -n 1)
  IFS='|' read -r g c dns1 dns2 <<< "$line"
  ping1=$(ping_dns "$dns1")
  ping2=$(ping_dns "$dns2")
  avg_ping=$(echo "($ping1 + $ping2) / 2" | bc)

  echo "DNS 1: $dns1"
  echo "DNS 2: $dns2"
  echo "Ping: ${avg_ping}ms"
  read -p $'\nPress Enter to return...'
}

# --- Ping DNS manually ---
ping_manual() {
  title
  read -p "Enter DNS IP: " dns
  ping_result=$(ping_dns "$dns")
  if [ -n "$ping_result" ]; then
    echo "Ping: ${ping_result}ms"
  else
    echo "❌ Unable to ping DNS."
  fi
  read -p $'\nPress Enter to return...'
}

# --- Gaming DNS ---
dns_gaming() {
  title
  echo "🎮 Select a game:"
  games=($(fetch_file "$GAMES_URL"))
  select game in "${games[@]}"; do
    [ -n "$game" ] && break
  done

  title
  echo "🌍 Select country:"
  countries=($(fetch_file "$COUNTRIES_URL"))
  select country in "${countries[@]}"; do
    [ -n "$country" ] && break
  done

  get_dns_by_game_country "$game" "$country"
  read -p $'\nPress Enter to return...'
}

# --- Download DNS ---
dns_download() {
  title
  echo "🌍 Select country for Download DNS:"
  countries=($(fetch_file "$COUNTRIES_URL"))
  select country in "${countries[@]}"; do
    [ -n "$country" ] && break
  done

  get_dns_by_game_country "download" "$country"
  read -p $'\nPress Enter to return...'
}

# --- Search Game ---
search_game() {
  title
  read -p "🔍 Enter game name: " search_term
  matched=$(fetch_file "$GAMES_URL" | grep -i "$search_term")

  if [[ -z "$matched" ]]; then
    echo "❌ Game not found!"
  else
    echo "✅ Found: $matched"
    read -p "Enter country name: " country
    get_dns_by_game_country "$search_term" "$country"
  fi
  read -p $'\nPress Enter to return...'
}

# --- Main Menu ---
while true; do
  title
  echo "📋 Menu:"
  echo "1) 🎮 Gaming DNS"
  echo "2) ⬇️ Download DNS"
  echo "3) 🏆 Premium DNS (New)"
  echo "4) 📶 Ping a DNS (New)"
  echo "5) 🔍 Search Game (New)"
  echo "0) ❌ Exit"
  read -p "➤ Choose option: " opt

  case "$opt" in
    1) dns_gaming ;;
    2) dns_download ;;
    3) premium_dns ;;
    4) ping_manual ;;
    5) search_game ;;
    0) exit ;;
    *) echo "❌ Invalid option!" ;;
  esac
done
