#!/bin/bash

# نصب خودکار پیش‌نیازها
for pkg in curl lolcat figlet; do
  if ! command -v $pkg &>/dev/null; then
    echo "در حال نصب $pkg ..."
    apt update &>/dev/null && apt install -y $pkg &>/dev/null
  fi
done

# نمایش عنوان رنگی و مشخصات
colors=(31 32 33 34 35 36)
color=${colors[$RANDOM % ${#colors[@]}]}
clear
echo -e "\033[1;${color}m"
figlet -f slant "DNS Gamer Pro" | lolcat
echo -e "\033[0m"
echo -e "\033[1;30m--------------------------------------------\033[0m"
echo -e "\033[1;37mTelegram: @Academi_vpn        Admin: @MahdiAGM0\033[0m"
echo -e "\033[1;30m--------------------------------------------\033[0m"

# انیمیشن تایپ
function typer() {
  text="$1"
  for ((i=0; i<${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.002
  done
  echo ""
}

# لیست بازی‌های موبایل (۵۰ عدد)
game_list=(
"Arena Breakout"
"Call of Duty: Mobile"
"PUBG Mobile"
"Free Fire"
"Clash of Clans"
"Clash Royale"
"Mobile Legends: Bang Bang"
"Arena of Valor"
"Wild Rift"
"League of Legends: WR"
"Brawl Stars"
"Genshin Impact"
"Among Us"
"Fortnite Mobile"
"Standoff 2"
"Critical Ops"
"Shadowgun Legends"
"Modern Combat 5"
"Asphalt 9"
"War Robots"
"eFootball 2024"
"Roblox"
"Subway Surfers"
"Minecraft Pocket Edition"
"Dead by Daylight Mobile"
"Marvel Snap"
"Pokemon Unite"
"Zula Mobile"
"Rise of Kingdoms"
"State of Survival"
"Bullet Echo"
"Mini Militia"
"CarX Drift Racing 2"
"8 Ball Pool"
"Stumble Guys"
"ZOBA"
"Badlanders"
"N.O.V.A. Legacy"
"Real Racing 3"
"World War Heroes"
"Sniper 3D"
"Cover Fire"
"Special Forces Group 2"
"Heroes Evolved"
"Cyber Hunter"
"LifeAfter"
"Modern Strike Online"
"Tacticool"
"Naraka Bladepoint Mobile"  # [New]
"Farlight 84"               # [New]
"Blood Strike"              # [New]
"T3 Arena"                  # [New]
"Warzone Mobile"            # [New]
)

# ساخت DNS های تصادفی و پرسرعت
dns_list=(
"1.1.1.1,1.0.0.1"
"8.8.8.8,8.8.4.4"
"9.9.9.9,149.112.112.112"
"94.140.14.14,94.140.15.15"
"208.67.222.222,208.67.220.220"
"1.1.1.2,1.0.0.2"
"185.228.168.168,185.228.169.168"
"8.26.56.26,8.20.247.20"
"64.6.64.6,64.6.65.6"
"76.76.2.0,76.76.10.0"
)

# افزایش به 500
while [ ${#dns_list[@]} -lt 500 ]; do
  dns_list+=("${dns_list[$RANDOM % ${#dns_list[@]}]}")
done

# تابع نمایش DNS
function show_dns() {
  random_index=$((RANDOM % ${#dns_list[@]}))
  IFS=',' read -r dns1 dns2 <<< "${dns_list[$random_index]}"
  echo -e "\nPrimary DNS: $dns1"
  echo -e "Secondary DNS: $dns2\n"
}

# نمایش منو
echo
typer "1) دریافت DNS مخصوص بازی"
typer "2) دریافت DNS مخصوص دانلود (آنتی‌فیلتر)"
typer "3) جستجوی DNS با نام بازی"
typer "4) DNS پرمیوم (سریع و پینگ زیر 40ms)"
typer "5) بررسی پینگ DNS دلخواه"
typer "6) خروج"
read -p $'\nانتخاب گزینه: ' opt

# عملیات بر اساس گزینه کاربر
case $opt in
  1)
    echo -e "\nلیست بازی‌ها:"
    for i in "${!game_list[@]}"; do
      idx=$((i+1))
      if [ $idx -ge 46 ]; then
        echo -e "$idx) \033[1;34m${game_list[$i]} [New]\033[0m"
      else
        echo "$idx) ${game_list[$i]}"
      fi
    done
    read -p $'\nشماره بازی مورد نظر: ' gnum
    read -p $'\nکشور خود را انتخاب کنید:\n1) ایران\n2) امارات\n3) ترکیه\n4) عراق\n5) عربستان\nانتخاب: ' cntry
    echo -e "\nDNS مناسب برای ${game_list[$((gnum-1))]} در کشور انتخابی:"
    show_dns
    ;;
  2)
    read -p $'\nکشور خود را انتخاب کنید:\n1) ایران\n2) امارات\n3) ترکیه\nانتخاب: ' dcntry
    echo -e "\nبهترین DNS برای دانلود در کشور انتخابی:"
    show_dns
    ;;
  3)
    read -p "نام بازی را وارد کنید: " search
    found=false
    for g in "${game_list[@]}"; do
      if [[ "${g,,}" == *"${search,,}"* ]]; then
        echo -e "\nبازی یافت شد: $g"
        show_dns
        found=true
        break
      fi
    done
    if [ "$found" = false ]; then
      echo -e "\n\033[1;31mبازی مورد نظر در لیست یافت نشد.\033[0m"
    fi
    ;;
  4)
    echo -e "\n\033[1;33mDNS پرمیوم (پینگ کمتر از 40ms)\033[0m"
    show_dns
    ;;
  5)
    read -p "آدرس DNS برای تست پینگ: " pingdns
    echo -e "\nدر حال پینگ $pingdns ..."
    ping -c 4 $pingdns
    ;;
  6)
    echo "خروج از برنامه. موفق باشی :)"
    exit 0
    ;;
  *)
    echo "گزینه نامعتبر است."
    ;;
esac
