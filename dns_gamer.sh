#!/bin/bash
clear

show_banner() {
  local text="Admin: Mahdi | Version: 1.2.4"
  local colors=(31 32 33 34 35 36)
  local color=${colors[$RANDOM % ${#colors[@]}]}
  echo -e "\e[1;${color}m+----------------------------------------------+"
  echo -e "| ${text} |"
  echo -e "+----------------------------------------------+\e[0m"
}

ping_dns() {
  ping -c1 -W1 "$1" 2>/dev/null | grep -oP '(?<=time=)[0-9.]+'
}

select_from_file() {
  echo "📋 $1"
  local line index=1
  while IFS= read -r line; do
    printf "%2d) %s\n" "$index" "$line"
    ((index++))
  done < "$2"
}

load_game_dns() {
  local game="$1" country="$2"
  local block=$(awk -v g="$game" -v c="$country" '
    BEGIN { RS=""; FS="\n" }
    tolower($0) ~ tolower("Game: " g) && tolower($0) ~ tolower("Country: " c) { print; exit }
  ' dns_gaming.txt)

  if [[ -z "$block" ]]; then
    echo "❌ Not found: $game | $country"
    return
  fi

  local prim=$(grep -i "Primary:" <<<"$block" | awk '{print $2}')
  local sec=$(grep -i "Secondary:" <<<"$block" | awk '{print $2}')
  local latency=$(ping_dns "$prim")
  echo "✅ Primary: $prim"
  echo "✅ Secondary: $sec"
  echo "📶 Ping: ${latency:-timeout} ms"
}

load_bypass_dns() {
  local country="$1"
  local block=$(awk -v c="$country" '
    BEGIN { RS=""; FS="\n" }
    tolower($0) ~ tolower("Country: " c) { print; exit }
  ' dns_bypass.txt)

  if [[ -z "$block" ]]; then
    echo "❌ No DNS found for: $country"
    return
  fi

  local prim=$(grep -i "Primary:" <<<"$block" | awk '{print $2}')
  local sec=$(grep -i "Secondary:" <<<"$block" | awk '{print $2}')
  local latency=$(ping_dns "$prim")
  echo "✅ Primary: $prim"
  echo "✅ Secondary: $sec"
  echo "📶 Ping: ${latency:-timeout} ms"
}

load_premium_dns() {
  local country="$1"
  local block=$(awk -v c="$country" '
    BEGIN { RS=""; FS="\n" }
    tolower($0) ~ tolower("Country: " c) { print; exit }
  ' dns_premium.txt)

  if [[ -z "$block" ]]; then
    echo "❌ No premium DNS found for: $country"
    return
  fi

  local prim=$(grep -i "Primary:" <<<"$block" | awk '{print $2}')
  local sec=$(grep -i "Secondary:" <<<"$block" | awk '{print $2}')
  local latency=$(ping_dns "$prim")
  echo "💎 Primary: $prim"
  echo "💎 Secondary: $sec"
  echo "📶 Ping: ${latency:-timeout} ms"
}

search_game_dns() {
  select_from_file "Select a game:" games.txt
  read -p "> " gi
  game=$(sed -n "${gi}p" games.txt)

  select_from_file "Select a country:" countries.txt
  read -p "> " ci
  country=$(sed -n "${ci}p" countries.txt)

  echo ""
  load_game_dns "$game" "$country"
}

while true; do
  clear; show_banner
  echo ""
  echo "1) Gaming DNS 🎮"
  echo "2) Download/Bypass DNS 📥"
  echo "3) Premium DNS 💎"
  echo "4) Search Game 🔍"
  echo "5) Ping a DNS 📶"
  echo "0) Exit ❌"
  echo ""
  read -p "> " choice
  echo ""

  case $choice in
    1) search_game_dns ;;
    2)
       select_from_file "Select country for bypass use:" countries.txt
       read -p "> " ci
       country=$(sed -n "${ci}p" countries.txt)
       load_bypass_dns "$country"
       ;;
    3)
       select_from_file "Select country for Premium DNS:" countries.txt
       read -p "> " ci
       country=$(sed -n "${ci}p" countries.txt)
       load_premium_dns "$country"
       ;;
    4) search_game_dns ;;
    5)
       read -p "Enter DNS or IP to ping: " ip
       latency=$(ping_dns "$ip")
       echo "📶 Ping: ${latency:-timeout} ms"
       ;;
    0) echo "Goodbye!"; break ;;
    *) echo "⚠️ Invalid option. Try again." ;;
  esac

  echo ""; read -p "Press Enter to return to menu..." _
done
