#!/bin/bash

# Auto install required tools
for pkg in curl ping figlet; do
  if ! command -v $pkg &>/dev/null; then
    if command -v apt &>/dev/null; then
      apt update -y &>/dev/null && apt install -y $pkg &>/dev/null
    elif command -v pkg &>/dev/null; then
      pkg update -y &>/dev/null && pkg install -y $pkg &>/dev/null
    fi
  fi
done

clear

# Title
echo -e "\e[1;36m========================================================\e[0m"
echo -e "\e[1;33m                      Mahdi DNS 🔥                     \e[0m"
echo -e "\e[1;36m========================================================\e[0m"
echo -e "\e[1;31mVersion: 1.1.0  \e[0m \e[1;36mTelegram: \e[1;34m@Academi_vpn  \e[1;36mAdmin: \e[1;35m@MahdiAGM0\e[0m"
echo -e "\e[1;36m========================================================\e[0m"

# DNS database
DNS_FILE="dns_data.txt"
if [ ! -f "$DNS_FILE" ]; then
cat <<EOF > "$DNS_FILE"
Iran|gaming|185.51.200.2,10.202.10.202,10.202.10.10,185.51.200.110,178.22.122.100,10.202.10.20
Iran|download|178.22.122.100,185.51.200.2,10.202.10.10,10.202.10.202
Turkey|gaming|193.140.100.100,8.8.8.8,1.1.1.1,185.19.28.10
Turkey|download|85.95.240.110,193.140.100.100,1.0.0.1
UAE|gaming|91.75.135.20,194.182.163.1,1.1.1.1
UAE|download|194.182.163.2,91.75.135.100,8.8.4.4
Qatar|gaming|185.42.80.10,91.74.75.75,1.0.0.1
Qatar|download|185.42.80.20,91.74.74.74
EOF
fi

# Countries (Middle East focus)
COUNTRIES=("Iran" "Turkey" "UAE" "Qatar" "SaudiArabia" "Iraq" "Syria" "Jordan" "Kuwait" "Oman")

# Global games
GAMES=(
"PUBG Mobile (Mobile)" "Free Fire (Mobile)" "COD Mobile (Mobile)" "Clash Royale (Mobile)" "Brawl Stars (Mobile)"
"League of Legends (PC)" "Dota 2 (PC)" "Valorant (PC)" "Overwatch (PC)" "Apex Legends (PC)"
"FIFA (Console)" "eFootball (Console)" "Fortnite (Console)" "Call of Duty MW (Console)" "Rocket League (Console)"
)

# Function to ping and show DNS
ping_dns_list() {
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

# DNS selector
get_dns() {
  type=$1
  echo -e "\n\e[1;36mChoose a country:\e[0m"
  for i in "${!COUNTRIES[@]}"; do
    color=$((31 + (i % 6)))
    printf "\e[1;${color}m[%d] %s\e[0m\n" "$((i+1))" "${COUNTRIES[$i]}"
  done
  read -p "Enter number: " cnum
  selected_country="${COUNTRIES[$((cnum-1))]}"

  line=$(grep "^$selected_country|$type|" "$DNS_FILE")
  if [[ -z "$line" ]]; then
    echo -e "\e[1;31mNo DNS found for $selected_country\e[0m"
    return
  fi

  IFS="|" read -r _ _ dns_raw <<< "$line"
  IFS="," read -ra dns_list <<< "$dns_raw"
  mapfile -t shuffled < <(printf "%s\n" "${dns_list[@]}" | shuf | head -n 15)

  echo -e "\n\e[1;36m--- $type DNS for $selected_country ---\e[0m"
  ping_dns_list "${shuffled[@]}"
  echo ""
}

# Show main menu
show_menu() {
  echo -e "\n\e[1;36m[1] Gaming DNS\e[0m"
  echo -e "\e[1;36m[2] Download DNS\e[0m"
  echo -e "\e[1;31m[0] Exit\e[0m"
}

# Main loop
while true; do
  show_menu
  read -p "Select option: " opt
  case $opt in
    1)
      echo -e "\n\e[1;34mChoose your game:\e[0m"
      for i in "${!GAMES[@]}"; do
        color=$((32 + (i % 6)))
        printf "\e[1;${color}m[%d] %s\e[0m\n" "$((i+1))" "${GAMES[$i]}"
      done
      read -p "Enter number: " _
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
