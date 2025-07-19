#!/bin/bash

clear

# Colors
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
RESET='\033[0m'

# Title Box
echo -e "${YELLOW}┌────────────────────────────────────────────┐${RESET}"
echo -e "${GREEN}│       ${WHITE}DNS Gamer Pro - Version 1.2.3        ${GREEN}│${RESET}"
echo -e "${YELLOW}├────────────────────────────────────────────┤${RESET}"
echo -e "${GREEN}│        ${WHITE}Updating the script, please wait...  ${GREEN}│${RESET}"
echo -e "${YELLOW}└────────────────────────────────────────────┘${RESET}"
echo

# Loading animation
echo -ne "${WHITE}Working on updates"
for i in {1..6}; do
    sleep 0.5
    echo -n "."
done

echo -e "\n\n${YELLOW}Thank you for your patience. Please try again later.${RESET}"

exit 0
