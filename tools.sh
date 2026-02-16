#!/bin/bash
set -eo pipefail

# Color definitions
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
NC='\e[0m'

# Output functions
error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
progress() { echo -e "${YELLOW}[PROGRESS]${NC} $1"; }

# Initialize system
clear
progress "Starting system configuration..."
sleep 2

# Detect OS and network interface
detect_os() {
    if [[ -e /etc/debian_version ]]; then
        source /etc/os-release
        OS="$ID"
    elif [[ -e /etc/centos-release ]]; then
        OS="centos"
    else
        error "Unsupported operating system"
        exit 1
    fi
    export NET=$(ip route get 1.1.1.1 | awk '{print $5}' | head -1)
}

# System preparation
prepare_system() {
    progress "Updating system packages..."
    apt-get update -qq
    apt-get full-upgrade -y -qq
    
    progress "Removing conflicting packages..."
    apt-get purge -y -qq ufw firewalld exim4
}

# Package installation
install_dependencies() {
    progress "Installing core dependencies..."
    apt-get install -y -qq \
        sudo python3 screen curl jq git lsof \
        build-essential libpam0g-dev libcurl4-nss-dev \
        openssl openvpn easy-rsa fail2ban tmux \
        stunnel4 squid dropbear socat chrony \
        net-tools dnsutils lsb-release neofetch \
        libnss3-dev libnspr4-dev libsqlite3-dev \
        xl2tpd pptpd vnstat
}

# Configure vnstat
configure_vnstat() {
    progress "Configuring network monitoring..."
    if ! command -v vnstat &>/dev/null; then
        warning "Installing vnstat from source..."
        wget -q https://humdi.net/vnstat/vnstat-2.6.tar.gz
        tar zxf vnstat-2.6.tar.gz
        pushd vnstat-2.6 >/dev/null
        ./configure --prefix=/usr --sysconfdir=/etc >/dev/null
        make >/dev/null && make install >/dev/null
        popd >/dev/null
        rm -rf vnstat-2.6*
    fi

    sed -i "s/Interface \"eth0\"/Interface \"${NET}\"/g" /etc/vnstat.conf
    chown -R vnstat:vnstat /var/lib/vnstat
    systemctl enable vnstat
    systemctl restart vnstat
}

# Main execution flow
main() {
    detect_os
    prepare_system
    install_dependencies
    configure_vnstat

    success "All dependencies successfully installed!"
    progress "Cleaning up..."
    apt-get autoremove -y -qq
    apt-get clean -y
    sleep 3
    clear
}
