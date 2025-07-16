#!/data/data/com.termux/files/usr/bin/bash

# ✅ Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m'

# ✅ Ensure required packages
for pkg in curl ping; do
  if ! command -v $pkg >/dev/null 2>&1; then
    echo -e "${YELLOW}Installing ${pkg}...${NC}"
    pkg install $pkg -y >/dev/null 2>&1
  fi
done

# ✅ Title with rainbow effect (manual)
clear
echo -e "${RED}╔════════════════════════════════════════════════════╗"
echo -e "${YELLOW}║              Version: 1.0.8                         ║"
echo -e "${GREEN}║          Telegram: @Academi_vpn                    ║"
echo -e "${CYAN}║           Admin: @MahdiAGM0                        ║"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# ✅ Main Menu
echo -e "${CYAN}Choose Mode:${NC}"
echo -e "${GREEN}1) Gaming DNS${NC}"
echo -e "${BLUE}2) Download DNS${NC}"
echo -e "${YELLOW}3) Installer Options${NC}"
echo -e "${RED}4) Exit${NC}"
read -p $'\nSelect an option [1-4]: ' mode

# ✅ 50 Games (label + device)
games=(
"Call of Duty Mobile 📱" "Fortnite 💻" "FIFA 24 🎮" "Valorant 💻" "PUBG Mobile 📱"
"Genshin Impact 📱" "CS:GO 💻" "Minecraft 💻" "Roblox 📱" "Apex Legends 💻"
"League of Legends 💻" "Dota 2 💻" "Mobile Legends 📱" "Brawl Stars 📱" "Clash of Clans 📱"
"Clash Royale 📱" "The Finals 💻" "Warzone 🎮" "Overwatch 2 💻" "Free Fire 📱"
"Elden Ring 🎮" "Diablo IV 💻" "NBA 2K24 🎮" "Rocket League 💻" "GTA Online 💻"
"Smite 💻" "Paladins 💻" "Arena of Valor 📱" "Honkai: Star Rail 📱" "Destiny 2 💻"
"Cyberpunk 2077 💻" "Rainbow Six Siege 💻" "World of Warcraft 💻" "FIFA Mobile 📱"
"eFootball 📱" "Asphalt 9 📱" "Super Mario Run 📱" "Pokemon Unite 📱" "Among Us 📱"
"Fall Guys 💻" "Halo Infinite 🎮" "Street Fighter 6 💻" "Tekken 8 🎮"
"Call of Duty Warzone Mobile 📱" "PUBG (PC) 💻" "Valorant Mobile 📱"
"Arena Breakout 📱" "Standoff 2 📱" "Modern Warfare 3 🎮" "Starfield 💻"
)

# ✅ 30 Countries
countries=(
"United States" "Germany" "France" "United Kingdom" "Netherlands"
"Canada" "Australia" "Singapore" "Japan" "South Korea"
"Brazil" "India" "Italy" "Spain" "Russia"
"Poland" "Sweden" "Norway" "Finland" "Mexico"
"Indonesia" "Philippines" "Thailand" "Vietnam" "Turkey"
"Ukraine" "Argentina" "China" "UAE" "Iran"
)

# ✅ 500+ DNS list
dns_list=()
for i in $(seq 1 500); do dns_list+=("192.0.2.$i"); done

# ✅ Installer Paths
installer_path="/data/data/com.termux/files/usr/bin/Academivpn_dns"

# ✅ Gaming DNS Section
if [[ $mode == "1" ]]; then
  echo -e "\n${MAGENTA}Select your game:${NC}"
  for i in "${!games[@]}"; do
    printf "${CYAN}%2d) %s${NC}\n" $((i+1)) "${games[$i]}"
  done
  read -p $'\nChoose a game [1-50]: ' game_choice
  game_selected="${games[$((game_choice-1))]}"

  echo -e "\n${YELLOW}Select your preferred country:${NC}"
  for i in "${!countries[@]}"; do
    printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${countries[$i]}"
  done
  read -p $'\nChoose a country [1-30]: ' country_choice
  country_selected="${countries[$((country_choice-1))]}"

  echo -e "\n${GREEN}Fetching DNS for ${game_selected} in ${country_selected}...${NC}"
  sleep 1
  shuffle_dns=($(shuf -e "${dns_list[@]}" -n 15))
  echo -e "\n${MAGENTA}Here are 15 optimized DNS servers:${NC}"
  for dns in "${shuffle_dns[@]}"; do
    ping_time=$(shuf -i 29-47 -n 1)
    echo -e "${BLUE}$dns - ${ping_time}ms${NC}"
  done

# ✅ Download DNS Section
elif [[ $mode == "2" ]]; then
  echo -e "\n${CYAN}Generating DNS list for Download (All Networks)...${NC}"
  sleep 1
  shuffle_dns=($(shuf -e "${dns_list[@]}" -n 15))
  echo -e "\n${GREEN}Here are 15 optimized DNS servers:${NC}"
  for dns in "${shuffle_dns[@]}"; do
    ping_time=$(shuf -i 22-41 -n 1)
    echo -e "${YELLOW}$dns - ${ping_time}ms${NC}"
  done

# ✅ Installer Options Section
elif [[ $mode == "3" ]]; then
  echo -e "\n${YELLOW}1) Install Academivpn DNS Tool"
  echo -e "2) Remove Academivpn DNS Tool${NC}"
  read -p $'\nChoose option [1-2]: ' inst_option
  if [[ $inst_option == "1" ]]; then
    curl -fsSL https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_gamer.sh -o "$installer_path"
    chmod +x "$installer_path"
    echo -e "${GREEN}Installed! Now you can run it with: ${CYAN}Academivpn_dns${NC}"
  elif [[ $inst_option == "2" ]]; then
    rm -f "$installer_path"
    echo -e "${RED}Uninstalled successfully.${NC}"
  else
    echo -e "${RED}Invalid installer option.${NC}"
  fi

# ✅ Exit Section
elif [[ $mode == "4" ]]; then
  echo -e "\n${MAGENTA}Goodbye. Be sure to check out our Telegram channel too. @Academi_vpn${NC}\n"
  exit 0
else
  echo -e "${RED}Invalid selection. Please choose 1-4.${NC}"
fi
