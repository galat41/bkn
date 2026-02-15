#!/bin/bash
#Script By Julak Bantur
#Telegram : https://t.me/Cibut2d
################################
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
##############################
julak="raw.githubusercontent.com/galat41/bkn"

clear
echo -e "\e[1;36mStart Update For New Version, Please Wait..\e[m"
sleep 2
clear
echo -e "\e[0;32mGetting New Version Script..\e[0m"
sleep 1
clear
echo -e "\033[1;93mNgopi Dulu Broow..!\e[0m"
sleep 5

rm -rf menu-update
rm -rf menu
rm -rf menu-vmess
rm -rf menu-vless
rm -rf running
rm -rf clearcache
rm -rf menu-trojan
rm -rf menu-ssh
rm -rf usernew
rm -rf trial
rm -rf renew
rm -rf hapus
rm -rf cek
rm -rf member
rm -rf delete
rm -rf autokill
rm -rf ceklim
rm -rf tendang
rm -rf menu-set
rm -rf menu-domain
rm -rf add-host
rm -rf port-change
rm -rf certv2ray
rm -rf menu-webmin
rm -rf speedtest
rm -rf about
rm -rf auto-reboot
rm -rf restart
rm -rf bw
rm -rf port-ssl
rm -rf port-ovpn
rm -rf xp
rm -rf acs-set
rm -rf sshws
rm -rf add-ws
rm -rf trialvmess
rm -rf renew-ws
rm -rf del-ws
rm -rf cek-ws
rm -rf mem-ws
rm -rf add-vms
rm -rf add-vless
rm -rf trialvless
rm -rf renew-vless
rm -rf del-vless
rm -rf cek-vless
rm -rf mem-vless
rm -rf add-vls
rm -rf add-tr
rm -rf trialtrojan
rm -rf del-tr
rm -rf renew-tr
rm -rf cek-tr
rm -rf mem-tr
rm -rf add-tru

cd /usr/bin
wget -O menu-update "https://raw.githubusercontent.com/galat41/bkn/main/jamban/menu-update.sh"
wget -O menu "https://raw.githubusercontent.com/galat41/bkn/main/jamban/menu.sh"
wget -O menu-vmess "https://raw.githubusercontent.com/galat41/bkn/main/jamban/menu-vmess.sh"
wget -O menu-vless "https://raw.githubusercontent.com/galat41/bkn/main/jamban/menu-vless.sh"
wget -O running "https://raw.githubusercontent.com/galat41/bkn/main/jamban/running.sh"
wget -O clearcache "https://raw.githubusercontent.com/galat41/bkn/main/jamban/clearcache.sh"
wget -O menu-trojan "https://raw.githubusercontent.com/galat41/bkn/main/jamban/menu-trojan.sh"
wget -O menu-ssh "https://raw.githubusercontent.com/galat41/bkn/main/jamban/menu-ssh.sh"
wget -O usernew "https://raw.githubusercontent.com/galat41/bkn/main/waluh/usernew.sh"
wget -O trial "https://raw.githubusercontent.com/galat41/bkn/main/waluh/trial.sh"
wget -O renew "https://raw.githubusercontent.com/galat41/bkn/main/waluh/renew.sh"
wget -O hapus "https://raw.githubusercontent.com/galat41/bkn/main/waluh/hapus.sh"
wget -O cek "https://raw.githubusercontent.com/galat41/bkn/main/waluh/cek.sh"
wget -O member "https://raw.githubusercontent.com/galat41/bkn/main/waluh/member.sh"
wget -O delete "https://raw.githubusercontent.com/galat41/bkn/main/waluh/delete.sh"
wget -O autokill "https://raw.githubusercontent.com/galat41/bkn/main/waluh/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/galat41/bkn/main/waluh/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/galat41/bkn/main/waluh/tendang.sh"
wget -O menu-set "https://raw.githubusercontent.com/galat41/bkn/main/jamban/menu-set.sh"
wget -O menu-domain "https://raw.githubusercontent.com/galat41/bkn/main/jamban/menu-domain.sh"
wget -O add-host "https://raw.githubusercontent.com/galat41/bkn/main/waluh/add-host.sh"
wget -O port-change "https://raw.githubusercontent.com/galat41/bkn/main/purut/port-change.sh"
wget -O certv2ray "https://raw.githubusercontent.com/galat41/bkn/main/janda/certv2ray.sh"
wget -O menu-webmin "https://raw.githubusercontent.com/galat41/bkn/main/jamban/menu-webmin.sh"
wget -O speedtest "https://raw.githubusercontent.com/galat41/bkn/main/waluh/speedtest_cli.py"
wget -O about "https://raw.githubusercontent.com/galat41/bkn/main/jamban/about.sh"
wget -O auto-reboot "https://raw.githubusercontent.com/galat41/bkn/main/jamban/auto-reboot.sh"
wget -O restart "https://raw.githubusercontent.com/galat41/bkn/main/jamban/restart.sh"
wget -O bw "https://raw.githubusercontent.com/galat41/bkn/main/jamban/bw.sh"
wget -O port-ssl "https://raw.githubusercontent.com/galat41/bkn/main/purut/port-ssl.sh"
wget -O port-ovpn "https://raw.githubusercontent.com/galat41/bkn/main/purut/port-ovpn.sh"
wget -O xp "https://raw.githubusercontent.com/galat41/bkn/main/waluh/xp.sh"
wget -O acs-set "https://raw.githubusercontent.com/galat41/bkn/main/acs-set.sh"
wget -O sshws "https://raw.githubusercontent.com/galat41/bkn/main/waluh/sshws.sh"
wget -O add-ws "https://raw.githubusercontent.com/galat41/bkn/main/janda/add-ws.sh"
wget -O trialvmess "https://raw.githubusercontent.com/galat41/bkn/main/janda/trialvmess.sh"
wget -O renew-ws "https://raw.githubusercontent.com/galat41/bkn/main/janda/renew-ws.sh"
wget -O del-ws "https://raw.githubusercontent.com/galat41/bkn/main/janda/del-ws.sh"
wget -O cek-ws "https://raw.githubusercontent.com/galat41/bkn/main/janda/cek-ws.sh"
wget -O mem-ws "https://raw.githubusercontent.com/galat41/bkn/main/janda/mem-ws.sh"
wget -O add-vms "https://raw.githubusercontent.com/galat41/bkn/main/janda/add-vms.sh"
wget -O add-vless "https://raw.githubusercontent.com/galat41/bkn/main/janda/add-vless.sh"
wget -O trialvless "https://raw.githubusercontent.com/galat41/bkn/main/janda/trialvless.sh"
wget -O renew-vless "https://raw.githubusercontent.com/galat41/bkn/main/janda/renew-vless.sh"
wget -O del-vless "https://raw.githubusercontent.com/galat41/bkn/main/janda/del-vless.sh"
wget -O cek-vless "https://raw.githubusercontent.com/galat41/bkn/main/janda/cek-vless.sh"
wget -O mem-vless "https://raw.githubusercontent.com/galat41/bkn/main/janda/mem-vless.sh"
wget -O add-vls "https://raw.githubusercontent.com/galat41/bkn/main/janda/add-vls.sh"
wget -O add-tr "https://raw.githubusercontent.com/galat41/bkn/main/janda/add-tr.sh"
wget -O trialtrojan "https://raw.githubusercontent.com/galat41/bkn/main/janda/trialtrojan.sh"
wget -O del-tr "https://raw.githubusercontent.com/galat41/bkn/main/janda/del-tr.sh"
wget -O renew-tr "https://raw.githubusercontent.com/galat41/bkn/main/janda/renew-tr.sh"
wget -O cek-tr "https://raw.githubusercontent.com/galat41/bkn/main/janda/cek-tr.sh"
wget -O mem-tr "https://raw.githubusercontent.com/galat41/bkn/main/janda/mem-tr.sh"
wget -O add-tru "https://raw.githubusercontent.com/galat41/bkn/main/janda/add-tru.sh"

chmod +x menu-update
chmod +x menu
chmod +x menu-vmess
chmod +x menu-vless
chmod +x running
chmod +x clearcache
chmod +x menu-trojan
chmod +x menu-ssh
chmod +x usernew
chmod +x trial
chmod +x renew
chmod +x hapus
chmod +x cek
chmod +x member
chmod +x delete
chmod +x autokill
chmod +x ceklim
chmod +x tendang
chmod +x menu-set
chmod +x menu-domain
chmod +x add-host
chmod +x port-change
chmod +x certv2ray
chmod +x menu-webmin
chmod +x speedtest
chmod +x about
chmod +x auto-reboot
chmod +x restart
chmod +x bw
chmod +x port-ssl
chmod +x port-ovpn
chmod +x xp
chmod +x acs-set
chmod +x sshws 
chmod +x add-ws
chmod +x trialvmess
chmod +x renew-ws
chmod +x del-ws
chmod +x cek-ws
chmod +x mem-ws
chmod +x add-vms
chmod +x add-vless
chmod +x trialvless
chmod +x renew-vless
chmod +x del-vless
chmod +x cek-vless
chmod +x mem-vless
chmod +x add-vls
chmod +x add-tr
chmod +x trialtrojan
chmod +x del-tr
chmod +x renew-tr
chmod +x cek-tr
chmod +x mem-tr
chmod +x add-tru


clear
echo -e ""
echo -e "\e[0;32mDownloaded successfully!\e[0m"
sleep 2
clear
echo ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m            SCRIPT UPDATED              \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
x)
clear
exit
;;
y)
clear
menu
;;
*)
clear
echo -e "\e[1;31mPlease Enter Option 1-2 or x & y Only..,Try again, Thank You..\e[0m"
sleep 2
menu
;;
esac
