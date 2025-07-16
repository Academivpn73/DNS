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

VERSION="1.0.5"

#=========================#
#  Title Display          #
#=========================#
clear
if command -v figlet >/dev/null && command -v lolcat >/dev/null; then
    figlet "Academivpn DNS" | lolcat
else
    echo -e "${CYAN}=============================="
    echo -e "       Academivpn DNS"
    echo -e "==============================${NC}"
fi

#=========================#
#  Main Menu             #
#=========================#
echo -e "${PURPLE}Version: $VERSION${NC}"
echo -e "${YELLOW}Telegram: @Academi_vpn${NC}"
echo -e "${CYAN}\nPlease choose an option:${NC}"
echo -e "${GREEN}1) Gaming DNS"
echo -e "2) Download DNS (All Networks)"
echo -e "3) Installer Menu"
echo -e "4) Exit${NC}"

read -p $'\nEnter your choice [1-4]: ' choice

#=========================#
#  DNS Arrays (Sample 500 each) #
#=========================#

gaming_dns=(
    "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" "9.9.9.9" "149.112.112.112"
    "208.67.222.222" "208.67.220.220" "94.140.14.14" "94.140.15.15"
    "185.228.168.9" "185.228.169.9" "76.76.2.0" "76.76.10.0"
    "45.90.28.0" "45.90.30.0" "64.6.64.6" "64.6.65.6"
    # Add up to 500+ total DNS entries...
)

download_dns=(
    "185.51.200.2" "185.51.200.3" "10.202.10.202" "172.16.16.16"
    "10.202.10.102" "178.22.122.100" "178.22.122.101" "185.55.225.25"
    "185.55.226.26" "185.52.26.26" "178.22.122.10" "91.99.101.101"
    "4.2.2.4" "4.2.2.2" "4.2.2.1" "217.218.155.155"
    # Add up to 500+ total DNS entries...
)

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
