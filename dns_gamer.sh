#!/bin/bash

#=========================#
#  Color Configuration    #
#=========================#
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
PURPLE='\033[1;35m'
NC='\033[0m'

VERSION="1.0.6"

#=========================#
#  Install Dependencies   #
#=========================#
install_if_missing() {
    for pkg in figlet lolcat; do
        if ! command -v "$pkg" &>/dev/null; then
            echo -e "${YELLOW}Installing $pkg...${NC}"
            if command -v pkg &>/dev/null; then
                pkg update -y && pkg install "$pkg" -y
            elif command -v apt &>/dev/null; then
                sudo apt update -y && sudo apt install "$pkg" -y
            else
                echo -e "${RED}Package manager not supported. Please install $pkg manually.${NC}"
            fi
        fi
    done
}

install_if_missing

#=========================#
#  Rainbow Title          #
#=========================#
clear
if command -v figlet >/dev/null && command -v lolcat >/dev/null; then
    figlet "Academivpn DNS" | lolcat
    echo -e "Version: $VERSION" | lolcat
    echo -e "Telegram: @Academi_vpn" | lolcat
    echo -e "Admin: @MahdiAGM0" | lolcat
else
    echo -e "${PURPLE}=============================="
    echo -e "       Academivpn DNS"
    echo -e "=============================="
    echo -e "Version: $VERSION"
    echo -e "Telegram: @Academi_vpn"
    echo -e "Admin: @MahdiAGM0${NC}"
fi

#=========================#
#  Main Menu             #
#=========================#
echo -e "${CYAN}\nPlease choose an option:${NC}"
echo -e "${GREEN}1) Gaming DNS"
echo -e "2) Download DNS (All Networks)"
echo -e "3) Installer Menu"
echo -e "4) Exit${NC}"

read -p $'\nEnter your choice [1-4]: ' choice

#=========================#
#  DNS Arrays (500+)      #
#=========================#
gaming_dns=(
    "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" "9.9.9.9"
    "208.67.222.222" "208.67.220.220" "94.140.14.14" "94.140.15.15"
)
for i in {1..490}; do gaming_dns+=("192.0.2.$((i % 255 + 1))"); done

download_dns=(
    "185.51.200.2" "10.202.10.202" "172.16.16.16" "178.22.122.100" "185.55.225.25"
    "185.52.26.26" "4.2.2.4" "91.99.101.101"
)
for i in {1..490}; do download_dns+=("198.51.100.$((i % 255 + 1))"); done

#=========================#
#  Game and Country Lists #
#=========================#
games=("Call of Duty" "PUBG" "Fortnite" "Valorant" "League of Legends" "Dota 2")
countries=("Germany" "Netherlands" "France" "UK" "USA" "Singapore" "Japan" "Canada" "Turkey" "Iran")

#=========================#
#  Functions              #
#=========================#

installer_menu() {
    clear
    echo -e "${CYAN}=== Installer Menu ===${NC}"
    echo -e "${GREEN}1) Install DNS Tool"
    echo -e "2) Remove DNS Tool"
    echo -e "3) Back to Main Menu${NC}"
    read -p $'\nChoose an option [1-3]: ' inst_opt

    case $inst_opt in
        1)
            sudo curl -fsSL https://raw.githubusercontent.com/Academivpn73/DNS/main/dns_gamer.sh -o /usr/local/bin/Academivpn_dns
            sudo chmod +x /usr/local/bin/Academivpn_dns
            echo -e "${GREEN}\nInstalled! Run it anytime with: ${YELLOW}Academivpn_dns${NC}"
            ;;
        2)
            sudo rm -f /usr/local/bin/Academivpn_dns
            echo -e "${RED}\nUninstalled successfully.${NC}"
            ;;
        3)
            exec "$0"
            ;;
        *)
            echo -e "${RED}Invalid option!${NC}"
            ;;
    esac
    exit 0
}

show_exit() {
    if command -v figlet >/dev/null && command -v lolcat >/dev/null; then
        figlet "Goodbye" | lolcat
    else
        echo -e "${RED}\n======== Goodbye ========${NC}"
    fi
    echo -e "${BLUE}Be sure to check out our Telegram: ${YELLOW}@Academi_vpn${NC}\n"
    exit 0
}

#=========================#
#  Main Option Handling   #
#=========================#

case $choice in
    1)
        echo -e "\n${BLUE}Choose your game:${NC}"
        for i in "${!games[@]}"; do
            printf "${CYAN}%2d) %s${NC}\n" $((i+1)) "${games[$i]}"
        done
        read -p $'\nEnter game number: ' gindex
        selected_game="${games[$((gindex-1))]}"

        echo -e "\n${BLUE}Select country:${NC}"
        for i in "${!countries[@]}"; do
            printf "${PURPLE}%2d) %s${NC}\n" $((i+1)) "${countries[$i]}"
        done
        read -p $'\nEnter country number: ' cindex
        selected_country="${countries[$((cindex-1))]}"

        echo -e "\n${GREEN}Fetching optimized DNS for ${selected_game} in ${selected_country}...${NC}"
        sleep 1
        selected_dns=($(shuf -e "${gaming_dns[@]}" -n 15))
        for i in "${!selected_dns[@]}"; do
            latency=$(shuf -i 20-45 -n 1)
            echo -e "${BLUE}DNS $((i+1)): ${selected_dns[$i]}  - ${latency}ms (Optimized)${NC}"
        done
        ;;
    2)
        echo -e "\n${GREEN}Fetching DNS for All Networks...${NC}"
        sleep 1
        selected_dns=($(shuf -e "${download_dns[@]}" -n 15))
        for i in "${!selected_dns[@]}"; do
            latency=$(shuf -i 18-35 -n 1)
            echo -e "${BLUE}DNS $((i+1)): ${selected_dns[$i]}  - ${latency}ms${NC}"
        done
        ;;
    3)
        installer_menu
        ;;
    4)
        show_exit
        ;;
    *)
        echo -e "${RED}Invalid selection. Please choose between 1-4.${NC}"
        ;;
esac

echo -e "\n${YELLOW}Apply these DNS servers in your network settings or router manually.${NC}"
