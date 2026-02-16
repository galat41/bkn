#!/usr/bin/env bash
# tools.sh — upgraded & cleaned
# Author: upgraded by bro 🤝

set -e

clear

# ===== Colors =====
RED='\033[31;1m'
GREEN='\033[32;1m'
YELLOW='\033[33;1m'
NC='\033[0m'

green()  { echo -e "${GREEN}$*${NC}"; }
red()    { echo -e "${RED}$*${NC}"; }
yellow() { echo -e "${YELLOW}$*${NC}"; }

# ===== Root Check =====
if [[ $EUID -ne 0 ]]; then
  red "Please run as root!"
  exit 1
fi

# ===== OS Detection =====
if [[ -e /etc/os-release ]]; then
  source /etc/os-release
  OS=$ID
else
  red "Cannot detect OS!"
  exit 1
fi

if [[ "$OS" != "debian" && "$OS" != "ubuntu" ]]; then
  red "This script only supports Debian/Ubuntu"
  exit 1
fi

green "Detected OS: $OS"
sleep 1

# ===== Network Interface =====
NET=$(ip -o -4 route show to default | awk '{print $5}')
if [[ -z "$NET" ]]; then
  red "Network interface not found!"
  exit 1
fi
green "Using network interface: $NET"

# ===== Update System =====
yellow "Updating system..."
apt update -y
apt dist-upgrade -y

# ===== Remove Unused Services =====
yellow "Removing unnecessary services..."
apt purge -y ufw firewalld exim4 || true

# ===== Base Packages =====
yellow "Installing base packages..."
apt install -y \
  screen curl jq bzip2 gzip coreutils rsyslog iftop htop \
  zip unzip net-tools sed bc sudo build-essential dirmngr \
  libxml-parser-perl neofetch screenfetch git lsof \
  openssl openvpn easy-rsa fail2ban tmux \
  stunnel4 vnstat squid dropbear \
  libsqlite3-dev socat cron bash-completion ntpdate \
  xz-utils dnsutils lsb-release chrony \
  apt-transport-https ca-certificates gnupg gnupg2

# ===== NodeJS =====
yellow "Installing NodeJS 16..."
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt install -y nodejs

# ===== vnStat Upgrade =====
yellow "Upgrading vnStat..."
systemctl stop vnstat || true

cd /tmp
wget -q https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar xzf vnstat-2.6.tar.gz
cd vnstat-2.6

./configure --prefix=/usr --sysconfdir=/etc >/dev/null
make -j$(nproc) >/dev/null
make install >/dev/null

vnstat -u -i "$NET"
sed -i "s/^Interface.*/Interface \"$NET\"/" /etc/vnstat.conf

chown -R vnstat:vnstat /var/lib/vnstat
systemctl enable vnstat
systemctl restart vnstat

rm -rf /tmp/vnstat-2.6*

# ===== VPN / PPP Dependencies =====
yellow "Installing VPN & PPP dependencies..."
apt install -y \
  libnss3-dev libnspr4-dev pkg-config libpam0g-dev \
  libcap-ng-dev libcap-ng-utils libselinux1-dev \
  libcurl4-nss-dev flex bison make \
  libnss3-tools libevent-dev xl2tpd pptpd

green "All dependencies successfully installed 🚀"
sleep 2
clear

neofetch || true
