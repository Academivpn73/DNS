#!/bin/bash
clear
GREEN='\e[92m'; RESET='\e[0m'

echo -e "${GREEN}🎮 Gaming DNS Script v2.1"
echo "Telegram: @Academi_vpn  |  Admin: @MahdiAGM0"
echo -e "═════════════════════════════════════════════${RESET}"

# انتخاب نوع DNS
echo -e "\nChoose DNS IP type:"
echo "1) IPv4"
echo "2) IPv6"
read -p "Select: " iptype

# انتخاب کشور
countries=(🇮🇷Iran 🇩🇪Germany 🇺🇸USA 🇯🇵Japan 🇸🇬Singapore 🇳🇱Netherlands 🇫🇷France 🇹🇷Turkey 🇬🇧UK 🇨🇦Canada)
echo -e "\nSelect country:"
select country in "${countries[@]}"; do
  [[ -n "$country" ]] && break
done

# دیتابیس DNS برای IPv4 و IPv6
declare -A dns4=( ["Cloudflare"]="1.1.1.1" ["Google"]="8.8.8.8" ["Quad9"]="9.9.9.9" ["NextDNS"]="45.90.28.0" ["OpenDNS"]="208.67.222.222" ["AdGuard"]="94.140.14.14" ["CleanBrowsing"]="185.228.168.9" ["Yandex"]="77.88.8.8" ["ControlD"]="76.76.2.0" ["UncensoredDNS"]="89.233.43.71" )
declare -A dns6=( ["Cloudflare"]="2606:4700:4700::1111" ["Google"]="2001:4860:4860::8888" ["Quad9"]="2620:fe::fe" ["NextDNS"]="2a0d:2a00:1::1" ["OpenDNS"]="2620:119:35::35" ["AdGuard"]="2a10:50c0::ad1:ff" ["CleanBrowsing"]="2a00:5a60::ad1:0ff" ["Yandex"]="2a00:5a60::ad2:0ff" ["ControlD"]="2606:4700:4700::1001" ["UncensoredDNS"]="2a10:50c0::ad2:ff" )

echo -e "\n${GREEN}Testing DNS for ${country} (IPv${iptype})...${RESET}\n"

i=1
for name in "${!dns${iptype}}"; do
  ip="${dns${iptype}[$name]}"
  ping_cmd="ping -c1 -W1 $ip"
  if [[ "$iptype" == "2" ]]; then ping_cmd="ping6 -c1 -W1 $ip"; fi
  ping_time=$($ping_cmd | grep 'time=' | sed -E 's/.*time=([0-9.]+).*/\1/') || ping_time=""
  if [[ "$ping_time" =~ ^[0-9.]+$ ]] && (( $(echo "$ping_time < 40" | bc -l) )); then
    printf "%2d) %-16s [%s]  %4sms\n" "$i" "$ip" "$name" "$ping_time"
    ((i++))
  fi
  [[ $i -gt 10 ]] && break
done

if (( i == 1 )); then
  echo "⚠️ No DNS under 40 ms found. Showing closest:"
  i=1
  for name in "${!dns${iptype}}"; do
    ip="${dns${iptype}[$name]}"
    ping_time=$($ping_cmd | grep 'time=' | sed -E 's/.*time=([0-9.]+).*/\1/') || ping_time="Timeout"
    printf "%2d) %-16s [%s]  %s ms\n" "$i" "$ip" "$name" "$ping_time"
    ((i++))
    [[ $i -gt 10 ]] && break
  done
fi

echo -e "\n${GREEN}All done! Use these DNS in your game settings.${RESET}"
