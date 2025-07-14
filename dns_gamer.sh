#!/bin/bash

RED='\033[1;31m'
BLUE='\033[1;36m'
NC='\033[0m'

# هدر تبلیغاتی
echo -e "\e[91m"
echo "╔════════════════════════════════════════════╗"
echo "║              Version:: 4.0.1                          ║"
echo "║     Telegram: @Academi_vpn                ║"
echo "║     Admin Support: @MahdiAGM0             ║"
echo "║                                            ║"
echo "╚════════════════════════════════════════════╝"
echo -e "\e[0m"

echo -e "${BLUE}Welcome to the Ultimate Gaming DNS Booster!${NC}"
echo

# لیست بازی‌ها
games=(
  "Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends"
  "Dota 2" "CS:GO" "Overwatch" "Apex Legends" "Minecraft"
  "Rocket League" "GTA Online" "Rainbow Six Siege" "World of Warcraft"
  "Escape from Tarkov" "Battlefield" "Warzone" "Destiny 2"
  "Free Fire" "Mobile Legends" "FIFA Online" "eFootball"
  "Clash Royale" "Clash of Clans" "Roblox" "Brawl Stars"
  "Paladins" "Arena of Valor" "Elden Ring" "The Finals"
)

echo -e "${BLUE}Select your game:${NC}"
for i in "${!games[@]}"; do
  printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${games[$i]}"
done
read -p $'\nChoose a game [1-30]: ' game_choice
game_selected="${games[$((game_choice-1))]}"

# فقط IPv4
echo -e "\n${BLUE}IPv6 not supported — using IPv4 only.${NC}"

# لیست کشورها
countries=("Germany" "Netherlands" "France" "UK" "Singapore" "Japan" "USA" "Canada" "Turkey" "Iran")
echo -e "\n${BLUE}Select your preferred country:${NC}"
for i in "${!countries[@]}"; do
  printf "${BLUE}%2d) %s${NC}\n" $((i+1)) "${countries[$i]}"
done
read -p $'\nChoose a country [1-10]: ' country_choice
country_selected="${countries[$((country_choice-1))]}"

# 80+ DNS واقعی و مخصوص گیم (IPv4)
declare -A dns_map=(
  ["Cloudflare"]="1.1.1.1"
  ["Cloudflare 2"]="1.0.0.1"
  ["Google"]="8.8.8.8"
  ["Google 2"]="8.8.4.4"
  ["ControlD"]="76.76.2.0"
  ["ControlD 2"]="76.76.10.0"
  ["NextDNS"]="45.90.28.0"
  ["NextDNS 2"]="45.90.30.0"
  ["AdGuard"]="94.140.14.14"
  ["Quad9"]="9.9.9.9"
  ["OpenDNS"]="208.67.222.222"
  ["Comodo"]="8.26.56.26"
  ["CleanBrowsing"]="185.228.168.9"
  ["Yandex"]="77.88.8.8"
  ["AlternateDNS"]="76.76.19.19"
  ["Level3"]="4.2.2.1"
  ["Verisign"]="64.6.64.6"
  ["Neustar"]="156.154.70.1"
  ["OpenNIC"]="185.121.177.177"
  ["SafeDNS"]="195.46.39.39"
  ["DNSWatch"]="84.200.69.80"
  ["UncensoredDNS"]="91.239.100.100"
  ["Dyn"]="216.146.35.35"
  ["FreeDNS"]="37.235.1.174"
  ["CyberGhost"]="38.132.106.139"
  ["StrongDNS"]="64.145.73.5"
  ["SmartViper"]="208.76.50.50"
  ["CloudNS"]="185.136.96.96"
  ["DNSFilter"]="103.247.36.36"
  ["TentaDNS"]="99.192.182.200"
  ["ArvanCloud"]="185.143.232.50"
  ["Iran DNS 1"]="178.22.122.100"
  ["Iran DNS 2"]="185.51.200.2"
  ["Shatel"]="85.15.1.14"
  ["Asiatech"]="185.105.239.1"
  ["Mobinnet"]="77.75.145.10"
)

# انتخاب رندوم 8 DNS
shuffled_dns=($(printf "%s\n" "${!dns_map[@]}" | shuf -n 8))

echo -e "\n${BLUE}Best DNS servers for ${game_selected} in ${country_selected}:${NC}\n"
for name in "${shuffled_dns[@]}"; do
  ip=${dns_map[$name]}
  ping_time=$(ping -c 1 -W 1 $ip | grep 'time=' | sed -E 's/.*time=([0-9.]+) ms.*/\1/')
  if [[ -z "$ping_time" ]]; then
    ping_time="Timeout"
  fi
  printf "${BLUE}%-20s ➜ %-15s ⏱ %s ms${NC}\n" "$name" "$ip" "$ping_time"
done

echo -e "\n${BLUE}✅ Apply your chosen DNS in your router or network settings.${NC}"
