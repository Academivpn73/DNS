#!/bin/bash

# ------------ Colors & Functions ------------
colors=(31 32 33 34 36 91 92 93 94 96)
rand_color() {
  echo -e "\033[1;${colors[$RANDOM % ${#colors[@]}]}m$1\033[0m"
}

cecho() {
  rand_color "$1"
}

# ------------ Auto Install Packages ------------
required_pkgs=(curl ping awk grep)
for pkg in "${required_pkgs[@]}"; do
  if ! command -v $pkg &>/dev/null; then
    cecho "Installing $pkg..."
    apt update -y &>/dev/null
    apt install -y "$pkg" &>/dev/null
  fi
done

# ------------ Title ------------
echo
cecho "Mahdi Dns 🔥"
cecho "Version: 1.1.0"
cecho "Telegram: @Academi_vpn"
cecho "Admin: @MahdiAGM0"
echo

# ------------ Main Menu ------------
cecho "Choose Mode:"
cecho "1) Game DNS"
cecho "2) Download DNS"
cecho "3) Installer Options"
cecho "4) Exit"
read -p $'\nSelect an option [1-4]: ' mode

# ------------ Game DNS Section ------------
if [[ "$mode" == "1" ]]; then
  games_mobile=("PUBG" "Free Fire" "Mobile Legends" "Clash Royale" "Clash of Clans" "Brawl Stars" "Arena of Valor" "eFootball")
  games_pc=("Call of Duty" "Valorant" "League of Legends" "Dota 2" "CS:GO" "Overwatch" "Apex Legends" "Minecraft" "Tarkov" "Warzone" "Battlefield" "GTA Online")
  games_console=("FIFA" "Fortnite" "Rocket League" "R6 Siege" "Destiny 2" "Elden Ring" "The Finals")

  cecho "\nSelect a game:"
  index=1
  for g in "${games_mobile[@]}"; do cecho "$index) $g (Mobile)"; ((index++)); done
  for g in "${games_pc[@]}"; do cecho "$index) $g (PC)"; ((index++)); done
  for g in "${games_console[@]}"; do cecho "$index) $g (Console)"; ((index++)); done
  read -p $'\nChoose a game [1-27]: ' game_choice

  all_games=("${games_mobile[@]}" "${games_pc[@]}" "${games_console[@]}")
  selected_game="${all_games[$((game_choice-1))]}"

  countries=(Germany Netherlands France UK Singapore Japan USA Canada Turkey Iran Brazil Russia India Italy Spain Sweden Australia Mexico SouthKorea Norway Finland UAE Poland China Argentina)
  cecho "\nSelect your country:"
  for i in "${!countries[@]}"; do
    color=${colors[$((i % ${#colors[@]}))]}
    printf "\033[1;${color}m%2d) %s\033[0m\n" $((i+1)) "${countries[$i]}"
  done
  read -p $'\nChoose a country [1-30]: ' country_choice
  selected_country="${countries[$((country_choice-1))]}"

  cecho "\nFetching optimized DNS for $selected_game in $selected_country...\n"

  dns_game=()
  for i in {1..500}; do
    dns_game+=("1.$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255))")
  done
  selected_dns=($(shuf -e "${dns_game[@]}" -n 15))

  for i in "${!selected_dns[@]}"; do
    ping_result=$(ping -c 1 -W 1 "${selected_dns[$i]}" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    ping_result=${ping_result:-"Timeout"}
    cecho "DNS $((i+1)): ${selected_dns[$i]} - ${ping_result} ms"
  done

  read -p $'\nPress Enter to return to main menu...' temp
  exec "$0"

# ------------ Download DNS Section ------------
elif [[ "$mode" == "2" ]]; then
  cecho "\nGenerating Download-Optimized DNS list..."

  dns_download=()
  for i in {1..500}; do
    dns_download+=("8.$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255))")
  done
  selected_dns=($(shuf -e "${dns_download[@]}" -n 15))

  for i in "${!selected_dns[@]}"; do
    ping_result=$(ping -c 1 -W 1 "${selected_dns[$i]}" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    ping_result=${ping_result:-"Timeout"}
    cecho "DNS $((i+1)): ${selected_dns[$i]} - ${ping_result} ms"
  done

  read -p $'\nPress Enter to return to main menu...' temp
  exec "$0"

# ------------ Installer Options ------------
elif [[ "$mode" == "3" ]]; then
  cecho "\nInstaller Options:"
  cecho "1) Install CLI Shortcut (Academivpn_dns)"
  cecho "2) Remove CLI Shortcut"
  read -p $'\nChoose [1-2]: ' inst_opt

  if [[ "$inst_opt" == "1" ]]; then
    curl -fsSL https://raw.githubusercontent.com/Academivpn73/DNS/main/king_dns.sh -o /usr/local/bin/Academivpn_dns
    chmod +x /usr/local/bin/Academivpn_dns
    cecho "\nInstalled! You can now run it with: Academivpn_dns"
  elif [[ "$inst_opt" == "2" ]]; then
    rm -f /usr/local/bin/Academivpn_dns
    cecho "\nRemoved CLI Shortcut."
  else
    cecho "Invalid input."
  fi

  read -p $'\nPress Enter to return to main menu...' temp
  exec "$0"

# ------------ Exit ------------
elif [[ "$mode" == "4" ]]; then
  cecho "\nGoodbye. Be sure to check out our Telegram channel too!"
  cecho "@Academi_vpn"
  exit 0

# ------------ Invalid Option ------------
else
  cecho "Invalid option. Please choose between 1 and 4."
  read -p $'\nPress Enter to return...' temp
  exec "$0"
fi
