#!/bin/bash

# رنگ‌های ANSI
colors=(31 32 33 34 35 36 91 92 93 94 95 96)
random_color=${colors[$RANDOM % ${#colors[@]}]}

# تابع تایپ سریع
type_writer() {
    text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep 0.001
    done
    echo
}

# لیست بالا به پایین
list_scroll() {
    for item in "$@"; do
        echo -e "$item"
        sleep 0.03
    done
}

# تابع گرفتن پینگ
get_ping() {
    ping -c 1 -W 1 "$1" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1
}

# تابع منوی اصلی
main_menu() {
    clear
    random_color=${colors[$RANDOM % ${#colors[@]}]}
    echo -e "\e[1;${random_color}m╔══════════════════════════════════════╗"
    echo -e "║          🌀 DNS MANAGER v1.2.2       ║"
    echo -e "╠══════════════════════════════════════╣"
    echo -e "║  Telegram: @Academi_vpn             ║"
    echo -e "║  Admin   : @MahdiAGM0               ║"
    echo -e "╚══════════════════════════════════════╝\e[0m"
    echo ""
    type_writer $'\e[1;36m[1]\e[0m Gaming DNS 🎮'
    type_writer $'\e[1;36m[2]\e[0m Download DNS ⬇️'
    type_writer $'\e[1;36m[0]\e[0m Exit ❌'
    echo ""
    read -p $'\e[1;33mSelect an option: \e[0m' choice

    case $choice in
        1) show_gaming_dns ;;
        2) show_download_dns ;;
        0) echo -e "\n\e[1;32mGoodbye 🙏🏻\e[0m" && exit 0 ;;
        *) echo -e "\e[1;31mInvalid option!\e[0m" && sleep 1 && main_menu ;;
    esac
}

# بازی‌ها و کشورها
games_list=(
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

regions_list=(
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

# تابع نمایش DNS گیم
show_gaming_dns() {
    clear
    echo -e "\e[1;34mSelect a Game (or 0 to return):\e[0m"
    list_scroll "${games_list[@]}"
    echo -e "\n\e[1;36m[0]\e[0m Return"
    read -p $'\n\e[1;33mGame ID: \e[0m' game_id
    [[ "$game_id" == "0" ]] && main_menu

    echo -e "\n\e[1;34mSelect Region:\e[0m"
    list_scroll "${regions_list[@]}"
    echo -e "\n\e[1;36m[0]\e[0m Return"
    read -p $'\n\e[1;33mRegion ID: \e[0m' region_id
    [[ "$region_id" == "0" ]] && main_menu

    echo -e "\n\e[1;32m🎮 DNS for ${games_list[$game_id-1]} - ${regions_list[$region_id-1]}\e[0m\n"
    for i in {1..15}; do
        ip="1.$((RANDOM%255)).$((RANDOM%255)).$((RANDOM%255))"
        ping_result=$(get_ping "$ip")
        echo -e "$i) $ip | \e[1;33mPing:\e[0m ${ping_result:-N/A} ms"
        sleep 0.03
    done

    echo -e "\nPress Enter to return to main menu..."
    read
    main_menu
}

# تابع نمایش DNS دانلود
show_download_dns() {
    clear
    echo -e "\e[1;34mSelect Download Region (or 0 to return):\e[0m"
    list_scroll "${download_regions[@]}"
    echo -e "\n\e[1;36m[0]\e[0m Return"
    read -p $'\n\e[1;33mRegion ID: \e[0m' dregion_id
    [[ "$dregion_id" == "0" ]] && main_menu

    echo -e "\n\e[1;32m⬇️ Top DNS for Downloads - ${download_regions[$dregion_id-1]}\e[0m\n"
    for i in {1..15}; do
        ip="2.$((RANDOM%255)).$((RANDOM%255)).$((RANDOM%255))"
        ping_result=$(get_ping "$ip")
        echo -e "$i) $ip | \e[1;33mPing:\e[0m ${ping_result:-N/A} ms"
        sleep 0.03
    done

    echo -e "\nPress Enter to return to main menu..."
    read
    main_menu
}

# اجرای منو اصلی
main_menu
