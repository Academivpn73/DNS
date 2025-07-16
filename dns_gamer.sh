#!/bin/bash
# DNS Manager v1.3.1

colors=(31 32 33 34 35 36 91 92)
random_color=${colors[$RANDOM % ${#colors[@]}]}
NC='\033[0m'

type_anim() {
  for ((i=0; i<${#1}; i++)); do echo -ne "${1:$i:1}"; sleep 0.001; done
  echo
}

scroll_list() {
  for item in "$@"; do echo -e "$item"; sleep 0.03; done
}

get_ping() {
  res=$(ping -c1 -W1 "$1" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
  echo "${res:-N/A}ms"
}

games=(
"Call of Duty" "PUBG" "Fortnite" "Valorant" "Dota 2" "CS:GO" "League of Legends" "Overwatch"
"Free Fire" "Apex Legends" "Minecraft" "Rocket League" "Rainbow Six Siege" "Genshin Impact"
"FIFA" "eFootball" "Warzone" "Battlefield" "Rust" "ARK" "Roblox" "Brawl Stars" "Mobile Legends"
"Clash Royale" "Clash of Clans" "Honkai Impact" "World of Warcraft" "GTA V Online" "Destiny 2"
"The Finals"
)

regions=("Iran" "Turkey" "UAE" "Saudi Arabia" "Iraq" "Germany" "USA" "UK" "Netherlands" "France" "India" "Russia" "Brazil" "Canada" "Italy" "Spain" "Qatar" "Kuwait" "Pakistan" "China")

declare -A dns_sources
dns_sources["Radar"]="10.202.10.10 10.202.10.11"
dns_sources["Cloudflare"]="1.1.1.1 1.0.0.1"
dns_sources["Google"]="8.8.8.8 8.8.4.4"
dns_sources["Quad9"]="9.9.9.9 149.112.112.112"
dns_sources["OpenDNS"]="208.67.222.222 208.67.220.220"
dns_sources["CleanBrowsing"]="185.228.168.9 185.228.169.9"

show_title() {
  clear
  echo -e "\e[1;${random_color}m╔════════════════════════════════════════════╗"
  echo -e "║         DNS MANAGEMENT TOOL v1.3.1         ║"
  echo -e "╠════════════════════════════════════════════╣"
  echo -e "║ Telegram : @Academi_vpn                    ║"
  echo -e "║ Admin    : @MahdiAGM0                      ║"
  echo -e "╚════════════════════════════════════════════╝${NC}\n"
}

main_menu() {
  show_title
  type_anim $'\e[1;36m[1]\e[0m Gaming DNS 🎮'
  type_anim $'\e[1;36m[2]\e[0m Download DNS ⬇️'
  type_anim $'\e[1;36m[0]\e[0m Exit ❌'
  echo
  read -p "Select an option: " opt
  case $opt in
    1) gaming_menu ;;
    2) download_menu ;;
    0) echo -e "\n\e[1;32mGoodbye 🙏🏻${NC}" && exit ;;
    *) main_menu ;;
  esac
}

gaming_menu() {
  show_title
  echo -e "\e[1;34mSelect a game:\e[0m"
  for i in "${!games[@]}"; do
    printf "\e[1;32m[%2d]\e[0m %s\n" $((i+1)) "${games[$i]}"
    sleep 0.02
  done
  echo -e "\e[1;32m[0]\e[0m Return"
  read -p $'\nGame #: ' gi
  [[ "$gi" == "0" ]] && main_menu
  [[ "$gi" -gt 0 && "$gi" -le ${#games[@]} ]] || gaming_menu
  game="${games[$((gi-1))]}"

  show_title
  echo -e "\e[1;34mSelect region:\e[0m"
  for i in "${!regions[@]}"; do
    printf "\e[1;36m[%2d]\e[0m %s\n" $((i+1)) "${regions[$i]}"
    sleep 0.01
  done
  echo -e "\e[1;32m[0]\e[0m Return"
  read -p $'\nRegion #: ' ri
  [[ "$ri" == "0" ]] && main_menu
  [[ "$ri" -gt 0 && "$ri" -le ${#regions[@]} ]] || gaming_menu
  region="${regions[$((ri-1))]}"

  show_title
  echo -e "\e[1;33mDNS for:\e[0m $game - $region"
  all_dns=()
  for src in "${!dns_sources[@]}"; do
    all_dns+=(${dns_sources[$src]})
  done
  mapfile -t picks < <(printf "%s\n" "${all_dns[@]}" | shuf | head -n15)
  for i in "${!picks[@]}"; do
    ping=$(get_ping "${picks[$i]}")
    printf "\e[1;32m[%2d]\e[0m %s  \e[1;36mPing:\e[0m %s\n" $((i+1)) "${picks[$i]}" "$ping"
    sleep 0.03
  done
  read -p $'\nPress Enter to return...' _
  main_menu
}

download_menu() {
  show_title
  echo -e "\e[1;34mSelect download region:\e[0m"
  for i in "${!regions[@]}"; do
    printf "\e[1;36m[%2d]\e[0m %s\n" $((i+1)) "${regions[$i]}"
    sleep 0.01
  done
  echo -e "\e[1;32m[0]\e[0m Return"
  read -p $'\nRegion #: ' ri
  [[ "$ri" == "0" ]] && main_menu
  [[ "$ri" -gt 0 && "$ri" -le ${#regions[@]} ]] || download_menu
  region="${regions[$((ri-1))]}"

  show_title
  echo -e "\e[1;33mDownload DNS for:\e[0m $region"
  all_dns=()
  for src in "${!dns_sources[@]}"; do
    all_dns+=(${dns_sources[$src]})
  done
  mapfile -t picks < <(printf "%s\n" "${all_dns[@]}" | shuf | head -n15)
  for i in "${!picks[@]}"; do
    ping=$(get_ping "${picks[$i]}")
    printf "\e[1;32m[%2d]\e[0m %s  \e[1;36mPing:\e[0m %s\n" $((i+1)) "${picks[$i]}" "$ping"
    sleep 0.03
  done
  read -p $'\nPress Enter to return...' _
  main_menu
}

# Start script
main_menu
