#!/bin/bash
clear
GREEN='\e[92m'; RED='\e[91m'; YELLOW='\e[93m'; RESET='\e[0m'

echo -e "${GREEN}🎮 DNS Gaming Tool v3.0"
echo "Telegram: @Academi_vpn  |  Admin: @MahdiAGM0"
echo -e "═════════════════════════════════════════════${RESET}"

# 1. انتخاب بازی
games=(
"PUBG Mobile" "Fortnite" "Call of Duty: Mobile" "Free Fire"
"Valorant" "Apex Legends" "CS2" "League of Legends" "Dota 2" "FIFA"
"Overwatch 2" "Minecraft" "Mobile Legends" "Wild Rift" "Clash Royale"
"Clash of Clans" "Among Us" "Warzone" "Genshin Impact" "Brawl Stars"
"Rocket League" "Honkai: Star Rail" "Team Fortress 2" "Rust" "Roblox"
"Battlefield" "Rainbow Six Siege" "ARK: Survival" "Smite" "Paladins"
)

echo -e "${YELLOW}\nSelect the game you play:${RESET}"
select game in "${games[@]}"; do
  [[ -n "$game" ]] && break
done

# 2. انتخاب IPv4 یا IPv6
echo -e "${YELLOW}\nChoose DNS IP Version:${RESET}"
echo "1) IPv4"
echo "2) IPv6"
read -p "Select (1 or 2): " ipver

# 3. انتخاب کشور
countries=("Iran" "Germany" "Netherlands" "Singapore" "USA" "France" "Turkey" "India" "UK" "Japan")
echo -e "${YELLOW}\nSelect Region:${RESET}"
select country in "${countries[@]}"; do
  [[ -n "$country" ]] && break
done

# 4. لیست DNS ها برای هر کشور
get_dns_list() {
  local iptype="$1"
  local region="$2"

  if [[ "$iptype" == "4" ]]; then
    case "$region" in
      "Iran") dns=(
        "178.22.122.100|Shecan"
        "185.51.200.2|Electro"
        "10.202.10.10|Local"
        "185.105.239.2|Shatel"
        "185.55.225.25|Radar"
        "10.202.10.202|Private"
        "185.231.182.1|Respina"
        "185.51.200.3|HyperNET"
        "185.208.173.1|AsiaTech"
        "178.22.122.101|Shecan 2"
      ) ;;
      "Germany") dns=(
        "45.90.28.0|NextDNS"
        "9.9.9.11|Quad9"
        "1.1.1.1|Cloudflare"
        "8.8.8.8|Google"
        "94.140.14.14|AdGuard"
        "94.130.180.225|Level3"
        "176.103.130.130|AdGuard"
        "80.241.218.68|Uncensored"
        "84.200.69.80|DNS.WATCH"
        "208.67.222.222|OpenDNS"
      ) ;;
      "USA") dns=(
        "8.8.8.8|Google"
        "1.0.0.1|Cloudflare"
        "9.9.9.9|Quad9"
        "208.67.222.222|OpenDNS"
        "4.2.2.2|Level3"
        "205.171.3.65|Sprint"
        "8.26.56.26|Comodo"
        "156.154.70.1|Neustar"
        "4.2.2.4|Verizon"
        "129.250.35.250|NTT"
      ) ;;
      # سایر کشورها (با DNS معروف و با پینگ مناسب)
      *) dns=(
        "1.1.1.1|Cloudflare"
        "8.8.8.8|Google"
        "9.9.9.9|Quad9"
        "208.67.222.222|OpenDNS"
        "94.140.14.14|AdGuard"
        "45.90.28.0|NextDNS"
        "76.76.2.0|ControlD"
        "185.228.168.9|CleanBrowsing"
        "77.88.8.8|Yandex"
        "89.233.43.71|UncensoredDNS"
      ) ;;
    esac
  else
    dns=(
      "2606:4700:4700::1111|Cloudflare"
      "2001:4860:4860::8888|Google"
      "2a0d:2a00:1::1|NextDNS"
      "2620:fe::fe|Quad9"
      "2a10:50c0::ad1:ff|AdGuard"
      "2620:119:35::35|OpenDNS"
      "2a00:5a60::ad2:0ff|CleanBrowsing"
      "2a00:5a60::ad1:0ff|ControlD"
      "2a00:5a60::1|Yandex"
      "2a10:50c0::ad2:ff|UncensoredDNS"
    )
  fi

  # خروجی پینگ DNS
  echo -e "\n${GREEN}Top 10 Optimized DNS for $game - $region (IPv$iptype):${RESET}"
  i=1
  for entry in "${dns[@]}"; do
    ip="${entry%%|*}"
    name="${entry##*|}"

    if [[ "$ipver" == "1" ]]; then
      ping_val=$(ping -c1 -W1 "$ip" 2>/dev/null | grep time= | sed -E 's/.*time=([0-9.]+).*/\1/')
    else
      ping_val=$(ping6 -c1 -W1 "$ip" 2>/dev/null | grep time= | sed -E 's/.*time=([0-9.]+).*/\1/')
    fi

    if [[ "$ping_val" != "" ]]; then
      printf "%2d) %-40s [%-15s] 🟢 %s ms\n" "$i" "$ip" "$name" "$ping_val"
      ((i++))
    fi
    [[ $i -gt 10 ]] && break
  done
}

# تعیین IP ورژن
[[ "$ipver" == "1" ]] && iptype="4" || iptype="6"

# فراخوانی تابع نمایش DNS
get_dns_list "$iptype" "$country"

echo -e "\n${YELLOW}✅ Copy your favorite DNS and set it in your system/router manually.${RESET}"
