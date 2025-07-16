#!/bin/bash

# Auto-install required packages
install_deps() {
  for pkg in figlet lolcat iputils-ping; do
    if ! command -v "$pkg" &> /dev/null; then
      echo -e "Installing $pkg..." | lolcat
      apt install "$pkg" -y &> /dev/null
    fi
  done
}

install_deps

clear
# Header
figlet "DNS Tool" | lolcat
echo -e "\e[93mTelegram:\e[0m @Academi_vpn"
echo -e "\e[93mAdmin:\e[0m @MahdiAGM0"
echo -e "\e[91mVersion:\e[0m 1.2.0"
echo ""

# Game List
games=(
  "Call of Duty" "PUBG" "Free Fire" "Fortnite" "Apex Legends" "Valorant"
  "League of Legends" "Dota 2" "Overwatch" "CS:GO" "Rainbow Six Siege"
  "Minecraft" "Warzone" "Genshin Impact" "Brawl Stars" "Mobile Legends"
  "Arena of Valor" "FIFA Online" "NBA 2K" "Rocket League" "Smite"
  "World of Warcraft" "Elden Ring" "Tarkov" "Lost Ark"
  "Battlefield" "Cyberpunk" "Paladins" "Clash Royale" "Roblox"
  "Honkai: Star Rail" "Black Desert" "Destiny 2" "The Finals"
  "Diablo IV" "Overcooked 2" "ARK" "Rust" "The Crew"
)

# Country List (Middle East)
countries=("Iran" "Turkey" "UAE" "Saudi Arabia" "Iraq" "Qatar" "Jordan" "Oman" "Kuwait" "Bahrain")

# DNS Mapping
declare -A dns_map

for game in "${games[@]}"; do
  for country in "${countries[@]}"; do
    key="${game}_${country}"
    dns_map["$key"]="1.1.1.1 8.8.8.8 4.2.2.4 9.9.9.9 185.51.200.2 178.22.122.100 185.55.226.26 10.202.10.10 178.22.122.2 1.0.0.1 94.140.14.14 94.140.14.15 208.67.222.222 149.112.112.112 208.67.220.220"
  done
done

# Select Game
echo -e "\e[96mSelect your game:\e[0m"
for i in "${!games[@]}"; do
  printf "\e[92m[%02d]\e[0m %s\n" "$((i+1))" "${games[$i]}"
  sleep 0.03
done
read -p $'\nEnter game number: ' game_index
game="${games[$((game_index-1))]}"

# Select Country
echo -e "\n\e[96mSelect your country:\e[0m"
for i in "${!countries[@]}"; do
  printf "\e[95m[%02d]\e[0m %s\n" "$((i+1))" "${countries[$i]}"
  sleep 0.03
done
read -p $'\nEnter country number: ' country_index
country="${countries[$((country_index-1))]}"

clear
figlet "DNS Finder" | lolcat
echo -e "\n\e[93mGame:\e[0m $game"
echo -e "\e[93mCountry:\e[0m $country"
echo -e "\e[92mFinding best DNS servers...\e[0m"

key="${game}_${country}"
dns_list=(${dns_map["$key"]})

if [[ ${#dns_list[@]} -eq 0 ]]; then
  echo -e "\e[91mNo DNS found for $game in $country.\e[0m"
  read -p "Press Enter to return..."
  exit
fi

# Show 15 DNS with ping
echo ""
for i in "${!dns_list[@]}"; do
  [[ $i -ge 15 ]] && break
  dns="${dns_list[$i]}"
  ping_result=$(ping -c 1 -W 1 "$dns" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
  ping_result=${ping_result:-"N/A"}
  printf "\e[93m[%02d]\e[0m DNS: %-16s \e[96mPing:\e[0m %s ms\n" "$((i+1))" "$dns" "$ping_result"
  sleep 0.1
done

# Exit
echo -e "\n\e[33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\e[0m"
