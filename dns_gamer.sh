#!/bin/bash

# رنگ‌ها
red='\e[31m'
green='\e[32m'
yellow='\e[33m'
blue='\e[34m'
nc='\e[0m'

# مسیرهای آنلاین
GAMES_LIST_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/games_list.txt"
DNS_GAMING_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_gaming.txt"
DNS_DOWNLOAD_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_download.txt"

# تابع نمایش عنوان با رنگ متغیر
show_title() {
  colors=("$red" "$green" "$yellow" "$blue")
  rand_color=${colors[$RANDOM % ${#colors[@]}]}
  echo -e "${rand_color}+-------------------------------+${nc}"
  echo -e "${rand_color}|     ACADEMI VPN SCRIPT       |${nc}"
  echo -e "${rand_color}|     Admin: @MahdiAGM0        |${nc}"
  echo -e "${rand_color}|     Version: 1.2.3           |${nc}"
  echo -e "${rand_color}+-------------------------------+${nc}"
  echo
}

# تابع انتخاب DNS رندوم
pick_random_dns() {
  dns_list=("$@")
  count=${#dns_list[@]}
  if (( count < 2 )); then
    echo -e "${red}❌ Not enough DNS entries!${nc}"
    return
  fi
  idx1=$((RANDOM % count))
  idx2=$((RANDOM % count))
  while [[ $idx2 -eq $idx1 ]]; do
    idx2=$((RANDOM % count))
  done
  echo -e "${green}🟢 Primary DNS:${nc} ${dns_list[$idx1]}"
  echo -e "${green}🟡 Secondary DNS:${nc} ${dns_list[$idx2]}"
}

# بخش بازی
dns_gaming_section() {
  echo -e "${blue}📱 Game List:${nc}"
  curl -fsSL "$GAMES_LIST_URL" || {
    echo -e "${red}❌ Failed to load games list!${nc}"
    return
  }

  echo
  echo -ne "${yellow}🎮 Enter game name: ${nc}"
  read game

  dns_list=()
  while IFS= read -r line; do
    [[ -n "$line" ]] && dns_list+=("$line")
  done < <(curl -fsSL "$DNS_GAMING_URL")

  if [[ ${#dns_list[@]} -eq 0 ]]; then
    echo -e "${red}❌ No DNS found!${nc}"
    return
  fi

  echo
  pick_random_dns "${dns_list[@]}"
}

# بخش دانلود
dns_download_section() {
  dns_list=()
  while IFS= read -r line; do
    [[ -n "$line" ]] && dns_list+=("$line")
  done < <(curl -fsSL "$DNS_DOWNLOAD_URL")

  if [[ ${#dns_list[@]} -eq 0 ]]; then
    echo -e "${red}❌ No DNS found!${nc}"
    return
  fi

  echo
  pick_random_dns "${dns_list[@]}"
}

# منو اصلی
main_menu() {
  while true; do
    clear
    show_title
    echo -e "${blue}1) DNS for Gaming${nc}"
    echo -e "${blue}2) DNS for Download${nc}"
    echo -e "${red}0) Exit${nc}"
    echo
    echo -ne "${yellow}Select an option: ${nc}"
    read choice

    case $choice in
      1) dns_gaming_section ;;
      2) dns_download_section ;;
      0) echo -e "${red}Bye!${nc}"; exit ;;
      *) echo -e "${red}Invalid!${nc}"; sleep 1 ;;
    esac
    echo
    read -p "Press Enter to continue..."
  done
}

# اجرای منو
main_menu
