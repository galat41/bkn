cat isi_asli
#!/bin/bash

# Install curl if not installed
apt update && apt install curl -y

# Download the reinstall script
curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh

# Define colors
YELLOW='\033[1;33m'
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[0;36m';
BLUE='\033[1;34m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Print main menu
print_main_menu() {
  clear
  echo -e "${YELLOW}###########################################${NC}"
  echo -e "${YELLOW}#####${CYAN}       Easy Rebuild VPS v8.0     ${YELLOW}#####${NC}"
  echo -e "${YELLOW}#####${WHITE}        JULAK BANTUR           ${YELLOW}#####${NC}"
  echo -e "${YELLOW}###########################################${NC}"
  echo -e ""
  echo -e "${RED}Pilih opsi dibawah :${NC}"
  echo -e "[ ${GREEN}1${NC} ] Debian"
  echo -e "[ ${GREEN}2${NC} ] Ubuntu"
  echo -e "[ ${GREEN}3${NC} ] Change source list"
  echo -e "[ ${GREEN}x${NC} ] Exit"
  echo -e ""
}

# Print Debian menu
print_debian_menu() {
  clear
  echo -e "${YELLOW}###########################################${NC}"
  echo -e "${YELLOW}#####${GREEN}        Debian Installer         ${YELLOW}#####${NC}"
  echo -e "${YELLOW}###########################################${NC}"
  echo -e "[ ${GREEN}1${NC} ] Install Debian 10"
  echo -e "[ ${GREEN}2${NC} ] Install Debian 11"
  echo -e "[ ${GREEN}3${NC} ] Install Debian 12"
  echo -e "[ ${GREEN}x${NC} ] Back to main menu"
  echo -e ""
}

# Print Ubuntu menu
print_ubuntu_menu() {
  clear
  echo -e "${YELLOW}###########################################${NC}"
  echo -e "${YELLOW}#####${GREEN}        Ubuntu Installer         ${YELLOW}#####${NC}"
  echo -e "${YELLOW}###########################################${NC}"
  echo -e "[ ${GREEN}1${NC} ] Install Ubuntu 20.04"
  echo -e "[ ${GREEN}2${NC} ] Install Ubuntu 22.04"
  echo -e "[ ${GREEN}3${NC} ] Install Ubuntu 24.04"
  echo -e "[ ${GREEN}x${NC} ] Back to main menu"
  echo -e ""
}

# Print Change Source List menu
print_change_source_menu() {
  clear
  echo -e "${YELLOW}###########################################${NC}"
  echo -e "${YELLOW}#####${GREEN}      Change Source List         ${YELLOW}#####${NC}"
  echo -e "${YELLOW}###########################################${NC}"
  echo -e "[ ${GREEN}1${NC} ] Change source list for Debian 10"
  echo -e "[ ${GREEN}2${NC} ] Change source list for Debian 11"
  echo -e "[ ${GREEN}3${NC} ] Change source list for Debian 12"
  echo -e "[ ${GREEN}4${NC} ] Change Repo Kartolo for Debian 10"
  echo -e "[ ${GREEN}5${NC} ] Change Repo Kartolo for Debian 11"
  echo -e "[ ${GREEN}6${NC} ] Change Repo Buaya for Ubuntu 20"
  echo -e "[ ${GREEN}x${NC} ] Back to main menu"
  echo -e ""
}

# Function to handle Debian installation
handle_debian() {
  while true; do
    print_debian_menu
    read -p "Pilih versi Debian: " debian_choice
    case $debian_choice in
      1) bash reinstall.sh debian 10; break ;;
      2) bash reinstall.sh debian 11; break ;;
      3) bash reinstall.sh debian 12; break ;;
      x) return ;;
      *) echo "Pilihan tidak valid, coba lagi." ;;
    esac
  done
  clear
  show_credentials
  prompt_reboot
}

# Function to handle Ubuntu installation
handle_ubuntu() {
  while true; do
    print_ubuntu_menu
    read -p "Pilih versi Ubuntu: " ubuntu_choice
    case $ubuntu_choice in
      1) bash reinstall.sh ubuntu 20.04; break ;;
      2) bash reinstall.sh ubuntu 22.04; break ;;
      3) bash reinstall.sh ubuntu 24.04; break ;;
      x) return ;;
      *) echo "Pilihan tidak valid, coba lagi." ;;
    esac
  done
  clear
  show_credentials
  prompt_reboot
}

# Function to handle changing the source list for Debian
handle_change_source_list() {
  while true; do
    print_change_source_menu
    read -p "Pilih versi Debian untuk mengubah sources.list: " source_choice
    case $source_choice in
      1) change_source_list_debian10; break ;;
      2) change_source_list_debian11; break ;;
      3) change_source_list_debian12; break ;;
      4) change_repo_kartolo_debian10; break ;;
      5) change_repo_kartolo_debian11; break ;;
      6) change_repo_buaya_ubuntu20; break ;;
      x) return ;;
      *) echo "Pilihan tidak valid, coba lagi." ;;
    esac
  done
}

# Function to change source list for Debian 10
change_source_list_debian10() {
  cp /etc/apt/sources.list /etc/apt/sources.list.backup

  cat <<EOF > /etc/apt/sources.list.new
# Debian Main repository
deb http://httpredir.debian.org/debian buster main
deb-src http://httpredir.debian.org/debian buster main

# Debian Security repository
deb http://httpredir.debian.org/debian-security buster/updates main
deb-src http://httpredir.debian.org/debian-security buster/updates main

# Debian Updates repository
deb http://httpredir.debian.org/debian buster-updates main
deb-src http://httpredir.debian.org/debian buster-updates main

# Optional: Include contrib and non-free sections
deb http://httpredir.debian.org/debian buster contrib non-free
deb-src http://httpredir.debian.org/debian buster contrib non-free
EOF

  mv /etc/apt/sources.list.new /etc/apt/sources.list
  apt update
  echo "Sources list updated to use httpredir for Debian 10 (Buster)."
}

# Function to change source list for Debian 11
change_source_list_debian11() {
  cp /etc/apt/sources.list /etc/apt/sources.list.backup

  cat <<EOF > /etc/apt/sources.list.new
# Debian Main repository
deb http://httpredir.debian.org/debian bullseye main
deb-src http://httpredir.debian.org/debian bullseye main

# Debian Security repository
deb http://httpredir.debian.org/debian-security bullseye-security main
deb-src http://httpredir.debian.org/debian-security bullseye-security main

# Debian Updates repository
deb http://httpredir.debian.org/debian bullseye-updates main
deb-src http://httpredir.debian.org/debian bullseye-updates main

# Optional: Include contrib and non-free sections
deb http://httpredir.debian.org/debian bullseye contrib non-free
deb-src http://httpredir.debian.org/debian bullseye contrib non-free
EOF

  mv /etc/apt/sources.list.new /etc/apt/sources.list
  apt update
  echo "Sources list updated to use httpredir for Debian 11 (Bullseye)."
}

# Function to change source list for Debian 12
change_source_list_debian12() {
  cp /etc/apt/sources.list /etc/apt/sources.list.backup

  cat <<EOF > /etc/apt/sources.list.new
# Debian Main repository
deb http://httpredir.debian.org/debian bookworm main
deb-src http://httpredir.debian.org/debian bookworm main

# Debian Security repository
deb http://httpredir.debian.org/debian-security bookworm-security main
deb-src http://httpredir.debian.org/debian-security bookworm-security main

# Debian Updates repository
deb http://httpredir.debian.org/debian bookworm-updates main
deb-src http://httpredir.debian.org/debian bookworm-updates main

# Optional: Include contrib and non-free sections
deb http://httpredir.debian.org/debian bookworm contrib non-free
deb-src http://httpredir.debian.org/debian bookworm contrib non-free
EOF

  mv /etc/apt/sources.list.new /etc/apt/sources.list
  apt update
  echo "Sources list updated to use httpredir for Debian 12 (Bookworm)."
}

# Function to change repo kartolo deb10
change_repo_kartolo_debian10() {
  cp /etc/apt/sources.list /etc/apt/sources.list.backup

  cat <<EOF > /etc/apt/sources.list.new
deb http://kartolo.sby.datautama.net.id/debian/ buster main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ buster-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ buster/updates main contrib non-free
EOF

  mv /etc/apt/sources.list.new /etc/apt/sources.list
  apt update
  echo "Sources list updated to kartolo debian 10."
}

# Function to change repo kartolo deb11
change_repo_kartolo_debian11() {
  cp /etc/apt/sources.list /etc/apt/sources.list.backup

  cat <<EOF > /etc/apt/sources.list.new
deb http://kartolo.sby.datautama.net.id/debian bullseye main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian bullseye-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security bullseye-security main contrib non-free
EOF

  mv /etc/apt/sources.list.new /etc/apt/sources.list
  apt update
  echo "Sources list updated to kartolo debian 11."
}

# Function to change repo buaya ubuntu20
change_repo_buaya_ubuntu20() {
  cp /etc/apt/sources.list /etc/apt/sources.list.backup

  cat <<EOF > /etc/apt/sources.list.new
deb https://buaya.klas.or.id/ubuntu/ focal main restricted universe multiverse
deb https://buaya.klas.or.id/ubuntu/ focal-updates main restricted universe multiverse
deb https://buaya.klas.or.id/ubuntu/ focal-security main restricted universe multiverse
deb https://buaya.klas.or.id/ubuntu/ focal-backports main restricted universe multiverse
deb https://buaya.klas.or.id/ubuntu/ focal-proposed main restricted universe multiverse
EOF

  mv /etc/apt/sources.list.new /etc/apt/sources.list
  apt update
  echo "Sources list updated to buaya ubuntu 20."
}

# Function to show credentials
show_credentials() {
  echo -e "\n${RED}Install Successfully !${NC}"
  echo -e "${YELLOW}Username :${NC} root"
  echo -e "${YELLOW}Password :${NC} ********\n"
  echo -e "${GREEN}Install VPS akan memakan waktu 10 menitan${NC}\n"
}

# Function to prompt for reboot
prompt_reboot() {
  while true; do
    echo -e "${RED}➽ Reboot VPS nya yuk biar sukses! (y/n):${NC} "
    read reboot_choice
    case $reboot_choice in
      y|Y) reboot; break ;;
      n|N) exit 0 ;;
      *) echo "➽ Pilihan tidak valid, coba lagi." ;;
    esac
  done
}

# Main loop
while true; do
  print_main_menu
  read -p "Pilihan OS Kamu: " os_choice
  case $os_choice in
    1) handle_debian ;;
    2) handle_ubuntu ;;
    3) handle_change_source_list ;;
    x) exit 0 ;;
    *) echo "Pilihan tidak valid, coba lagi." ;;
  esac
done

