#!/bin/bash
#installer Websocker Proxy sll ovpn
# Mod By Julak Bantur

# --- Pastikan Ada di halaman root --- #
cd

# --- Install ssh Websocket --- #
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/galat41/bkn/main/baku/dropbear-ws.py
wget -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/galat41/bkn/main/baku/ws-stunnel

# --- izin akses ssh websocket --- #
chmod +x /usr/local/bin/ws-dropbear
chmod +x /usr/local/bin/ws-stunnel

# --- Buat Service untuk ssh websocket supaya auto jalan --- #
wget -O /etc/systemd/system/ws-dropbear.service https://raw.githubusercontent.com/galat41/bkn/main/baku/service-wsdropbear && chmod +x /etc/systemd/system/ws-dropbear.service
wget -O /etc/systemd/system/ws-stunnel.service https://raw.githubusercontent.com/galat41/bkn/main/baku/ws-stunnel.service && chmod +x /etc/systemd/system/ws-stunnel.service

# --- Start dan restart semua websocket service --- #
systemctl daemon-reload
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service
systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
systemctl restart ws-stunnel.service
