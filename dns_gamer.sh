#!/bin/bash

# --- تنظیمات فایل آنلاین ---
GAMES_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/games_list.txt"
COUNTRIES_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/countries.txt"
DNS_DATA_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_data.txt"

# --- تابع برای رنگ دهی ---
color() {
  echo -e "\033[1;36m$1\033[0m"
}

# --- تایتل ---
show_title() {
  clear
  echo -e "\033[1;35m╔═══════════════════════════════════════════╗"
  echo -e "║      🔰 DNS Management Script v1.2.3       ║"
  echo -e "║      💬 Telegram: @Academi_vpn             ║"
  echo -e "║      👤 Admin: @MahdiAGM0                  ║"
  echo -e "╚═══════════════════════════════════════════╝\033[0m"
}

# --- دانلود فایل آنلاین ---
fetch_file() {
  curl -fsSL "$1"
}

# --- لیست گیم ---
list_games() {
  fetch_file "$GAMES_URL" | nl -w2 -s'. '
}

# --- لیست کشور ---
list_countries() {
  fetch_file "$COUNTRIES_URL" | nl -w2 -s'. '
}

# --- دریافت DNS ---
get_dns() {
  game="$1"
  country="$2"
  fetch_file "$DNS_DATA_URL" | grep -i "$game" | grep -i "$country" | shuf -n 2
}

# --- گزینه DNS گیمینگ ---
dns_gaming() {
  show_title
  echo "🎮 Game List:"
  games=$(fetch_file "$GAMES_URL")
  select game in $games; do
    [ -n "$game" ] || continue
    break
  done

  show_title
  echo "🌍 Select Country:"
  countries=$(fetch_file "$COUNTRIES_URL")
  select country in $countries; do
    [ -n "$country" ] || continue
    break
  done

  show_title
  echo "🔗 DNS for $game in $country:"
  get_dns "$game" "$country"
  read -p $'\nPress Enter to return...'
}

# --- گزینه DNS مخصوص دانلود ---
dns_download() {
  show_title
  echo "🌍 Select Country for Download DNS:"
  countries=$(fetch_file "$COUNTRIES_URL")
  select country in $countries; do
    [ -n "$country" ] || continue
    break
  done

  show_title
  echo "⬇️ Download DNS for $country:"
  get_dns "download" "$country"
  read -p $'\nPress Enter to return...'
}

# --- DNS پرمیوم ---
premium_dns() {
  show_title
  echo "🏆 Premium DNS (Random):"
  fetch_file "$DNS_DATA_URL" | shuf -n 2
  read -p $'\nPress Enter to return...'
}

# --- پینگ DNS ---
ping_dns() {
  show_title
  read -p "📥 Enter DNS to ping: " dns
  echo -e "\n⏱ Ping result:"
  ping -c 3 "$dns" | tail -2
  read -p $'\nPress Enter to return...'
}

# --- جستجوی گیم ---
search_game() {
  show_title
  read -p "🔍 Enter game name to search: " search_term
  results=$(fetch_file "$GAMES_URL" | grep -i "$search_term")

  if [ -z "$results" ]; then
    echo -e "\n⚠️ Game not found!"
  else
    echo -e "\n✅ Game found!"
    echo "$results"

    read -p $'\nSelect country (name): ' country
    show_title
    echo "📡 DNS for $search_term in $country:"
    get_dns "$search_term" "$country"
  fi
  read -p $'\nPress Enter to return...'
}

# --- منوی اصلی ---
while true; do
  show_title
  echo -e "\n📋 Select an option:"
  echo "1. 🎮 Gaming DNS"
  echo "2. ⬇️ Download DNS"
  echo "3. 🏆 Premium DNS (New)"
  echo "4. 📶 Ping a DNS (New)"
  echo "5. 🔍 Search Game (New)"
  echo "0. ❌ Exit"
  read -p "➤ " choice

  case "$choice" in
    1) dns_gaming ;;
    2) dns_download ;;
    3) premium_dns ;;
    4) ping_dns ;;
    5) search_game ;;
    0) echo "Bye!"; exit ;;
    *) echo "Invalid option!"; sleep 1 ;;
  esac
done
