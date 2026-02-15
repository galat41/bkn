#!/bin/bash
set -e

echo "=== Dropbear Auto Installer ==="

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot detect OS"
    exit 1
fi

if [[ "$OS" != "ubuntu" && "$OS" != "debian" ]]; then
    echo "Unsupported OS: $OS"
    exit 1
fi

echo "Detected OS: $PRETTY_NAME"

# Install dropbear
apt update -y
apt install -y dropbear

# Backup config
CFG="/etc/default/dropbear"
cp $CFG ${CFG}.bak.$(date +%s)

# Write clean config
cat > $CFG << 'EOF'
NO_START=0
DROPBEAR_PORT=143
DROPBEAR_EXTRA_ARGS="-p 109 -p 110 -p 50000 -p 69"
EOF

# Ensure shells exist
grep -qxF /bin/false /etc/shells || echo /bin/false >> /etc/shells
grep -qxF /usr/sbin/nologin /etc/shells || echo /usr/sbin/nologin >> /etc/shells

# Generate host keys if missing
mkdir -p /etc/dropbear
[ -f /etc/dropbear/dropbear_rsa_host_key ] || dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
[ -f /etc/dropbear/dropbear_ecdsa_host_key ] || dropbearkey -t ecdsa -f /etc/dropbear/dropbear_ecdsa_host_key
[ -f /etc/dropbear/dropbear_ed25519_host_key ] || dropbearkey -t ed25519 -f /etc/dropbear/dropbear_ed25519_host_key

# Restart service
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable dropbear
systemctl restart dropbear

# Status
echo ""
systemctl status dropbear --no-pager
echo ""
echo "Dropbear installed & running ✔"
echo "Ports: 143, 109, 110, 50000, 69"
