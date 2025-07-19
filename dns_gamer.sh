#!/bin/bash

red='\e[31m'; green='\e[32m'; yellow='\e[33m'; blue='\e[34m'; nc='\e[0m'

GAMES_LIST_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/games_list.txt"
DNS_GAMING_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_gaming.txt"
DNS_DOWNLOAD_URL="https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_download.txt"

show_title() {
  colors=("$red" "$green" "$yellow" "$blue")
  rand_color=${colors[$RANDOM % ${#colors[@]}]}
  echo -e "${rand_color}+-------------------------------+${nc}"
  echo -e "${rand_color}|     ACADEMI VPN SCRIPT       |${nc}"
  echo -e "${rand_color}|     Admin: @MahdiAGM0        |${nc}"
  echo -e "${rand_color}+-------------------------------+${nc}"
}

pick_two_random_dns() {
  local dns_list=("$@")
  count=${#dns_list[@]}
  [[ $count -lt 2 ]] && echo -e "${red}Not enough DNS found.${nc}" && return
  i=$((RANDOM % count))
  j=$((RANDOM % count))
  while [[ $i -eq $j ]]; do j=$((RANDOM % count)); done
  echo -e "${green}Primary DNS:${nc} ${dns_list[$i]}"
  echo -e "${yellow}Secondary DNS:${nc} ${dns_list[$j]}"
}

dns_gaming_section() {
  echo -e "${blue}📃 Game List:${nc}"
  curl -fsSL "$GAMES_LIST_URL" || { echo -e "${red}Can't load game list!${nc}"; return; }
  echo
  echo -ne "${yellow}🔢 Enter game number: ${nc}"
  read number

  game_name=$(curl -fsSL "$GAMES_LIST_URL" | sed -n "${number}p" | cut -d. -f2- | sed 's/^ //')
  if [[ -z "$game_name" ]]; then
    echo -e "${red}❌ Invalid number!${nc}"
    return
  fi

  echo -e "${blue}🌍 Available Countries for $game_name:${nc}"
  curl -fsSL "$DNS_GAMING_URL" | grep "$game_name" | cut -d'|' -f2 | sort | uniq

  echo -ne "${yellow}🌐 Enter country (or press Enter for all): ${nc}"
  read country

  dns_list=()
  while IFS= read -r line; do
    g=$(echo "$line" | cut -d'|' -f1)
    c=$(echo "$line" | cut -d'|' -f2)
    d=$(echo "$line" | cut -d'|' -f3)
    if [[ "$g" == "$game_name" && ( -z "$country" || "$c" == "$country" ) ]]; then
      dns_list+=("$d ($c)")
    fi
  done < <(curl -fsSL "$DNS_GAMING_URL")

  if [[ ${#dns_list[@]} -eq 0 ]]; then
    echo -e "${red}❌ No DNS found for $game_name in $country${nc}"
    return
  fi

  pick_two_random_dns "${dns_list[@]}"
}

dns_download_section() {
  dns_list=()
  while IFS= read -r line; do
    [[ -n "$line" ]] && dns_list+=("$line")
  done < <(curl -fsSL "$DNS_DOWNLOAD_URL")

  if [[ ${#dns_list[@]} -eq 0 ]]; then
    echo -e "${red}❌ No DNS found!${nc}"
    return
  fi

  pick_two_random_dns "${dns_list[@]}"
}

main_menu() {
  while true; do
    clear
    show_title
    echo -e "${blue}1) DNS for Gaming${nc}"
    echo -e "${blue}2) DNS for Download${nc}"
    echo -e "${red}0) Exit${nc}"
    echo -ne "${yellow}Select option: ${nc}"
    read choice
    case $choice in
      1) dns_gaming_section ;;
      2) dns_download_section ;;
      0) exit ;;
      *) echo -e "${red}❌ Invalid option${nc}" ;;
    esac
    echo; read -p "Press Enter to continue..."
  done
}

main_menu
