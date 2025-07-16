#!/bin/bash

# رنگ‌ها با \033
colors=(
  '\033[0;31m' # Red
  '\033[0;32m' # Green
  '\033[0;33m' # Yellow
  '\033[0;34m' # Blue
  '\033[0;35m' # Magenta
  '\033[0;36m' # Cyan
)

RESET='\033[0m'

# انیمیشن تایپ سریع‌تر
type_text() {
  local text="$1"
  local color="${2:-$RESET}"
  for ((i=0; i<${#text}; i++)); do
    echo -ne "${color}${text:$i:1}${RESET}"
    sleep 0.005  # سرعت بالاتر
  done
  echo
}

# نمایش رنگ تصادفی
rand_color() {
  echo -ne "${colors[$RANDOM % ${#colors[@]}]}"
}

# تایتل زیبا با رنگ‌ها و انیمیشن
show_title() {
  clear
  echo -e "$(rand_color)╔══════════════════════════════════════╗${RESET}"
  type_text "║      DNS MANAGEMENT SCRIPT        ║" "$(rand_color)"
  echo -e "$(rand_color)╠══════════════════════════════════════╣${RESET}"
  type_text "║  Telegram: @Academi_vpn            " "$(rand_color)"
  type_text "║  Admin   : @MahdiAGM0              " "$(rand_color)"
  type_text "║  Version : 1.2.0                   " "$(rand_color)"
  echo -e "$(rand_color)╚══════════════════════════════════════╝${RESET}"
  echo
}

# منوی اصلی با رنگ‌های جذاب و انیمیشن
show_menu() {
  type_text "[1] Gaming DNS 🎮" "$(rand_color)"
  type_text "[2] Download DNS ⬇️" "$(rand_color)"
  type_text "[0] Exit ❌" "$(rand_color)"
}

# اجرا
show_title
show_menu
