#!/bin/bash

# رنگ‌های ANSI
colors=(31 32 33 34 35 36 91 92 93 94 95 96)
random_color=${colors[$RANDOM % ${#colors[@]}]}

# تابع تایپ انیمیشنی سریع
type_writer() {
    text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep 0.001
    done
    echo
}

# تابع انیمیشن بالا به پایین برای لیست‌ها
list_scroll() {
    for item in "$@"; do
        echo -e "$item"
        sleep 0.03
    done
}

# تابع پینگ گرفتن
get_ping() {
    ping -c 1 -W 1 "$1" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1
}

# تایتل رنگی
clear
echo -e "\e[1;${random_color}m╔══════════════════════════════════════╗"
echo -e "║          🌀 DNS MANAGER v1.2.1       ║"
echo -e "╠══════════════════════════════════════╣"
echo -e "║  Telegram: @Academi_vpn             ║"
echo -e "║  Admin   : @MahdiAGM0               ║"
echo -e "╚══════════════════════════════════════╝\e[0m"
echo ""

# نمایش منو
type_writer $'\e[1;36m[1]\e[0m Gaming DNS 🎮'
type_writer $'\e[1;36m[2]\e[0m Download DNS ⬇️'
type_writer $'\e[1;36m[0]\e[0m Exit ❌'
echo ""

read -p $'\e[1;33mSelect an option: \e[0m' choice

if [[ $choice == 1 ]]; then
    clear
    echo -e "\e[1;34mSelect a Game:\e[0m"
    games=(
        "1) Call of Duty"
        "2) PUBG"
        "3) Fortnite"
        "4) Valorant"
        "5) Free Fire"
        "6) Apex Legends"
        "7) Overwatch"
        "8) Dota 2"
        "9) League of Legends"
        "10) CS:GO"
        "11) Warzone"
        "12) Minecraft"
        "13) Mobile Legends"
        "14) Rocket League"
        "15) Rainbow Six Siege"
        "16) Clash Royale"
        "17) Clash of Clans"
        "18) Arena of Valor"
        "19) Roblox"
        "20) FIFA"
        "21) PES"
        "22) Battlefield"
        "23) Destiny 2"
        "24) World of Warcraft"
        "25) GTA Online"
        "26) Cyberpunk Online"
        "27) Elden Ring Online"
        "28) The Finals"
        "29) Crossfire"
        "30) War Thunder"
    )
    list_scroll "${games[@]}"
    echo ""
    read -p $'\e[1;33mSelect Game ID (1-30): \e[0m' game_id

    echo ""
    echo -e "\e[1;36mSelect Region:\e[0m"
    countries=(
        "1) Iran 🇮🇷"
        "2) Turkey 🇹🇷"
        "3) UAE 🇦🇪"
        "4) Saudi Arabia 🇸🇦"
        "5) Qatar 🇶🇦"
        "6) Iraq 🇮🇶"
        "7) Israel 🇮🇱"
        "8) Pakistan 🇵🇰"
        "9) Egypt 🇪🇬"
        "10) Jordan 🇯🇴"
    )
    list_scroll "${countries[@]}"
    echo ""
    read -p $'\e[1;33mSelect Region ID (1-10): \e[0m' region_id

    echo ""
    echo -e "\e[1;32m🎮 Best DNS Servers for ${games[$game_id-1]} - ${countries[$region_id-1]}\e[0m"
    echo ""

    # 15 DNS واقعی نمونه
    dns_list=(
        "1) 1.1.1.1"
        "2) 8.8.8.8"
        "3) 9.9.9.9"
        "4) 208.67.222.222"
        "5) 94.140.14.14"
        "6) 185.51.200.2"
        "7) 178.22.122.100"
        "8) 185.51.200.4"
        "9) 77.88.8.8"
        "10) 80.80.80.80"
        "11) 91.239.100.100"
        "12) 1.0.0.1"
        "13) 8.26.56.26"
        "14) 76.76.2.0"
        "15) 156.154.70.1"
    )

    for dns in "${dns_list[@]}"; do
        ip=$(echo "$dns" | awk '{print $2}')
        ping_time=$(get_ping "$ip")
        echo -e "$dns | \e[1;33mPing:\e[0m ${ping_time:-N/A} ms"
        sleep 0.03
    done

elif [[ $choice == 2 ]]; then
    clear
    echo -e "\e[1;34mSelect Download Region:\e[0m"
    download_regions=(
        "1) Iran 🇮🇷"
        "2) USA 🇺🇸"
        "3) Germany 🇩🇪"
        "4) UK 🇬🇧"
        "5) Japan 🇯🇵"
        "6) Singapore 🇸🇬"
        "7) Canada 🇨🇦"
        "8) Netherlands 🇳🇱"
        "9) France 🇫🇷"
        "10) South Korea 🇰🇷"
        "11) Russia 🇷🇺"
        "12) Brazil 🇧🇷"
        "13) India 🇮🇳"
        "14) Australia 🇦🇺"
        "15) Italy 🇮🇹"
        "16) Sweden 🇸🇪"
        "17) Finland 🇫🇮"
        "18) UAE 🇦🇪"
        "19) Saudi Arabia 🇸🇦"
        "20) Turkey 🇹🇷"
    )
    list_scroll "${download_regions[@]}"
    echo ""
    read -p $'\e[1;33mSelect Region ID (1-20): \e[0m' dregion_id

    echo ""
    echo -e "\e[1;32m⬇️ Top DNS for Downloads - ${download_regions[$dregion_id-1]}\e[0m"
    echo ""

    # 15 DNS برای دانلود (نمونه)
    download_dns=(
        "1) 1.1.1.1"
        "2) 8.8.4.4"
        "3) 208.67.220.220"
        "4) 9.9.9.11"
        "5) 8.26.56.26"
        "6) 76.76.2.0"
        "7) 185.51.200.2"
        "8) 77.88.8.8"
        "9) 185.51.200.4"
        "10) 91.239.100.100"
        "11) 80.80.80.80"
        "12) 94.140.14.14"
        "13) 156.154.70.1"
        "14) 1.0.0.1"
        "15) 195.46.39.39"
    )

    for dns in "${download_dns[@]}"; do
        ip=$(echo "$dns" | awk '{print $2}')
        ping_time=$(get_ping "$ip")
        echo -e "$dns | \e[1;33mPing:\e[0m ${ping_time:-N/A} ms"
        sleep 0.03
    done

elif [[ $choice == 0 ]]; then
    echo -e "\n\e[1;32mGoodbye 🙏🏻\e[0m"
    exit 0
else
    echo -e "\e[1;31mInvalid option!\e[0m"
fi
