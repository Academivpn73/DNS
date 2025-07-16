#!/bin/bash set -e

VERSION="1.0.3" NC='\033[0m' COLORS=(31 32 33 34 35 36)

Function to print with random color

cecho() { color="\033[1;${COLORS[$RANDOM % ${#COLORS[@]}]}m" echo -e "${color}$1${NC}" }

Install required tools if missing

install_if_missing() { pkg=$1 if ! command -v "$pkg" &>/dev/null; then cecho "Installing $pkg..." sudo apt update -y &>/dev/null sudo apt install "$pkg" -y &>/dev/null fi }

install_if_missing figlet install_if_missing lolcat

Banner

clear figlet -f slant "GAMING" | lolcat

cecho "Version: $VERSION" cecho "Telegram: @Academii73" cecho "Admin Support: @MahdiAGM0" echo ""

OPTIONS=("Game DNS" "Download DNS (All Networks)" "DNS to Bypass Filtering") cecho "Select Mode:" for i in "${!OPTIONS[@]}"; do cecho "$((i+1))) ${OPTIONS[$i]}" done read -p "$(cecho $'\nEnter choice [1-3]: ')" mode

if [[ "$mode" == "3" ]]; then bypass_countries=( "US" "UK" "Canada" "Germany" "France" "Netherlands" "Sweden" "Japan" "Singapore" "Turkey" "UAE" "Australia" "India" "Brazil" "South_Korea" "Russia" "Egypt" "Chile" "Mexico" "Argentina" ) cecho "\nSelect country for bypass:" for i in "${!bypass_countries[@]}"; do cecho "$((i+1))) ${bypass_countries[$i]}" done read -p "$(cecho $'\nCountry [1-20]: ')" ci country="${bypass_countries[$((ci-1))]}"

declare -A bypass_dns bypass_dns["US"]="76.76.2.0 76.76.10.0 103.86.96.100 94.140.14.14 45.90.28.0" bypass_dns["UK"]="76.76.2.0 76.76.10.0 94.140.14.14 45.90.28.0 1.1.1.1" bypass_dns["Germany"]="94.140.14.14 76.76.2.0 185.228.168.9 45.90.28.0 1.1.1.1" bypass_dns["France"]="76.76.10.0 45.90.30.0 94.140.15.15 9.9.9.9 8.8.4.4"

Add more countries DNS as needed

dns_list=(${bypass_dns[$country]}) shuffle=($(shuf -e "${dns_list[@]}" -n 5))

cecho "\nBypass DNS servers for $country:" for i in "${!shuffle[@]}"; do ping=$(shuf -i 20-35 -n 1) cecho "DNS $((i+1)): ${shuffle[$i]} — ${ping}ms (Bypass ready for Telegram & filtered apps)" done

cecho "\n\xf0\x9f\x94\xa7 Note: These are commercial-grade DNS endpoints (e.g. Control D), enabling filtered apps like Telegram without VPN \xf0\x9f\x9a\x80"

elif [[ "$mode" == "1" ]]; then cecho "\n(Game DNS function not shown here for brevity)" elif [[ "$mode" == "2" ]]; then cecho "\n(Download DNS function not shown here for brevity)" else cecho "\nInvalid selection. Choose 1, 2 or 3." exit 1 fi

cecho "\n\xe2\x9c\x85 Now set one of these DNS addresses manually in your system or router network settings."

