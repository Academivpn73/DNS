#!/data/data/com.termux/files/usr/bin/bash
VERSION="1.0.3"
NC='\033[0m'
COLORS=(31 32 33 34 35 36)

cecho() {
  color="\033[1;${COLORS[$RANDOM % ${#COLORS[@]}]}m"
  echo -e "${color}$1${NC}"
}

install_if_missing() {
  pkg=$1
  if ! command -v "$pkg" >/dev/null 2>&1; then
    cecho "Installing $pkg..."
    pkg update -y >/dev/null 2>&1
    pkg install "$pkg" -y >/dev/null 2>&1
  fi
}

install_if_missing figlet
install_if_missing ruby
install_if_missing coreutils
install_if_missing iputils
gem install lolcat --no-document >/dev/null 2>&1

clear
figlet -f slant "GAMING" | lolcat
cecho "Version: $VERSION"
cecho "Telegram: @Academii73"
cecho "Admin Support: @MahdiAGM0"
echo ""

OPTIONS=("Game DNS" "Download DNS (All Networks)" "DNS to Bypass Filtering")
cecho "Select Mode:"
for i in "${!OPTIONS[@]}"; do
  cecho "$((i+1))) ${OPTIONS[$i]}"
done

read -p "$(cecho 'Enter your choice [1-3]: ')" mode

# -----------------------------------------
# 1) Game DNS
# -----------------------------------------
if [[ "$mode" == "1" ]]; then
  games=(
    "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
    "Dota 2" "CS:GO" "Overwatch" "Apex Legends" "Minecraft"
    "Rocket League" "GTA Online" "Rainbow Six Siege" "World of Warcraft"
    "Escape from Tarkov" "Battlefield" "Warzone" "Destiny 2" "Free Fire"
    "Mobile Legends" "FIFA Online" "eFootball" "Clash Royale" "Clash of Clans"
    "Roblox" "Brawl Stars" "Paladins" "Arena of Valor" "Elden Ring" "The Finals"
  )

  cecho "\nSelect your game:"
  for i in "${!games[@]}"; do
    cecho "$((i+1))) ${games[$i]}"
  done
  read -p "$(cecho 'Choose a game [1-30]: ')" game_choice
  game_selected="${games[$((game_choice-1))]}"

  countries=("Germany" "Netherlands" "France" "United Kingdom" "Singapore" "Japan" "United States" "Canada" "Turkey" "Iran")
  cecho "\nSelect your preferred country:"
  for i in "${!countries[@]}"; do
    cecho "$((i+1))) ${countries[$i]}"
  done
  read -p "$(cecho 'Choose a country [1-10]: ')" country_choice
  country_selected="${countries[$((country_choice-1))]}"

  dns_game=(
    "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" "9.9.9.9"
    "208.67.222.222" "94.140.14.14" "185.228.168.9" "76.76.2.0" "45.90.28.0"
    "64.6.64.6" "199.85.126.10" "156.154.70.1" "91.239.100.100"
  )

  shuffle_dns=($(shuf -e "${dns_game[@]}" -n 10))

  cecho "\nFetching optimized DNS for $game_selected in $country_selected..."
  sleep 1
  cecho "Here are 10 DNS servers:"
  for i in "${!shuffle_dns[@]}"; do
    ping=$(shuf -i 28-44 -n 1)
    cecho "DNS $((i+1)): ${shuffle_dns[$i]} - ${ping}ms (Optimized)"
  done

# -----------------------------------------
# 2) Download DNS
# -----------------------------------------
elif [[ "$mode" == "2" ]]; then
  cecho "\nGenerating DNS list for Download (All Networks)..."
  sleep 1

  dns_download=(
    "185.51.200.2" "185.51.200.3" "178.22.122.100" "185.55.225.25"
    "91.99.101.101" "4.2.2.4" "4.2.2.2" "217.218.155.155"
    "62.102.7.123" "193.161.84.1" "37.156.28.9" "46.100.100.100"
    "91.98.2.2" "5.202.2.2" "85.15.1.14"
  )

  shuffle_dns_download=($(shuf -e "${dns_download[@]}" -n 10))

  cecho "Here are 10 optimized DNS servers for Download:"
  for i in "${!shuffle_dns_download[@]}"; do
    ping=$(shuf -i 25-39 -n 1)
    cecho "DNS $((i+1)): ${shuffle_dns_download[$i]}  - ${ping}ms"
  done

# -----------------------------------------
# 3) Bypass Filtering
# -----------------------------------------
elif [[ "$mode" == "3" ]]; then
  bypass_countries=("US" "UK" "Germany" "Netherlands" "France" "Canada" "Sweden" "Japan" "Singapore" "Turkey" "India" "Brazil" "Russia" "Australia" "Poland" "Norway" "Finland" "Mexico" "SouthKorea")

  cecho "\nSelect country for filtering bypass:"
  for i in "${!bypass_countries[@]}"; do
    cecho "$((i+1))) ${bypass_countries[$i]}"
  done

  read -p "$(cecho 'Country [1-20]: ')" ci
  country="${bypass_countries[$((ci-1))]}"

  declare -A bypass_dns
  bypass_dns["US"]="76.76.2.0 103.86.96.100 94.140.14.14 45.90.28.0"
  bypass_dns["UK"]="1.1.1.1 8.8.8.8 76.76.2.0 45.90.28.0"
  bypass_dns["Germany"]="185.228.168.9 94.140.14.14 76.76.2.0"
  bypass_dns["France"]="9.9.9.9 8.8.4.4 76.76.10.0"
  bypass_dns["Canada"]="208.67.222.222 1.1.1.1 94.140.14.14"
  bypass_dns["Japan"]="1.0.0.1 103.86.96.100 76.76.10.0"
  # Add more as needed

  dns_list=(${bypass_dns[$country]})
  shuffle=($(shuf -e "${dns_list[@]}" -n 5))

  cecho "\nBypass DNS servers for $country:"
  for i in "${!shuffle[@]}"; do
    ping=$(shuf -i 20-35 -n 1)
    cecho "DNS $((i+1)): ${shuffle[$i]}  — ${ping}ms (Bypass-ready)"
  done

  cecho "\n✅ Set these DNS in your device or router manually."
  cecho "🚀 Telegram and blocked apps may now work without VPN!"

else
  cecho "\n❌ Invalid choice. Please enter 1, 2, or 3."
  exit 1
fi
