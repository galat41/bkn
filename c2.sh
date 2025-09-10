#!/bin/bash
# Script Installer
# Dibuat oleh: Julak Bantur
# Last Update : 2025
# --- Warna --- #
NC='\033[0m' # No Color
BIBlack='\033[1;90m'
BIRed='\033[1;91m'
BIGreen='\033[1;92m'
BIYellow='\033[1;93m'
BIBlue='\033[1;94m'
BIPurple='\033[1;95m'
BICyan='\033[1;96m'
BIWhite='\033[1;97m'
UWhite='\033[4;37m'
On_IPurple='\033[0;105m'
On_IRed='\033[0;101m'
IBlack='\033[0;90m'
IRed='\033[0;91m'
IGreen='\033[0;92m'
IYellow='\033[0;93m'
IBlue='\033[0;94m'
IPurple='\033[0;95m'
ICyan='\033[0;96m'
IWhite='\033[0;97m'
BGCOLOR='\e[1;97;101m' # WHITE RED
# --- Warna --- #
# warna singkat (jika diperlukan, untuk konsistensi)
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
# GREEN dan CYAN sudah didefinisikan di atas, jadi tidak perlu duplikasi.
export PINK='\033[0;35m'
export YELLOW='\033[0;33m'

# --- Fungsi Warna Teks ---
purple() { echo -e "\033[35;1m${*}\033[0m"; }
tyblue() { echo -e "\033[36;1m${*}\033[0m"; }
yellow() { echo -e "\033[33;1m${*}\033[0m"; }
green() { echo -e "\033[32;1m${*}\033[0m"; }
red() { echo -e "\033[31;1m${*}\033[0m"; }

# --- Validasi Awal ---
echo -e "${GREEN}♻️ Check Validasi Masuk...${NC}"
sleep 3
clear

# Pastikan direktori yang dibutuhkan ada
mkdir -p /etc/data

# --- Mendapatkan IP Publik Pengguna ---
user_ip=$(curl -s https://ipinfo.io/ip)
if [[ ! -f /etc/xray/isp ]]; then
curl -sS ipinfo.io/org?token=7a814b6263b02c > /etc/xray/isp
fi
if [[ ! -f /etc/xray/city ]]; then
curl -sS ipinfo.io/city?token=7a814b6263b02c > /etc/xray/city
fi

# --- Meminta Nama Client dan Memvalidasi ---
while true; do
    read -rp $'\033[0;32mMasukkan Nama Client:\033[0m ' client_name

    # Validasi Nama Client
    if [[ -z "$client_name" ]]; then
        echo "Nama Client tidak boleh kosong. Silakan masukkan kembali."
        continue
    elif [[ ! "$client_name" =~ ^[A-Za-z]+$ ]]; then
        echo "Nama Client hanya boleh berisi huruf. Silakan masukkan kembali."
        continue
    fi

    # Menggunakan curl untuk memeriksa apakah client_name ada dalam file permission.txt
    permission_file=$(curl -s https://raw.githubusercontent.com/cibut2d/reg/main/ip)
    
    # Mengambil IP_VPS juga untuk validasi di izin.txt
    IP_VPS=$(curl -s https://ipinfo.io/ip) # Pastikan ini mengambil IP publik

    if echo "$permission_file" | grep -q -i "$client_name" && echo "$permission_file" | grep -q "$IP_VPS"; then
        # Mengambil tanggal kedaluwarsa dari kolom ke-3
        exp_date=$(echo "$permission_file" | grep -i "$client_name" | awk '{print $3}')
        
        # Validasi format tanggal
        if ! [[ "$exp_date" =~ ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$ ]]; then
            echo -e "${red}❌ Format tanggal invalid: '$exp_date' (harus YYYY-MM-DD)${NC}"
            exit 1
        fi

        # Validasi tanggal menggunakan date
        if ! date -d "$exp_date" "+%s" &>/dev/null; then
            echo -e "${red}❌ Tanggal tidak valid secara kalender: $exp_date${NC}"
            exit 1
        fi

        echo "Client Name accepted... Let's go..."
        break
    else
        echo -e "${red}❌ Client Name atau IP ($IP_VPS) tidak terdaftar!${NC}"
        echo -e "➥ Hubungi admin ${CYAN}「 ✦ @JulakBantur ✦ 」${NC}"
        # Hapus file installer jika validasi gagal
        rm -f /root/home 
        exit 1
    fi
done

echo -e "${GREEN}Sedang Melanjutkan proses...${NC}"
sleep 2

echo -e "${GREEN}Mengunduh dan menginstal dependensi...${NC}"
sleep 2

clear

# --- Detail API Bot Telegram ---
TOKEN="6561892159:AAEfW_wh32WA3KzJDVrvFDDbtazjcmA2Cc4"
CHAT_ID="2118266757"

# --- Fungsi untuk Mengirim Pesan ke Telegram ---
send_telegram_message() {
    MESSAGE=$1
    BUTTON1_URL="https://t.me/rajaganjil93"
    BUTTON2_URL="https://wa.me/081250851741"
    BUTTON_TEXT1="Telegram 😎"
    BUTTON_TEXT2="Whatsapp 🐳"

    RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        -d parse_mode="MarkdownV2" \
        -d text="$MESSAGE" \
        -d reply_markup='{
                "inline_keyboard": [
                    [{"text": "'"$BUTTON_TEXT1"'", "url": "'"$BUTTON1_URL"'"}, {"text": "'"$BUTTON_TEXT2"'", "url": "'"$BUTTON2_URL"'"}]
                ]
            }')

    # Cetak respons menggunakan jq untuk pretty-print
    #echo "$RESPONSE" | jq .
}

# --- Validasi Root Access ---
if [[ "${EUID}" -ne 0 ]]; then
    red "Script harus dijalankan sebagai user root!"
    exit 1
fi

# --- Validasi Virtualisasi ---
if [[ "$(systemd-detect-virt)" == "openvz" ]]; then
    red "OpenVZ tidak didukung!"
    exit 1
fi

# --- Konfigurasi Hostname ---
cd /root || exit 1
local_ip=$(hostname -I | cut -d' ' -f1)
host_name=$(hostname)

# Perbaiki file hosts jika diperlukan
if ! grep -q "^${local_ip} ${host_name}" /etc/hosts; then
    echo "${local_ip} ${host_name}" >> /etc/hosts
fi

# --- Fungsi Konversi Waktu ---
secs_to_human() {
    local jam=$(( $1 / 3600 ))
    local menit=$(( ($1 % 3600) / 60 ))
    local detik=$(( $1 % 60 ))
    echo "Waktu instalasi: ${jam} jam ${menit} menit ${detik} detik"
}

# --- Persiapan Direktori ---
rm -rf /etc/julak
mkdir -p /etc/julak
mkdir -p /etc/julak/theme
mkdir -p /var/lib/julak >/dev/null 2>&1
mkdir -p /etc/xray
mkdir -p /root/.info
curl -s ifconfig.me > /etc/xray/ipvps
touch /etc/xray/domain
mkdir -p /var/log/xray
mkdir -p /root/.info
 mkdir -p /etc/user-create
curl -sS "ipinfo.io/org?token=7a814b6263b02c" > /root/.info/.isp
curl "ipinfo.io/city?token=7a814b6263b02c" > /root/.city
chown www-data.www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log
echo "IP=" >> /var/lib/julak/ipvps.conf
echo "echo -e 'Vps Config User Account'" >> /etc/user-create/user.log
clear

# --- Input Nama Pengguna ---
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}      MASUKKAN NAMA KAMU           ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $name =~ ^[a-zA-Z0-9_.-]+$ ]]; do
    read -rp "Masukan Nama Kamu Disini tanpa spasi : " -e name
done
rm -rf /etc/profil
echo "$name" > /etc/profil
echo ""
clear
author=$(cat /etc/profil)
echo ""
echo ""

# --- Fungsi Bar Progres (fun_bar) ---
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mUpdate Domain.. \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mUpdate Domain... \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m Succes !\033[1;37m"
    tput cnorm
}

clear
cd

# --- Pilihan Domain ---
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ \033[1;37mPlease select a your Choice to Set Domain${BIBlue}│${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│  [ 1 ]  \033[1;37mDomain Kamu Sendiri & Domain SlowDNS Kamu Sendiri     ${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
until [[ $domain =~ ^1$ ]]; do
    read -p "    Please select number 1 : " domain
done

if [[ $domain == "1" ]]; then
    clear
    echo " "
    until [[ $dns1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
        echo -e "${BIBlue}══════════════════════════════════════════${NC}"
        read -rp "Masukan domain kamu Disini : " -e dns1
    done
    echo ""
    mkdir -p /etc/xray
    mkdir -p /var/lib/julak >/dev/null 2>&1
    mkdir -p /etc/v2ray
    touch /etc/xray/domain
    touch /etc/v2ray/domain
    echo "$dns1" > /etc/nsdomain
    echo "$dns1" > /etc/xray/domain
    echo "$dns1" > /etc/v2ray/domain
    echo "IP=$dns1" >> /var/lib/julak/ipvps.conf
    clear
    echo " "
    until [[ $dns2 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
        echo -e "${BIBlue}══════════════════════════════════════════${NC}"
        read -rp "Masukan Domain SlowDNS kamu Disini : " -e dns2
    done
    mkdir -p /etc/xray
    touch /etc/xray/nsdomain
    echo "$dns2" > /etc/xray/nsdomain
    echo "$dns2" >/etc/xray/dns
    
fi

# --- Disable IPv6 ---
echo -e "${GREEN}Mematikan IPv6...${NC}"
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p >/dev/null 2>&1

# --- Disable AppArmor (Ubuntu 24.04) ---
echo -e "${GREEN}Mematikan AppArmor...${NC}"
systemctl disable --now apparmor >/dev/null 2>&1
systemctl stop apparmor >/dev/null 2>&1
update-rc.d -f apparmor remove >/dev/null 2>&1 # Ini mungkin tidak ada di semua sistem, tapi aman.
apt-get purge apparmor apparmor-utils -y >/dev/null 2>&1

clear

# --- Instalasi Tools Awal ---
wget https://raw.githubusercontent.com/binglu93/lts2/main/TOOLS/tools.sh -O tools.sh &> /dev/null
chmod +x tools.sh
bash tools.sh
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# --- Update dan Instal Dependensi Umum untuk Ubuntu 24.04 ---
echo -e "${GREEN}Memperbarui sistem dan menginstal dependensi...${NC}"
apt update -y && apt upgrade -y
apt install git curl python3 apt  figlet python3-pip apt-transport-https ca-certificates software-properties-common ntpdate wget netcat-openbsd ncurses-bin chrony jq -y
-y
wget https://github.com/fullstorydev/grpcurl/releases/download/v1.9.1/grpcurl_1.9.1_linux_x86_64.tar.gz -O /tmp/grpcurl.tar.gz && tar -xzf /tmp/grpcurl.tar.gz -C /tmp/ && sudo mv /tmp/grpcurl /usr/local/bin/ && sudo chmod +x /usr/local/bin/grpcurl
wget https://raw.githubusercontent.com/XTLS/Xray-core/main/app/stats/command/command.proto -O stats.proto

cd
clear
wget https://raw.githubusercontent.com/binglu93/lts2/main/TOOLS/limit.sh -O limit.sh && chmod +x limit.sh && ./limit.sh
clear

# --- Fungsi Instalasi Modul ---
res3() {
    echo -e "${GREEN}    Memulai instalasi SSH WS / OpenVPN...${NC}"
    wget https://raw.githubusercontent.com/binglu93/lts2/main/SYSTEM/ssh-vpn.sh -O ssh-vpn.sh
    chmod +x ssh-vpn.sh
    ./ssh-vpn.sh
    sudo systemctl enable --now chrony.service
    sudo systemctl restart chrony.service
    clear
}

res4() {
    echo -e "${GREEN}    Memulai instalasi XRAY...${NC}"
    wget https://raw.githubusercontent.com/binglu93/lts2/main/SYSTEM/ins-xray.sh -O ins-xray.sh
    chmod +x ins-xray.sh
    ./ins-xray.sh
    clear
}

res5() {
    echo -e "${GREEN}    Memulai instalasi WEBSOCKET SSH...${NC}"
    wget https://raw.githubusercontent.com/binglu93/lts2/main/WEBSOCKET/insshws.sh -O insshws.sh
    chmod +x insshws.sh
    ./insshws.sh
    clear
}

res6() {
    echo -e "${GREEN}    Memulai instalasi BACKUP MENU...${NC}"
    wget https://raw.githubusercontent.com/binglu93/lts2/main/SYSTEM/set-br.sh -O set-br.sh
    chmod +x set-br.sh
    ./set-br.sh
    clear
}

res7() {
    echo -e "${GREEN}    Memulai instalasi OHP...${NC}"
    wget https://raw.githubusercontent.com/binglu93/lts2/main/WEBSOCKET/ohp.sh -O ohp.sh
    chmod +x ohp.sh
    ./ohp.sh
    clear
}

res8() {
    echo -e "${GREEN}    Memulai pengunduhan EXTRA MENU...${NC}"
    wget https://raw.githubusercontent.com/rajaganjil93/up/main/lts2/up.sh -O up.sh
    chmod +x up.sh
    ./up.sh
    clear
}

res9() {
    echo -e "${GREEN}    Memulai pengunduhan SLOWDNS...${NC}"
    wget https://raw.githubusercontent.com/binglu93/lts2/main/SYSTEM/slowdns.sh -O slowdns.sh
    chmod +x slowdns.sh
    ./slowdns.sh
    clear
}

res10() {
    echo -e "${GREEN}    Memulai pengunduhan UDP CUSTOM...${NC}"
    wget https://raw.githubusercontent.com/binglu93/lts2/main/SYSTEM/udp-custom.sh -O udp-custom.sh
    chmod +x udp-custom.sh
    bash udp-custom.sh
    clear
}

res11() {
    echo -e "${GREEN}    Mengkonfigurasi Dropbear...${NC}"
    apt install dropbear -y
    sudo sed -i '/^DROPBEAR_PORT=/d' /etc/default/dropbear
    sudo sed -i '/^DROPBEAR_EXTRA_ARGS=/d' /etc/default/dropbear
    echo 'DROPBEAR_PORT=149' | sudo tee -a /etc/default/dropbear
    echo 'DROPBEAR_EXTRA_ARGS="-p 50000 -p 109 -p 110 -p 69 -b /etc/julak.txt"' | sudo tee -a /etc/default/dropbear

    sudo mkdir -p /etc/dropbear/
    sudo dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key
    sudo dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
    sudo chmod 600 /etc/dropbear/dropbear_dss_host_key
    sudo chmod 600 /etc/dropbear/dropbear_rsa_host_key
    sudo chown root:root /etc/dropbear/dropbear_dss_host_key
    sudo chown root:root /etc/dropbear/dropbear_rsa_host_key
    sed -i 's/^NO_START=.*/NO_START=0/' /etc/default/dropbear
    sudo systemctl daemon-reload
    sudo systemctl restart dropbear
     sudo systemctl enable nginx
    clear
}
res12() {
    echo -e "${GREEN}   Mengatur jadwal reboot harian...${NC}"
    
    # Definisikan cron job yang ingin ditambahkan
    REBOOT_JOB="0 0 * * * /sbin/reboot"

    # Periksa apakah cron job tersebut sudah ada
    if ! sudo crontab -l | grep -Fxq "$REBOOT_JOB"; then
        # Jika TIDAK ADA, maka tambahkan
        (sudo crontab -l 2>/dev/null; echo "$REBOOT_JOB") | sudo crontab -
        echo -e "${GREEN}   -> Jadwal reboot otomatis setiap jam 12 malam telah berhasil ditambahkan.${NC}"
    else
        # Jika SUDAH ADA, beri pesan dan jangan lakukan apa-apa
        echo -e "${YELLOW}   -> Jadwal reboot otomatis sudah ada, tidak ada yang diubah.${NC}"
    fi
}
res13() {
    echo -e "${GREEN}   Mengatur jadwal update kuota otomatis...${NC}"
    
    # Definisikan cron job yang ingin ditambahkan (setiap 1 menit)
    # Redirect output >/dev/null 2>&1 agar tidak membuat log spam
    USAGE_JOB="*/1 * * * * /usr/bin/update-usage.sh >/dev/null 2>&1"

    # Periksa apakah cron job tersebut sudah ada
    if ! sudo crontab -l | grep -Fxq "$USAGE_JOB"; then
        # Jika TIDAK ADA, maka tambahkan
        (sudo crontab -l 2>/dev/null; echo "$USAGE_JOB") | sudo crontab -
        echo -e "${GREEN}   -> Jadwal update kuota setiap 1 menit telah berhasil ditambahkan.${NC}"
    else
        # Jika SUDAH ADA, beri pesan dan jangan lakukan apa-apa
        echo -e "${YELLOW}   -> Jadwal update kuota otomatis sudah ada, tidak ada yang diubah.${NC}"
    fi
}


# --- Proses Instalasi JULAK VPN ---
function JULAKINSTALL(){
    echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
    echo -e "${BIBlue}│ ${BGCOLOR}    PROCESS INSTALLED SSH WS / OPENVPN    ${NC}${BIBlue} │${NC}"
    echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
    res3

    echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
    echo -e "${BIBlue}│ ${BGCOLOR}        PROCESS INSTALLED XRAY          ${NC}${BIBlue} │${NC}"
    echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
    res4

    echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
    echo -e "${BIBlue}│ ${BGCOLOR}    PROCESS INSTALLED WEBSOCKET SSH   ${NC}${BIBlue} │${NC}"
    echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
    res5

    echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
    echo -e "${BIBlue}│ ${BGCOLOR}    PROCESS INSTALLED BACKUP MENU     ${NC}${BIBlue} │${NC}"
    echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
    res6

    echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
    echo -e "${BIBlue}│ ${BGCOLOR}        PROCESS INSTALLED OHP         ${NC}${BIBlue} │${NC}"
    echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
    res7

    echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
    echo -e "${BIBlue}│ ${BGCOLOR}        DOWNLOAD EXTRA MENU           ${NC}${BIBlue} │${NC}"
    echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
    res8

    echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
    echo -e "${BIBlue}│ ${BGCOLOR}        DOWNLOAD SLOWDNS              ${NC}${BIBlue} │${NC}"
    echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
    res9

    echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
    echo -e "${BIBlue}│ ${BGCOLOR}        DOWNLOAD UDP COSTUM           ${NC}${BIBlue} │${NC}"
    echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
    res10
    
    echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
    echo -e "${BIBlue}│ ${BGCOLOR}    CONFIGURING DROPBEAR              ${NC}${BIBlue} │${NC}"
    echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
    res11

    echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
    echo -e "${BIBlue}│ ${BGCOLOR}  ATUR JADWAL REBOOT              ${NC}${BIBlue} │${NC}"
    echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
    res12
}
JULAKINSTALL # Memanggil fungsi SKT4100

# --- Konfigurasi Post-Instalasi ---
# Pastikan file /home/re_otm ada dan berikan nilai default jika tidak
if [ ! -f "/home/re_otm" ]; then
    echo "0" > /home/re_otm
fi

cat > /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
mukung
END
chmod 644 /root/.profile

# Bersihkan file log instalasi sebelumnya
if [ -f "/root/log-install.txt" ]; then
    rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
    rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
    echo "Log All Account " > /etc/log-create-user.log
fi
history -c

serverV=$( curl -sS https://raw.githubusercontent.com/binglu93/lts2/main/TOOLS/versi )
echo "$serverV" > /opt/.ver

aureb=$(cat /home/re_otm)
b=11
if [ "$aureb" -gt "$b" ]
then
    gg="PM"
else
    gg="AM"
fi
cd

# --- Pengambilan Info Server & Pembersihan File ---
curl -sS ifconfig.me > /etc/myipvps
rm /root/v2.sh >/dev/null 2>&1
rm /root/slhost.sh >/dev/null 2>&1
rm /root/ssh-vpn.sh >/dev/null 2>&1
rm /root/ins-xray.sh >/dev/null 2>&1
rm /root/insshws.sh >/dev/null 2>&1
rm /root/set-br.sh >/dev/null 2>&1
rm /root/ohp.sh >/dev/null 2>&1
rm /root/update.sh >/dev/null 2>&1
rm /root/slowdns.sh >/dev/null 2>&1
rm /root/udp-custom.sh >/dev/null 2>&1 # Hapus file udp-custom.sh setelah digunakan

# --- Pembuatan Direktori Bot dan Limit ---
rm -rf /etc/per
mkdir -p /etc/per
touch /etc/per/id
touch /etc/per/token
rm -rf /etc/bot
mkdir -p /etc/bot
mkdir -p /etc/limit/vmess
mkdir -p /etc/limit/vless
mkdir -p /etc/limit/trojan
mkdir -p /etc/vmess
mkdir -p /etc/vless
mkdir -p /etc/trojan
touch /etc/bot/.bot.db
touch /etc/vless/.vless.db
touch /etc/vmess/.vmess.db
touch /etc/vmess/.trojan.db
touch /etc/typexray
touch /etc/waktulock
sudo chmod 755 /home/vps
sudo find /home/vps/public_html -type f -exec chmod 644 {} \;
sudo find /home/vps/public_html -type d -exec chmod 755 {} \;
sudo chown -R www-data:www-data /home/vps/public_html
mkdir -p /etc/julak/limit/vmess/ip
mkdir -p /etc/julak/limit/vless/ip
mkdir -p /etc/julak/limit/trojan/ip
mkdir -p /etc/julak/limit/ssh/ip
# --- Log Waktu Instalasi ---
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
sleep 3
echo ""
cd

# --- Kirim Pesan Sukses ke Telegram ---
IPVPS=$(curl -s https://ipinfo.io/ip)
HOSTNAME=$(hostname)
USERVPS=$(whoami)
OS=$(lsb_release -d | awk -F"\t" '{print $2}')
ISP=$(curl -s https://ipinfo.io/org | awk '{print $2,$3,$4}')
USER=$client_name
REGION=$(curl -s ipinfo.io/region)
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')
DOMAIN=$(cat /etc/xray/domain)
exp_date=$(echo "$permission_file" | grep -w "$client_name" | awk '{print $3}')

MESSAGE="\`\`\`
❏━━━━━━━━━━━━━━━━━━━━━━━━━━❏
 🤖 Julak Bantur lts Project 🤖
❏━━━━━━━━━━━━━━━━━━━━━━━━━━❏
❖ SCRIPT      : LTS2 SCRIPT
❖ User VPS    : $USERVPS
❖ User SC     : $USER
❖ HOST VPS    : $HOSTNAME
❖ Linux OS    : $OS
❖ ISP         : $ISP
❖ IP VPS      : $IPVPS
❖ Area ISP    : $REGION
❖ Waktu       : $TIME
❖ Tanggal     : $DATE
❖ Domain      : $DOMAIN
❖ Expired     : $exp_date
❏━━━━━━━━***************━━━━━━━━━❏
👑 Dev https://t.me/rajaganjil93 👑
❏━━━━━━━******************━━━━━━━━❏
\`\`\`"

send_telegram_message "$MESSAGE"
clear
sleep 2

# --- Selesai Instalasi dan Reboot ---
echo -e "${BIBlue}════════════════════════════════════════${NC}"
echo -e "${BIBlue} Script telah berhasil di install"
rm -rf *
#!/bin/bash
echo -e ""
echo -e "❏━━━━━━━━━━━✦ SYSTEM NOTICE ✦━━━━━━━━━━━❏"
echo -e "\e[1;31m⚠️ Reboot dulu supaya jangan error cayang \e[0m"
echo -e "❏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❏"
echo -en "\e[1;36m[default y](y/n)?\e[0m > "

# Baca input user
read -r answer

# Cek input
if [[ "$answer" =~ ^[Nn]$ ]]; then
    echo -e "\n❌ Reboot dibatalkan oleh user."
    exit 0
else
    echo -e "\n🔄 Melakukan reboot sistem..."
    sleep 1
    cat /dev/null > ~/.bash_history && history -c
    reboot
fi
