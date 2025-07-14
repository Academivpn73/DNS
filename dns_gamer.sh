#!/bin/bash
clear
GREEN='\e[92m'; RESET='\e[0m'

echo -e "${GREEN}🎮 DNS Gaming Tool v2.2"
echo "Telegram: @Academi_vpn  |  Admin: @MahdiAGM0"
echo -e "═════════════════════════════════════════════${RESET}"

# انتخاب نوع DNS
echo -e "\nChoose DNS Type:"
echo "1) IPv4"
echo "2) IPv6"
read -p "Select (1 or 2): " iptype

# انتخاب کشور (نمایشی، تاثیری در DNSها نداره)
countries=(Iran Germany USA Japan Singapore Netherlands France Turkey UK Canada)
echo -e "\nSelect Country:"
select country in "${countries[@]}"; do
  [[ -n "$country" ]] && break
done

# لیست DNSها (برای هر دو حالت)
dns_list_ipv4=(
"1.1.1.1|Cloudflare"
"8.8.8.8|Google"
"9.9.9.9|Quad9"
"45.90.28.0|NextDNS"
"208.67.222.222|OpenDNS"
"94.140.14.14|AdGuard"
"185.228.168.9|CleanBrowsing"
"77.88.8.8|Yandex"
"76.76.2.0|ControlD"
"89.233.43.71|UncensoredDNS"
)

dns_list_ipv6=(
"2606:4700:4700::1111|Cloudflare"
"2001:4860:4860::8888|Google"
"2620:fe::fe|Quad9"
"2a0d:2a00:1::1|NextDNS"
"2620:119:35::35|OpenDNS"
"2a10:50c0::ad1:ff|AdGuard"
"2a00:5a60::ad1:0ff|CleanBrowsing"
"2a00:5a60::ad2:0ff|Yandex"
"2606:4700:4700::1001|ControlD"
"2a10:50c0::ad2:ff|UncensoredDNS"
)

echo -e "\n${GREEN}Testing DNS servers (IPv$iptype)...${RESET}"

i=1
count=0

if [[ "$iptype" == "1" ]]; then
  for dns_entry in "${dns_list_ipv4[@]}"; do
    ip="${dns_entry%%|*}"
    name="${dns_entry##*|}"
    ping_result=$(ping -c1 -W1 "$ip" 2>/dev/null | grep 'time=' | sed -E 's/.*time=([0-9.]+).*/\1/')
    if [[ "$ping_result" != "" ]]; then
      printf "%2d) %-15s [%-12s]  🟢 %sms\n" "$i" "$ip" "$name" "$ping_result"
      ((i++))
      ((count++))
    fi
    [[ $count -ge 10 ]] && break
  done
else
  for dns_entry in "${dns_list_ipv6[@]}"; do
    ip="${dns_entry%%|*}"
    name="${dns_entry##*|}"
    ping_result=$(ping6 -c1 -W1 "$ip" 2>/dev/null | grep 'time=' | sed -E 's/.*time=([0-9.]+).*/\1/')
    if [[ "$ping_result" != "" ]]; then
      printf "%2d) %-38s [%-12s]  🟢 %sms\n" "$i" "$ip" "$name" "$ping_result"
      ((i++))
      ((count++))
    fi
    [[ $count -ge 10 ]] && break
  done
fi

if [[ $count -eq 0 ]]; then
  echo -e "${RED}❌ No DNS responded. Try again or check your internet.${RESET}"
fi

echo -e "\n${GREEN}✅ Done. Apply these DNS to your system/game manually.${RESET}"
