#!/bin/bash

RED='\033[1;31m'
BLUE='\033[1;36m'
NC='\033[0m'

echo -e "\e[91m"
echo "╔════════════════════════════════════════════╗"
echo "║                                            ║"
echo "║     Telegram: @Academi_vpn                ║"
echo "║     Admin Support: @MahdiAGM0             ║"
echo "║                                            ║"
echo "╚════════════════════════════════════════════╝"
echo -e "\e[0m"

echo -e "${BLUE}Welcome to the Real Gaming DNS Booster!${NC}"
echo

# لیست DNSهای واقعی برای گیم
declare -A dns_map=(
  ["Cloudflare"]="1.1.1.1"
  ["Cloudflare2"]="1.0.0.1"
  ["Google"]="8.8.8.8"
  ["Google2"]="8.8.4.4"
  ["ControlD"]="76.76.2.0"
  ["ControlD2"]="76.76.10.0"
  ["NextDNS"]="45.90.28.0"
  ["AdGuard"]="94.140.14.14"
  ["Quad9"]="9.9.9.9"
  ["OpenDNS"]="208.67.222.222"
)

# انتخاب 5 DNS به صورت تصادفی
shuffled_dns=($(printf "%s\n" "${!dns_map[@]}" | shuf -n 5))

echo -e "\n${BLUE}Here are 5 optimized gaming DNS servers with live ping:${NC}"
for name in "${shuffled_dns[@]}"; do
    ip=${dns_map[$name]}
    ping_time=$(ping -c 1 -W 1 $ip | grep 'time=' | sed -E 's/.*time=([0-9.]+) ms.*/\1/')
    if [[ -z "$ping_time" ]]; then
        ping_time="Timeout"
    fi
    printf "${BLUE}%-12s ➜ %-15s ⏱ %s ms${NC}\n" "$name" "$ip" "$ping_time"
done

echo -e "\n${BLUE}✅ You can apply these DNS in your network settings or router panel.${NC}"
