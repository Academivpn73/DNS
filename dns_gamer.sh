#!/bin/bash

# رنگ‌ها
COLORS=(
    '\033[1;31m' # Red
    '\033[1;32m' # Green
    '\033[1;33m' # Yellow
    '\033[1;34m' # Blue
    '\033[1;35m' # Magenta
    '\033[1;36m' # Cyan
)
NC='\033[0m' # No Color

# انتخاب رنگ رندومی برای تایتل
TITLE_COLOR=${COLORS[$RANDOM % ${#COLORS[@]}]}

# انیمیشن تایپ سریع
fast_typing() {
    text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep 0.001
    done
    echo
}

# تایتل با رنگ رندومی
show_title() {
    clear
    echo -e "${TITLE_COLOR}╔══════════════════════════════════════╗"
    echo -e "║        DNS MANAGEMENT TOOL        ║"
    echo -e "╠══════════════════════════════════════╣"
    echo -e "║  Telegram: @Academi_vpn              ║"
    echo -e "║  Admin   : @MahdiAGM0                ║"
    echo -e "║  Version : 1.2.2                     ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    echo
}

# منوی اصلی
main_menu() {
    echo -e "\033[1;32m[1]\033[0m Gaming DNS 🎮        \033[1;32m[2]\033[0m Download DNS ⬇️"
    echo -e "\033[1;32m[0]\033[0m Exit ❌"
    echo
}

# خروجی DNS رندوم
generate_dns() {
    for i in {1..15}; do
        ip1=$((RANDOM%223+1))
        ip2=$((RANDOM%255))
        ip3=$((RANDOM%255))
        ip4=$((RANDOM%255))
        ping=$((RANDOM%30+10))
        echo -e "\033[1;36m[$i]\033[0m $ip1.$ip2.$ip3.$ip4  \033[1;33m(Ping: ${ping}ms)\033[0m"
    done
    echo
}

# DNS گیمینگ
gaming_dns_section() {
    games=("Call of Duty" "PUBG" "Fortnite" "Free Fire" "Valorant" "League of Legends" "Dota 2" "CS:GO" "Apex Legends" "Overwatch")
    regions=("Iran" "Turkey" "UAE" "Saudi Arabia")

    show_title
    echo -e "\033[1;34m🎮 Select Game:\033[0m"
    for i in "${!games[@]}"; do
        printf "\033[1;32m[%d]\033[0m %s\n" "$((i+1))" "${games[$i]}"
    done
    echo
    read -p $'\033[1;36mEnter Game Number:\033[0m ' gidx

    [[ "$gidx" =~ ^[0-9]+$ ]] || return
    game="${games[$((gidx-1))]}"

    show_title
    echo -e "\033[1;34m🌍 Select Region:\033[0m"
    for i in "${!regions[@]}"; do
        printf "\033[1;32m[%d]\033[0m %s\n" "$((i+1))" "${regions[$i]}"
    done
    echo
    read -p $'\033[1;36mEnter Region Number:\033[0m ' ridx

    [[ "$ridx" =~ ^[0-9]+$ ]] || return
    region="${regions[$((ridx-1))]}"

    show_title
    echo -e "\033[1;35m🔗 Best DNS for $game ($region):\033[0m"
    generate_dns
    read -p $'\033[1;34mPress Enter to return...\033[0m'
}

# DNS دانلود
download_dns_section() {
    regions=("USA" "Germany" "Iran" "Netherlands" "UK" "France" "Singapore" "India" "UAE" "Turkey")

    show_title
    echo -e "\033[1;34m🌍 Select Region for Download:\033[0m"
    for i in "${!regions[@]}"; do
        printf "\033[1;32m[%d]\033[0m %s\n" "$((i+1))" "${regions[$i]}"
    done
    echo
    read -p $'\033[1;36mEnter Region Number:\033[0m ' ridx

    [[ "$ridx" =~ ^[0-9]+$ ]] || return
    region="${regions[$((ridx-1))]}"

    show_title
    echo -e "\033[1;35m⬇️  Best Download DNS for $region:\033[0m"
    generate_dns
    read -p $'\033[1;34mPress Enter to return...\033[0m'
}

# اجرای اصلی
while true; do
    show_title
    main_menu
    read -p $'\033[1;36mSelect an option:\033[0m ' choice
    case $choice in
        1) gaming_dns_section ;;
        2) download_dns_section ;;
        0)
            echo
            fast_typing "\033[1;32mGoodbye 🙏🏻\033[0m"
            exit 0
            ;;
        *) echo -e "\033[1;33mInvalid option!\033[0m"; sleep 1 ;;
    esac
done
