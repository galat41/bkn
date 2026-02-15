#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

clear 
echo -e "\e[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[34m          • SYSTEM MENU •          \E[0m"
echo -e "\e[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " [\e[36m01\e[0m] Panel Domain"
echo -e " [\e[36m02\e[0m] Change Port All Account"
echo -e " [\e[36m03\e[0m] Webmin Menu"
echo -e " [\e[36m04\e[0m] Speedtest VPS"
echo -e " [\e[36m05\e[0m] About Script"
echo -e " [\e[36m06\e[0m] Set Auto Reboot"
echo -e " [\e[36m07\e[0m] Restart All Service"
echo -e " [\e[36m08\e[0m] Change Banner"
echo -e " [\e[36m09\e[0m] Cek Bandwith"
echo -e " [\e[36m10\e[0m] Install SSH UDP"
echo -e " [\e[36m00\e[0m] Back To Menu"
echo -e " [\e[36mxx\e[0m] Exit"
echo -e "\e[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-domain ; exit ;;
2) clear ; port-change ; exit ;;
3) clear ; menu-webmin ; exit ;;
4) clear ; speedtest ; exit ;;
5) clear ; about ; exit ;;
6) clear ; auto-reboot ; exit ;;
7) clear ; restart ; exit ;;
8) clear ; nano /etc/issue.net ; exit ;;
9) clear ; bw ; exit ;;
10) clear ; rm -rf udp-custom.sh && wget -q https://sc2.scvps.biz.id/rabah/udp-custom.sh &&  chmod +x udp-custom.sh && ./udp-custom.sh ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo -e "" ; echo "Anda salah tekan" ; sleep 1 ; menu-set ;;
esac
