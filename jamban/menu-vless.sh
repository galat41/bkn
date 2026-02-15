#!/bin/bash
# Welcome Information
# Edition : Stable Edition V1.0
# Author  : JULAK BANTUR
# (C) Copyright 2023-2024 By JULAK BANTUR
# =========================================
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

clear
echo -e "\e[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[34m       • XRAY / VLESS MENU •         \E[0m"
echo -e "\e[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " [\e[36m01\e[0m] Create Vless Account "
echo -e " [\e[36m02\e[0m] Renew Vless Account "
echo -e " [\e[36m03\e[0m] Delete Vless Account "
echo -e " [\e[36m04\e[0m] Cek User Login "
echo -e " [\e[36m05\e[0m] Check Member Vless Account "
echo -e " [\e[36m06\e[0m] Trial Vless Account "
echo -e " [\e[36m07\e[0m] Add Vless (Manual uuid) "
echo -e " [\e[36m00\e[0m] Back To Menu "
echo -e " [\e[36mxx\e[0m] Exit "
echo -e "\e[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; add-vless ; exit ;;
2) clear ; renew-vless ; exit ;;
3) clear ; del-vless ; exit ;;
4) clear ; cek-vless ; exit ;;
5) clear ; mem-vless ; exit ;;
6) clear ; trialvless ; exit ;;
7) clear ; add-vls ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo "Anda salah tekan " ; sleep 1 ; menu-vless ;;
esac
