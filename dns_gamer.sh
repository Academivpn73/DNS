#!/bin/bash

# Auto install required packages
if ! command -v figlet &> /dev/null || ! command -v lolcat &> /dev/null; then
  echo "Installing dependencies..."
  sudo apt update &>/dev/null
  sudo apt install figlet lolcat -y &>/dev/null
fi

clear

# Title
figlet "Academi VPN" | lolcat
echo -e "\e[93mTelegram: \e[0m@Academi_vpn" | lolcat
echo -e "\e[93mAdmin:    \e[0m@MahdiAGM0" | lolcat
echo -e "\e[91mVersion:  1.0.9\e[0m" | lolcat
echo

# List of games
games=("Call of Duty" "PUBG Mobile" "Free Fire" "Fortnite" "Apex Legends" "Valorant" "Overwatch" "League of Legends" "Dota 2" "CS:GO" "FIFA 24" "Minecraft" "Genshin Impact" "Warzone" "Rainbow Six Siege" "Mobile Legends" "Rocket League" "Clash Royale" "Clash of Clans" "Roblox" "eFootball" "Among Us" "Arena of Valor" "Brawl Stars" "Battlefield" "Cyberpunk 2077" "World of Tanks" "Destiny 2" "Halo Infinite" "The Division 2" "Escape From Tarkov" "ARK: Survival Evolved" "Paladins" "Smite" "Diablo IV" "Naraka: Bladepoint" "Team Fortress 2" "Rust" "World of Warcraft" "Honkai Star Rail")

# Country-specific DNS map (Gaming)
declare -A dns_map

dns_map["Iran"]="178.22.122.100 185.51.200.2 10.202.10.10 185.55.226.26 217.218.155.155 79.175.147.10 194.36.174.161"
dns_map["Turkey"]="193.140.100.100 212.156.4.20 212.156.4.21 1.1.1.1 8.8.8.8"
dns_map["Saudi Arabia"]="212.26.18.41 46.185.172.150 8.8.8.8 9.9.9.9"
dns_map["UAE"]="194.170.1.6 62.231.243.2 185.228.169.12 8.8.8.8"
dns_map["Iraq"]="185.80.220.11 185.80.220.12 8.8.8.8 1.1.1.1"
dns_map["Qatar"]="212.77.192.6 185.228.168.10 9.9.9.9"
dns_map["Jordan"]="87.236.233.40 8.8.8.8 185.228.169.9"
dns_map["Oman"]="62.231.252.1 94.130.180.225 9.9.9.9"
dns_map["Lebanon"]="195.112.192.8 77.88.8.8 9.9.9.9"
dns_map["Bahrain"]="193.188.137.255 185.228.169.168 8.8.8.8"

# Global DNS for download
dns_download_global=(
  "8.8.8.8" "1.1.1.1" "9.9.9.9" "208.67.222.222" "185.228.168.9"
  "94.140.14.14" "185.95.218.42" "185.51.200.2" "76.76.2.0" "185.230.125.1"
  "91.239.100.100" "64.6.64.6" "45.90.28.0" "89.233.43.71" "77.88.8.8"
  "195.46.39.39" "199.85.126.10" "176.103.130.130" "94.130.180.225"
)

# Menu
while true; do
  echo -e "\n\033[1;36m1)\033[0m 🎮 Gaming DNS"
  echo -e "\033[1;34m2)\033[0m 📥 Download DNS"
  echo -e "\033[1;31m0)\033[0m ❌ Exit"
  read -p "Select an option: " opt

  if [[ $opt == 1 ]]; then
    echo -e "\n\033[1;35m🎮 Select a Game:\033[0m"
    select game in "${games[@]}"; do
      [[ -n $game ]] && break
    done

    echo -e "\n\033[1;32m🌍 Select Country:\033[0m"
    select country in "${!dns_map[@]}"; do
      [[ -n $country ]] && break
    done

    echo -e "\n\033[1;36mDNS Servers for $game ($country):\033[0m"
    IFS=' ' read -ra dns_list <<< "${dns_map[$country]}"
    count=0
    for dns in "${dns_list[@]}"; do
      ((count++))
      ping_ms=$(ping -c 1 -W 1 $dns | grep time= | awk -F'time=' '{print $2}' | cut -d' ' -f1)
      echo -e "\033[1;33mDNS $count:\033[0m $dns  \033[1;90m(Ping: ${ping_ms:-N/A} ms)\033[0m"
    done
    read -p "Press Enter to return to menu..."

  elif [[ $opt == 2 ]]; then
    echo -e "\n\033[1;32m🌍 Select Country for Download DNS:\033[0m"
    select country in "${!dns_map[@]}"; do
      [[ -n $country ]] && break
    done

    echo -e "\n\033[1;34mDownload-Optimized DNS for $country:\033[0m"
    for i in {1..15}; do
      dns="${dns_download_global[$RANDOM % ${#dns_download_global[@]}]}"
      ping_ms=$(ping -c 1 -W 1 $dns | grep time= | awk -F'time=' '{print $2}' | cut -d' ' -f1)
      echo -e "\033[1;36mDNS $i:\033[0m $dns \033[1;90m(Ping: ${ping_ms:-N/A} ms)\033[0m"
    done
    read -p "Press Enter to return to menu..."

  elif [[ $opt == 0 ]]; then
    echo -e "\n\033[1;33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\033[0m"
    exit 0
  else
    echo -e "\033[1;31mInvalid option!\033[0m"
  fi
done
