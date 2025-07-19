#!/bin/bash

# رنگ‌ها
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
red=$(tput setaf 1)
bold=$(tput bold)
reset=$(tput sgr0)

# تایتل
show_title() {
  clear
  echo -e "${blue}+--------------------------------------------------+${reset}"
  echo -e "${yellow}|   ${bold}AcademiVPN DNS Tool v1.2.3${reset}                         |"
  echo -e "${yellow}|   ${bold}Admin:${reset} @MahdiAGM0  |  ${bold}Telegram:${reset} @Academi_vpn         |"
  echo -e "${blue}+--------------------------------------------------+${reset}"
}

# دریافت DNS از فایل آنلاین
get_random_dns_from_file() {
  dns_list=$(curl -s https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_list.txt)

  if [[ -z "$dns_list" ]]; then
    echo -e "${red}❌ Failed to load DNS list.${reset}"
    return
  fi

  total=$(echo "$dns_list" | wc -l)
  index=$(( RANDOM % total + 1 ))
  line=$(echo "$dns_list" | sed -n "${index}p")
  dns1=$(echo "$line" | cut -d',' -f1)
  dns2=$(echo "$line" | cut -d',' -f2)

  echo -e "\n${green}✅ Recommended DNS:"
  echo -e "Primary:   $dns1"
  echo -e "Secondary: $dns2${reset}"

  ping=$(ping -c 1 -W 1 "$dns1" | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')
  [[ -z "$ping" ]] && ping="Unavailable"
  echo -e "${blue}Ping: $ping ms${reset}"
}

# بخش Ping دستی
ping_dns_custom() {
  read -p "Enter DNS to ping: " dns
  result=$(ping -c 1 -W 1 "$dns" | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')
  if [[ -z "$result" ]]; then
    echo -e "${red}❌ Ping failed.${reset}"
  else
    echo -e "${green}✅ Ping: $result ms${reset}"
  fi
}

# لیست گیم (محدود شده برای نمایش)
search_game() {
  echo -e "\n${yellow}🔍 Enter game name to search:"
  read -p "🔎 " game

  games=("PUBG Mobile" "Call of Duty Mobile" "Arena Breakout (جدید)" "Free Fire" "Clash of Clans" "Mobile Legends" "Apex Legends Mobile" "Brawl Stars" "Farlight 84" "Warzone Mobile (جدید)")
  match=""

  for g in "${games[@]}"; do
    if [[ "${g,,}" == *"${game,,}"* ]]; then
      match="$g"
      break
    fi
  done

  if [[ -n "$match" ]]; then
    echo -e "\n${green}🎮 Game found: $match${reset}"
    echo -e "${blue}🌍 Choose Region:"
    echo -e "1) Iran"
    echo -e "2) UAE"
    echo -e "3) Turkey"
    echo -e "4) Global\n"
    read -p "Choose: " region
    echo -e "\n${green}🔗 DNS for $match in region $region:${reset}"
    get_random_dns_from_file
  else
    echo -e "${yellow}⚠️ Game not found.${reset}"
  fi
}

# منو اصلی
main_menu() {
  while true; do
    show_title
    echo -e "${bold}${blue}Select an option:${reset}"
    echo -e "1) 📥 DNS مخصوص دانلود"
    echo -e "2) 🎮 DNS گیمینگ"
    echo -e "3) 💎 DNS پرمیوم (جدید)"
    echo -e "4) 📶 Ping DNS (جدید)"
    echo -e "5) 🔍 Search Game (جدید)"
    echo -e "0) ❌ Exit\n"
    read -p "Enter choice: " choice

    case $choice in
      1) get_random_dns_from_file ;;
      2) get_random_dns_from_file ;;
      3) get_random_dns_from_file ;;
      4) ping_dns_custom ;;
      5) search_game ;;
      0) echo -e "${green}Bye!${reset}"; exit ;;
      *) echo -e "${red}Invalid choice.${reset}" ;;
    esac
    echo -e "\nPress Enter to return..."
    read
  done
}

# اجرای منو
main_menu
