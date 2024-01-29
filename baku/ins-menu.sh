#!/bin/bash
# //====================================================
# //	System Request:Debian 9+/Ubuntu 18.04+/20+
# //	Author:	Julak Bantur
# //	Dscription: Xray Menu Management
# //	email: putrameratus2@gmail.com
# //  telegram: https://t.me/Cibut2d
# //====================================================
# // font color configuration | JULAK BANTUR AUTOSCRIPT
###########- COLOR CODE -##############
NC="\e[0m"
RED="\033[0;31m"
grenbo="\e[92;1m"
GRENN="\e[92;1m"
WC='\033[0m'
WH='\033[1;37m'
###########- END COLOR CODE -##########

clear
    wget https://raw.githubusercontent.com/galat41/bkn/main/purut/menu.zip
    unzip menu.zip
    chmod +x menu/*
    mv menu/* /usr/bin
    rm -rf menu
    rm -rf menu.zip
