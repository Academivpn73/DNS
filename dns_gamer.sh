#!/bin/bash

# Auto install required packages
REQUIRED_PKGS=(curl ping figlet lolcat)
for pkg in "${REQUIRED_PKGS[@]}"; do
  if ! command -v "$pkg" &>/dev/null; then
    pkgmgr=$(command -v apt || command -v pkg)
    $pkgmgr update -y &>/dev/null
    $pkgmgr install -y "$pkg" &>/dev/null
  fi
done

clear

# Title section
echo -e "\e[1;36m======================================================\e[0m" | lolcat
echo -e "\e[1;33m              Mahdi DNS 🔥                           \e[0m" | lolcat
echo -e "\e[1;36m======================================================\e[0m" | lolcat
echo -e "\e[1;32mVersion: \e[1;31m1.1.0     \e[1;36mTelegram: \e[1;34m@Academi_vpn     \e[1;36mAdmin: \e[1;35m@MahdiAGM0\e[0m"
echo -e "\e[1;36m======================================================\e[0m" | lolcat

# Create default DNS data if not exists
DNS_FILE="dns_data.txt"
if [ ! -f "$DNS_FILE" ]; then
cat <<EOF > "$DNS_FILE"
Iran|gaming|185.51.200.2,10.202.10.202,10.202.10.10,185.51.200.110,178.22.122.100
Iran|download|185.51.200.2,178.22.122.100,10.202.10.202,10.202.10.10
Turkey|gaming|193.140.100.100,8.8.8.8,1.1.1.1
Turkey|download|85.95.240.110,193.140.100.100,8.8.4.4
UAE|gaming|91.75.135.20,194.182.163.1,1.1.1.1
UAE|download|194.182.163.2,91.75.135.100,1.0.0.1
EOF
fi

# Country list
COUNTRIES=("Iran" "Turkey" "UAE" "Qatar" "SaudiArabia" "Jordan" "Iraq" "Syria" "Lebanon" "Kuwait" "Oman" "Bahrain" "Egypt" "Morocco" "Algeria" "Tunisia" "Pakistan" "India" "Azerbaijan" "Afghanistan")

# Games list
GAMES=(
  "PUBG Mobile (Mobile)" "Call of Duty Mobile (Mobile)" "Free Fire (Mobile)" "Clash Royale (Mobile)" "Brawl Stars (Mobile)"
  "League of Legends (PC)" "Dota 2 (PC)" "Valorant (PC)" "Overwatch 2 (PC)" "Apex Legends (PC)"
  "FIFA 23 (Console)" "eFootball (Console)" "Call of Duty MW (Console)" "Fortnite (Console)" "Rocket League (Console)"
)

# Print colorful menu
function show_menu() {
  echo -e "\n\e[1;36m[1] Gaming DNS\e[0m" | lolcat
  echo -e "\e[1;36m[2] Download DNS\e[0m" | lolcat
  echo -e "\e[1;31m[0] Exit\e[0m"
  echo ""
}

# Ping DNS
function ping_dns_list() {
  local dns_array=($@)
  local i=1
  for dns in "${dns_array[@]}"; do
    ping -c 1 -W 1 $dns &>/dev/null
    if [ $? -eq 0 ]; then
      ping_ms=$(ping -c 1 $dns | grep time= | awk -F'time=' '{print $2}' | cut -d' ' -f1)
      echo -e "\e[1;33mDNS $i:\e[0m $dns \e[32m[Ping: ${ping_ms}ms]\e[0m"
    else
      echo -e "\e[1;33mDNS $i:\e[0m $dns \e[31m[Offline]\e[0m"
    fi
    ((i++))
  done
}

# Extract DNS
function get_dns() {
  type=$1
  echo -e "\n\e[1;34mSelect your country:\e[0m"
  for i in "${!COUNTRIES[@]}"; do
    printf "\e[1;3$((i % 6 + 1))m[%d] %s\e[0m\n" "$((i+1))" "${COUNTRIES[$i]}"
  done
  read -p "Enter number: " cnum
  selected_country="${COUNTRIES[$((cnum-1))]}"

  # Filter from file
  line=$(grep "^$selected_country|$type|" "$DNS_FILE")
  IFS="|" read -r _ _ dns_raw <<< "$line"
  IFS="," read -ra dns_list <<< "$dns_raw"

  # Pick 15 random DNS
  mapfile -t shuffled < <(printf "%s\n" "${dns_list[@]}" | shuf | head -n 15)

  echo -e "\n\e[1;36m--- Showing 15 DNS for $selected_country [$type] ---\e[0m"
  ping_dns_list "${shuffled[@]}"
  echo ""
}

# Main script
while true; do
  show_menu
  read -p "Choose an option: " opt
  case $opt in
    1)
      echo -e "\n\e[1;34mSelect your game:\e[0m"
      for i in "${!GAMES[@]}"; do
        printf "\e[1;3$((i % 6 + 1))m[%d] %s\e[0m\n" "$((i+1))" "${GAMES[$i]}"
      done
      read -p "Enter number: " game_choice
      get_dns "gaming"
      read -p $'\nPress Enter to return to menu...'
      ;;
    2)
      get_dns "download"
      read -p $'\nPress Enter to return to menu...'
      ;;
    0)
      echo -e "\n\e[1;33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\e[0m"
      exit 0
      ;;
    *)
      echo -e "\e[1;31mInvalid option.\e[0m"
      ;;
  esac
done
