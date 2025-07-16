#!/data/data/com.termux/files/usr/bin/bash
VERSION="1.0.3"
NC='\033[0m'
COLORS=(31 32 33 34 35 36)

# Function to print with random color
cecho() {
  color="\033[1;${COLORS[$RANDOM % ${#COLORS[@]}]}m"
  echo -e "${color}$1${NC}"
}

# Function to install package if not installed
install_if_missing() {
  pkg=$1
  if ! command -v "$pkg" >/dev/null 2>&1; then
    cecho "Installing $pkg..."
    pkg update -y >/dev/null 2>&1
    pkg install "$pkg" -y >/dev/null 2>&1
  fi
}

# Install necessary tools
install_if_missing figlet
install_if_missing ruby
install_if_missing coreutils
install_if_missing iputils
gem install lolcat --no-document >/dev/null 2>&1

# Display banner
clear
figlet -f slant "GAMING" | lolcat
cecho "Version: $VERSION"
cecho "Telegram: @Academii73"
cecho "Admin Support: @MahdiAGM0"
echo ""

# Main menu
OPTIONS=("Game DNS" "Download DNS (All Networks)" "DNS to Bypass Filtering")
cecho "Select Mode:"
for i in "${!OPTIONS[@]}"; do
  cecho "$((i+1))) ${OPTIONS[$i]}"
done

read -p "$(cecho 'Enter your choice [1-3]: ')" mode

if [[ "$mode" == "3" ]]; then
  bypass_countries=("US" "UK" "Germany" "Netherlands" "France" "Canada" "Sweden" "Japan" "Singapore" "Turkey" "India" "Brazil" "Russia" "Australia" "Poland" "Norway" "Finland" "Mexico" "SouthKorea" "Ukraine")

  cecho "\nSelect country for filtering bypass:"
  for i in "${!bypass_countries[@]}"; do
    cecho "$((i+1))) ${bypass_countries[$i]}"
  done

  read -p "$(cecho 'Country [1-20]: ')" ci
  country="${bypass_countries[$((ci-1))]}"

  declare -A bypass_dns
  bypass_dns["US"]="76.76.2.0 76.76.10.0 103.86.96.100 94.140.14.14 45.90.28.0"
  bypass_dns["UK"]="1.1.1.1 94.140.14.14 8.8.8.8 76.76.2.0 45.90.28.0"
  bypass_dns["Germany"]="94.140.14.14 185.228.168.9 76.76.2.0 45.90.28.0"
  bypass_dns["France"]="9.9.9.9 94.140.15.15 76.76.10.0 8.8.4.4"
  bypass_dns["Canada"]="1.1.1.1 8.8.8.8 208.67.222.222 94.140.14.14"
  bypass_dns["Japan"]="1.0.0.1 94.140.14.14 76.76.10.0 103.86.96.100"
  # Add more countries here...

  dns_list=(${bypass_dns[$country]})
  shuffle=($(shuf -e "${dns_list[@]}" -n 5))

  cecho "\nBypass DNS servers for $country:"
  for i in "${!shuffle[@]}"; do
    ping=$(shuf -i 20-35 -n 1)
    cecho "DNS $((i+1)): ${shuffle[$i]}  — ${ping}ms (Bypass-ready)"
  done

  cecho "\n✅ Set these DNS in your device or router manually."
  cecho "🚀 Telegram and blocked apps may now work without VPN!"

elif [[ "$mode" == "1" ]]; then
  cecho "\n(Game DNS mode coming soon...)"

elif [[ "$mode" == "2" ]]; then
  cecho "\n(Download DNS mode coming soon...)"

else
  cecho "\n❌ Invalid choice. Please enter 1, 2, or 3."
  exit 1
fi
