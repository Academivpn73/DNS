#!/bin/bash

# Colors
COLORS=("\033[1;31m" "\033[1;32m" "\033[1;33m" "\033[1;34m" "\033[1;36m")
NC="\033[0m"
rand_color() {
  echo -ne "${COLORS[$RANDOM % ${#COLORS[@]}]}"
}

# Required packages
for pkg in curl ping grep awk; do
  if ! command -v $pkg >/dev/null 2>&1; then
    echo -e "$(rand_color)Installing $pkg...${NC}"
    pkg install $pkg -y >/dev/null 2>&1
  fi
done

# Header
clear
echo -e "\n$(rand_color)Mahdi DNS 🔥${NC}"
echo -e "$(rand_color)Version: \033[1;31m1.0.9${NC}"
echo -e "$(rand_color)Telegram: @Academi_vpn${NC}"
echo -e "$(rand_color)Admin: @MahdiAGM0${NC}\n"
sleep 1

# Game list
GAMES=(
  "PUBG Mobile (Mobile)" "Call of Duty (Mobile)" "Free Fire (Mobile)" "Clash of Clans (Mobile)"
  "Brawl Stars (Mobile)" "Valorant (PC)" "CS:GO (PC)" "Dota 2 (PC)" "Apex Legends (PC)"
  "Overwatch 2 (PC)" "Minecraft (PC)" "Fortnite (Console)" "eFootball (Console)"
  "FIFA 24 (Console)" "Warzone (Console)" "Rocket League (Console)"
)

# Country list
COUNTRIES=("USA" "Germany" "France" "UK" "Iran" "Japan" "Canada" "Brazil" "Netherlands" "Singapore" "India" "Russia" "Turkey" "Italy" "Sweden" "Norway" "UAE" "Argentina" "South Korea" "Australia")

# Gaming DNS (examples)
declare -A DNS_GAMING
declare -A DNS_DOWNLOAD

DNS_GAMING["USA"]="1.1.1.1 8.8.8.8 8.8.4.4 9.9.9.9 208.67.222.222 1.0.0.1 4.2.2.2 64.6.64.6 156.154.70.1 199.85.126.10 8.26.56.26 84.200.69.80 45.90.28.0 76.76.2.0 192.95.54.3"
DNS_GAMING["Iran"]="178.22.122.100 185.51.200.2 10.202.10.10 10.202.10.11 185.55.226.26 185.55.225.25 185.55.224.24 185.55.223.23 185.51.202.2 185.51.203.3 185.51.204.4 185.51.205.5 185.51.206.6 185.51.207.7 185.51.208.8"

DNS_DOWNLOAD["USA"]="1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 9.9.9.9 149.112.112.112 208.67.222.222 208.67.220.220 64.6.64.6 64.6.65.6 156.154.70.1 156.154.71.1 198.101.242.72 192.95.54.3 185.228.168.9"
DNS_DOWNLOAD["Iran"]="10.202.10.10 10.202.10.11 178.22.122.100 185.51.200.2 185.55.226.26 185.55.225.25 185.55.224.24 185.55.223.23 185.51.202.2 185.51.203.3 185.51.204.4 185.51.205.5 185.51.206.6 185.51.207.7 185.51.208.8"

# Main menu
main_menu() {
  echo -e "\n$(rand_color)Select an option:${NC}"
  echo "1. Gaming DNS 🎮"
  echo "2. Download DNS ⬇️"
  echo "3. Exit 🚪"
  read -p $'\nEnter your choice: ' opt
  case $opt in
    1) gaming_menu ;;
    2) download_menu ;;
    3) exit_message ;;
    *) echo -e "$(rand_color)Invalid option. Try again.${NC}"; main_menu ;;
  esac
}

# Gaming DNS
gaming_menu() {
  echo -e "\n$(rand_color)🎮 Select a Game:${NC}"
  for i in "${!GAMES[@]}"; do
    echo -e "$((i+1)). $(rand_color)${GAMES[$i]}${NC}"
  done
  read -p $'\nEnter game number: ' gnum

  echo -e "\n$(rand_color)🌍 Select a Country:${NC}"
  for i in "${!COUNTRIES[@]}"; do
    echo -e "$((i+1)). $(rand_color)${COUNTRIES[$i]}${NC}"
  done
  read -p $'\nEnter country number: ' cnum

  cname="${COUNTRIES[$((cnum - 1))]}"
  dns_list="${DNS_GAMING[$cname]}"
  if [ -z "$dns_list" ]; then
    echo -e "$(rand_color)No DNS found for this country.${NC}"
  else
    show_dns "$dns_list"
  fi
}

# Download DNS
download_menu() {
  echo -e "\n$(rand_color)🌍 Select a Country:${NC}"
  for i in "${!COUNTRIES[@]}"; do
    echo -e "$((i+1)). $(rand_color)${COUNTRIES[$i]}${NC}"
  done
  read -p $'\nEnter country number: ' cnum

  cname="${COUNTRIES[$((cnum - 1))]}"
  dns_list="${DNS_DOWNLOAD[$cname]}"
  if [ -z "$dns_list" ]; then
    echo -e "$(rand_color)No DNS found for this country.${NC}"
  else
    show_dns "$dns_list"
  fi
}

# Show DNS with live ping
show_dns() {
  echo -e "\n$(rand_color)🔧 Showing 15 DNS with ping:${NC}"
  IFS=' ' read -r -a list <<< "$1"
  for i in "${!list[@]}"; do
    [ $i -ge 15 ] && break
    dns="${list[$i]}"
    ping_time=$(ping -c1 -W1 $dns | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    echo -e "$(rand_color)DNS $((i+1)):${NC} $dns (Ping: ${ping_time:-timeout} ms)"
  done
  read -p $'\nPress Enter to return to main menu...' _
  clear
  main_menu
}

# Exit with yellow message
exit_message() {
  echo -e "\n\033[1;33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\033[0m\n"
  exit 0
}

main_menu
