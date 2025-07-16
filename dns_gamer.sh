#!/bin/bash

# ANSI Color Codes (No Purple, Red only for version)
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
RESET="\033[0m"

# Rainbow Text Function (random color)
rainbow() {
  local colors=("$RED" "$GREEN" "$YELLOW" "$BLUE" "$CYAN" "$WHITE")
  local i=0
  for word in "$@"; do
    echo -en "${colors[$((i % ${#colors[@]}))]}$word ${RESET}"
    ((i++))
  done
  echo
}

# Auto-install required tools
for pkg in curl ping; do
  if ! command -v $pkg &>/dev/null; then
    echo -e "${YELLOW}[!] Installing missing package: $pkg${RESET}"
    apt update -y &>/dev/null
    apt install -y $pkg &>/dev/null
  fi
done

clear

# HEADER
echo -e "\n"
rainbow "Mahdi" "Dns 🔥"
echo -e "${RED}Version: 1.1.0 ${RESET}  ${CYAN}Telegram: @Academi_vpn  Admin: @MahdiAGM0${RESET}"
echo -e "\n"

# MAIN MENU
main_menu() {
  echo -e "${GREEN}[1]${RESET} Gaming DNS"
  echo -e "${GREEN}[2]${RESET} Download DNS"
  echo -e "${GREEN}[0]${RESET} Exit"
  echo ""
  read -p "$(echo -e ${CYAN}Choose an option:${RESET} ) " option
  case $option in
    1) gaming_dns ;;
    2) download_dns ;;
    0) goodbye ;;
    *) echo -e "${RED}Invalid option.${RESET}"; sleep 1; main_menu ;;
  esac
}
# GAMES: Mobile > PC > Console
games=(
  "PUBG Mobile (Mobile)"
  "Call of Duty Mobile (Mobile)"
  "Free Fire (Mobile)"
  "Clash of Clans (Mobile)"
  "Brawl Stars (Mobile)"
  "Mobile Legends (Mobile)"
  "Asphalt 9 (Mobile)"
  "Fortnite (PC)"
  "Valorant (PC)"
  "League of Legends (PC)"
  "Counter Strike 2 (PC)"
  "Apex Legends (PC)"
  "Overwatch 2 (PC)"
  "Minecraft Java (PC)"
  "Dota 2 (PC)"
  "World of Warcraft (PC)"
  "GTA V Online (PC)"
  "Rocket League (PC)"
  "FIFA 24 (PC)"
  "Roblox (PC)"
  "Call of Duty Warzone (PC)"
  "Rainbow Six Siege (PC)"
  "Battlefield 2042 (PC)"
  "Hogwarts Legacy (PC)"
  "The Last of Us Part 1 (PC)"
  "Halo Infinite (Console)"
  "Spider-Man 2 (Console)"
  "God of War Ragnarok (Console)"
  "Gran Turismo 7 (Console)"
  "FIFA 24 (Console)"
  "Call of Duty MW3 (Console)"
  "Red Dead Redemption 2 (Console)"
  "Elden Ring (Console)"
  "NBA 2K24 (Console)"
  "Cyberpunk 2077 (Console)"
  "GTA V (Console)"
  "Fortnite (Console)"
  "Minecraft Bedrock (Console)"
  "Forza Horizon 5 (Console)"
  "Destiny 2 (Console)"
)

# COUNTRIES for gaming DNS (Middle East + Global)
countries=(
  "Iran"
  "Turkey"
  "United Arab Emirates"
  "Qatar"
  "Saudi Arabia"
  "Iraq"
  "Jordan"
  "Lebanon"
  "Kuwait"
  "Bahrain"
  "Oman"
  "Egypt"
  "India"
  "Pakistan"
  "Russia"
  "Germany"
  "France"
  "United Kingdom"
  "United States"
  "Netherlands"
)

# Display game selection
gaming_dns() {
  clear
  echo -e "${CYAN}Choose your game:${RESET}"
  for i in "${!games[@]}"; do
    rainbow "[$i]" "${games[$i]}"
  done
  echo ""
  read -p "$(echo -e ${YELLOW}Enter number:${RESET} ) " gnum
  selected_game="${games[$gnum]}"

  clear
  echo -e "${CYAN}Select your country:${RESET}"
  for i in "${!countries[@]}"; do
    rainbow "[$i]" "${countries[$i]}"
  done
  echo ""
  read -p "$(echo -e ${YELLOW}Enter number:${RESET} ) " cnum
  selected_country="${countries[$cnum]}"

  show_dns "$selected_game" "$selected_country"
}
# Function: Display Random Gaming DNS with Ping
show_gaming_dns() {
  clear
  selected_game=$1
  selected_country=$2

  echo -e "\nSelected Game: \e[96m$selected_game\e[0m"
  echo -e "Selected Country: \e[96m$selected_country\e[0m\n"

  # Simulated database of DNS per country for gaming (REAL DNS entries preferred in full script)
  declare -A dns_map
  dns_map["Iran"]="185.51.200.2 178.22.122.100 10.202.10.10 10.202.10.11"
  dns_map["Germany"]="94.140.14.14 1.1.1.1 8.8.8.8 176.103.130.130"
  dns_map["France"]="80.67.169.40 80.67.169.12 9.9.9.9 1.0.0.1"
  dns_map["USA"]="208.67.222.222 208.67.220.220 4.2.2.1 4.2.2.2"
  dns_map["Netherlands"]="194.109.6.66 84.200.69.80 84.200.70.40 37.235.1.174"

  dns_list=${dns_map[$selected_country]}

  if [[ -z "$dns_list" ]]; then
    echo -e "\e[91mNo DNS found for $selected_country.\e[0m"
    read -p "Press Enter to return..."
    return
  fi

  echo -e "\e[93mFetching 15 random optimized DNS servers...\e[0m"

  # Get 15 random DNS entries (or as many as exist)
  dns_array=($dns_list)
  count=1
  for dns in "${dns_array[@]}"
  do
    ping_result=$(ping -c 1 -W 1 $dns | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [ -z "$ping_result" ]; then
      ping_result="Timeout"
    else
      ping_result="${ping_result} ms"
    fi

    echo -e "\e[36mDNS $count:\e[0m \e[92m$dns\e[0m \t 🛰️  Ping: \e[95m$ping_result\e[0m"
    ((count++))
  done

  echo -e "\n\e[93mPress Enter to return to the main menu...\e[0m"
  read
}
# Function: Show Download DNS with Ping
show_download_dns() {
  clear
  echo -e "\e[92mChoose a country for optimized download DNS:\e[0m"
  echo ""
  
  countries=("Iran" "Germany" "France" "USA" "Netherlands" "UK" "Japan" "India" "Russia" "Brazil")
  
  for i in "${!countries[@]}"; do
    color_code=$((31 + (i % 6)))
    echo -e "\e[${color_code}m[$i] ${countries[$i]}\e[0m"
  done

  echo ""
  read -p "Enter country number: " country_index
  selected_country="${countries[$country_index]}"
  echo -e "\nSelected Country: \e[96m$selected_country\e[0m"

  declare -A download_dns
  download_dns["Iran"]="178.22.122.100 185.51.200.2 10.202.10.10 10.202.10.11"
  download_dns["Germany"]="1.1.1.1 8.8.8.8 9.9.9.9 94.140.14.14"
  download_dns["France"]="80.67.169.40 80.67.169.12 1.0.0.1 185.228.168.168"
  download_dns["USA"]="208.67.222.222 208.67.220.220 4.2.2.4 4.2.2.1"
  download_dns["Netherlands"]="84.200.69.80 84.200.70.40 194.109.6.66 91.239.100.100"
  download_dns["UK"]="9.9.9.10 8.26.56.26 4.2.2.2 195.46.39.39"
  download_dns["Japan"]="1.1.1.2 9.9.9.11 103.86.96.100 103.86.99.100"
  download_dns["India"]="8.8.4.4 1.0.0.1 149.112.112.112 9.9.9.9"
  download_dns["Russia"]="77.88.8.8 77.88.8.1 213.109.192.231 89.232.214.46"
  download_dns["Brazil"]="8.8.8.8 189.38.95.95 200.160.0.8 200.186.125.195"

  dns_list=${download_dns[$selected_country]}
  dns_array=($dns_list)
  echo -e "\n\e[93mShowing 15 random download-optimized DNS...\e[0m"

  for i in {1..15}; do
    rand_dns=${dns_array[$((RANDOM % ${#dns_array[@]}))]}
    ping_result=$(ping -c 1 -W 1 $rand_dns | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [[ -z "$ping_result" ]]; then
      ping_result="Timeout"
    else
      ping_result="${ping_result} ms"
    fi
    echo -e "\e[36mDNS $i:\e[0m \e[92m$rand_dns\e[0m \t 📥 Ping: \e[96m$ping_result\e[0m"
  done

  echo -e "\n\e[93mPress Enter to return to the main menu...\e[0m"
  read
}
# Auto install needed packages if not installed
auto_install_dependencies() {
  for pkg in lolcat figlet; do
    if ! command -v "$pkg" &>/dev/null; then
      echo -e "\e[93mInstalling $pkg...\e[0m"
      apt update -y &>/dev/null
      apt install "$pkg" -y &>/dev/null
    fi
  done
}
auto_install_dependencies

# Fancy title with version and admin info
clear
echo -e "\e[96mMahdi DNS 🔥\e[0m"
echo -e "\e[91mVersion: 1.1.0\e[0m     \e[92mTelegram: @Academi_vpn\e[0m     \e[94mAdmin: @MahdiAGM0\e[0m"
echo

# Main Menu Loop
while true; do
  echo -e "\n\e[96m========== MAIN MENU ==========\e[0m"
  echo -e "\e[92m[1]\e[0m 🎮 Gaming DNS"
  echo -e "\e[94m[2]\e[0m 📥 Download DNS"
  echo -e "\e[93m[0]\e[0m 🚪 Exit"
  echo -e "\e[96m===============================\e[0m"
  read -p "Select an option: " opt

  case $opt in
    1)
      show_gaming_dns
      ;;
    2)
      show_download_dns
      ;;
    0)
      clear
      echo -e "\e[33mGoodbye. Follow our channel on Telegram to see more updates and scripts. @Academi_vpn\e[0m"
      exit 0
      ;;
    *)
      echo -e "\e[91mInvalid option. Try again.\e[0m"
      ;;
  esac
done
