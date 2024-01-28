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
echo -e "\e[34m      • TROJAN GFW MENU •          \E[0m"
echo -e "\e[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " [\e[36m01\e[0m] Create Trojan Account "
echo -e " [\e[36m02\e[0m] Renew Trojan Account "
echo -e " [\e[36m03\e[0m] Delete Trojan Account "
echo -e " [\e[36m04\e[0m] Cek User Login "
echo -e " [\e[36m05\e[0m] Cek Member Trojan Account "
echo -e " [\e[36m06\e[0m] Trial Trojan Account "
echo -e " [\e[36m07\e[0m] Add Trojan (Manual uuid) "
echo -e " [\e[36m00\e[0m] Back To Menu "
echo -e " [\e[36mxx\e[0m] Exit "
echo -e "\e[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; add-tr ;;
2) clear ; renew-tr ;;
3) clear ; del-tr ;;
4) clear ; cek-tr ;;
5) clear ; mem-tr ;;
6) clear ; trialtrojan ;;
7) clear ; add-tru ;;
0) clear ; menu ;;
x) exit ;;
*) echo "Salah tekan Sayang" ; sleep 1 ; menu-trojan ;;
esac
