#!/bin/bash

clear

# رنگ‌ها
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════╗"
echo "║         🎮 GAMING DNS OPTIMIZER             ║"
echo "╠══════════════════════════════════════════════╣"
echo "║     Telegram: @Academi_vpn   |  Admin: Mahdi ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "${NC}"

# لیست DNSهای محبوب برای گیمینگ
dns_list=(
"1.1.1.1 # Cloudflare"
"1.0.0.1 # Cloudflare Secondary"
"8.8.8.8 # Google"
"8.8.4.4 # Google Secondary"
"94.140.14.14 # AdGuard"
"9.9.9.9 # Quad9"
"208.67.222.222 # OpenDNS"
"185.228.168.9 # CleanBrowsing"
"76.76.2.0 # ControlD"
)

echo -e "\n${GREEN}📡 Testing DNS latency...${NC}"
printf "%-22s %-10s\n" "DNS Server" "Ping"

for entry in "${dns_list[@]}"; do
  ip=$(echo $entry | awk '{print $1}')
  info=$(echo $entry | cut -d'#' -f2)
  ping_time=$(ping -c 1 -W 1 $ip | grep time= | awk -F 'time=' '{print $2}' | cut -d ' ' -f1)
  printf "%-22s %-10s\n" "$ip ($info)" "${ping_time:-timeout}"
done

echo -e "\n${CYAN}Do you want to set a DNS manually?${NC}"
read -p "Enter DNS IP (or press Enter to skip): " custom_dns

if [[ -n "$custom_dns" ]]; then
    echo -e "${GREEN}Setting DNS to $custom_dns...${NC}"
    if [[ -d /data/data/com.termux ]]; then
        echo "nameserver $custom_dns" > $PREFIX/etc/resolv.conf
    else
        sudo bash -c "echo 'nameserver $custom_dns' > /etc/resolv.conf"
    fi
    echo -e "${GREEN}✅ DNS updated successfully.${NC}"
else
    echo -e "${CYAN}No DNS was set. Exiting...${NC}"
fi
