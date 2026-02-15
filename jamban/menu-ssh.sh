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
echo -e "\e[34m        • SSH & UDP MENU •         \E[0m"
echo -e "\e[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " [\e[36m01\e[0m] Create SSH Account "
echo -e " [\e[36m02\e[0m] Renew SSH Account "
echo -e " [\e[36m03\e[0m] Delete SSH Account "
echo -e " [\e[36m04\e[0m] Check User Login "
echo -e " [\e[36m05\e[0m] List Member SSH Account "
echo -e " [\e[36m06\e[0m] Delete User Expired SSH Account "
echo -e " [\e[36m07\e[0m] Set up Autokill SSH "
echo -e " [\e[36m08\e[0m] Trial SSH Account "
echo -e " [\e[36m00\e[0m] Back To Menu "
echo -e " [\e[36mxx\e[0m] Exit "
echo -e "\e[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; usernew ; exit ;;
2) clear ; renew ; exit ;;
3) clear ; hapus ; exit ;;
4) clear ; cek ; exit ;;
5) clear ; member ; exit ;;
6) clear ; delete ; exit ;;
7) clear ; autokill ; exit ;;
8) clear ; trial ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo "Anda salah tekan " ; sleep 1 ; menu-ssh ;;
esac
